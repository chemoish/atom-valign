operator_helper = require '../helper/operator'

class Base
  constructor: (@text_editor) ->

  formatMatchingBlock: (block) ->
    {configuration} = block_setting = this.getBlockSetting block

    for row, line of block
      continue if line.is_comment

      {
        line_indentation
        spaces_alignment
        spaces_operator
      } = this.getLineSetting line, block_setting

      text = line.line_text

      # at least one white space left of operator
      if configuration.padding in ['left', 'both']
        padding = ' '
      else
        padding = ''

      text = text.replace(new RegExp("[ ]*(\\#{line.operator})"), "#{padding}$1")

      # at least one white space right of operator
      if configuration.padding in ['right', 'both']
        padding = ' '
      else
        padding = ''

      text = text.replace(new RegExp("(\\#{line.operator})[ ]*"), "$1#{padding}")

      # pad right of operator
      if configuration.align is 'left'
        text = text.replace(new RegExp("(\\#{line.operator})([ ]*)"), "#{spaces_operator}$1$2#{spaces_alignment}")

      # pad left of operator
      if configuration.align is 'right'
        text = text.replace(new RegExp("([ ]*)(\\#{line.operator})"), "#{spaces_alignment}$1#{spaces_operator}$2")

      line.line_text = text

    return block

  getBlockConfiguration: (block) ->
    for row, line of block
      base_operator = operator_helper.getBaseOperator line.operator

      break if base_operator?

    return atom.config.get "valign.#{base_operator}"

  getBlockSetting: (block) ->
    block_indentation   = this.getMaxOperatorIndentationForBlock block
    block_operator_size = this.getMaxOperatorSizeForBlock block
    configuration       = this.getBlockConfiguration block

    return {
      block_indentation
      block_operator_size
      configuration
    }

  getLineSetting: (line, block_setting) ->
    {
      block_indentation
      block_operator_size
    } = block_setting

    line_indentation = this.getOperatorIndentationForLine line

    spaces_alignment = this.getSpaces(block_indentation - line_indentation)
    spaces_operator  = this.getSpaces(block_operator_size - line.operator.length)

    return {
      line_indentation
      spaces_alignment
      spaces_operator
    }

  getMaxOperatorSizeForBlock: (block) ->
    size = []

    for row, line of block
      continue if line.is_comment

      size.push line.operator.length

    size.sort (a, b) ->
      return a > b

    return size.pop()

  getMaxOperatorIndentationForBlock: (block) ->
    indentation = []

    for row, line of block
      continue if line.is_comment

      indentation.push this.getOperatorIndentationForLine line

    indentation.sort (a, b) ->
      return a > b

    return indentation.pop()

  getOperatorIndentationForLine: (line) ->
    match = line.line_text.match("(.*?)([ ]*)\\#{line.operator}")

    return match?[1]?.length or 0

  getSpaces: (number) ->
    array = new Array(number + 1)

    return array.join ' '

module.exports = Base
