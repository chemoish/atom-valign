operator_helper = require '../helper/operator'

class Base
  constructor: (@text_editor) ->

  findMatchingBlock: ->
    row = @text_editor.getCursorBufferPosition()?.row

    return @findMatchingBlockForRow row

  findMatchingBlockForRow: (row) ->
    block = {}

    return block unless row?

    active_configuration = @getLineConfigurationForRow row

    return block unless active_configuration and active_configuration.operator?

    block[row] = active_configuration

    previous_row = row - 1
    next_row     = row + 1

    # previous row search
    current_configuration = @getLineConfigurationForRow previous_row

    while @isRowValid current_configuration, active_configuration
      # add row
      block[previous_row] = current_configuration

      previous_row -= 1

      current_configuration = @getLineConfigurationForRow previous_row

    # next row search
    current_configuration = @getLineConfigurationForRow next_row

    while @isRowValid current_configuration, active_configuration
      # add row
      block[next_row] = current_configuration

      next_row += 1

      current_configuration = @getLineConfigurationForRow next_row

    # block = @sanitizeBlock block

    return block

  getIndentationForRow: (row) ->
    return {
      level:      @text_editor.indentationForBufferRow row
      soft_tabs:  @text_editor.getSoftTabs()
      tab_length: @text_editor.getTabLength()
      tab_text:   @text_editor.getTabText()
    }

  getLineConfigurationForRow: (row) ->
    line_text = @text_editor.lineTextForBufferRow row

    # in the case where the row is outside the boundas of the file
    return undefined unless line_text

    indentation = @getIndentationForRow row

    is_comment = @text_editor.isBufferRowCommented row

    operator = @getOperatorForLineText line_text

    tokens = @text_editor.getGrammar().tokenizeLine(line_text).tokens

    return {
      indentation
      is_comment
      line_text
      operator
      tokens
    }

  getOperatorForLineText: (line_text) ->
    return operator_helper.getOperatorFromText line_text

    tokens = @text_editor.getGrammar().tokenizeLine(line_text).tokens

    for token in tokens
      for scope in token.scopes
        return token.value if scope.match('operator')?

    return undefined

  isRowValid: (current_configuration, active_configuration) ->
    return false unless current_configuration?

    return true if current_configuration.is_comment

    current_operator = current_configuration?.operator
    active_operator = active_configuration?.operator

    return false unless current_operator?

    return false unless operator_helper.hasMatch current_operator, active_operator

    return false if current_configuration.indentation.level isnt active_configuration.indentation.level

    return true

  ##
  # @name Sanitize Block
  # @description
  # Remove extracted comment lines
  ##
  sanitizeBlock: (block) ->
    for row, line of block
      delete block[row] if line.is_comment is true

    return block

module.exports = Base
