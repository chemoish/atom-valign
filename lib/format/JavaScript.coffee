javascript_helper = require '../helper/javascript'

Base = require './Base'

class JavaScript extends Base
  constructor: (@text_editor) ->

  formatMatchingBlock: (block) ->
    row = @text_editor.getCursorBufferPosition()?.row

    return super unless javascript_helper.isActiveRowAssignment block[row]

    for row, line of block
      if javascript_helper.isLineModifier line
        line_modifier = line

      if not javascript_helper.isLineModifier(line) and line_modifier?
        indentation = this.getIndentationForLine line, line_modifier

        text = line.line_text

        text = text.replace(/^([\s]*)/, indentation)

        line.line_text = text

      if javascript_helper.isLineTerminator line
        line_modifier = null

    return super

  getIndentation: (indentation, number) ->
    array = new Array(number + 1)

    return array.join(indentation)

  getIndentationForLine: (line, line_modifier) ->
    # 2 level difference of 2 tab length
    if line.indentation.tab_length is 2
      level = 2

    # 1 level difference of 4 tab length
    else if line.indentation.tab_length is 4
      level = 1

    return '' unless line.indentation.level >= line_modifier.indentation.level

    return this.getIndentation(line.indentation.tab_text, level)

module.exports = JavaScript
