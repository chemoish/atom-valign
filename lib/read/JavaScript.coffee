extend = require 'extend'

javascript_helper = require '../helper/javascript'

Base = require './Base'

class Javascript extends Base
  findMatchingBlock: ->
    block = super

    row = @text_editor.getCursorBufferPosition()?.row

    return block unless javascript_helper.isActiveRowAssignment block[row]

    rows = (row for row, line of block).sort (a, b) ->
      return a - b

    first_row = parseInt(rows.slice(0, 1))
    first_line = block[first_row]

    last_row = parseInt(rows.slice(-1))
    last_line = block[last_row]

    previous_row = first_row - 1
    next_row = last_row + 1

    if not javascript_helper.isLineModifier(first_line) and previous_row >= 0
      previous_block = @findMatchingBlockForRow previous_row

      previous_block = {} if (
        javascript_helper.hasValidBlockIndentation(previous_block, block) is false or
        javascript_helper.isActiveRowAssignment(previous_block[previous_row]) is false
      )

    if not javascript_helper.isLineTerminator(last_line) and next_row <= @text_editor.getLastBufferRow()
      next_block = @findMatchingBlockForRow next_row

      next_block = {} if (
        javascript_helper.hasValidBlockIndentation(block, next_block) is false or
        javascript_helper.isActiveRowAssignment(next_block[next_row]) is false
      )

    return extend block, previous_block, next_block

module.exports = Javascript
