SCOPES =
  DELIMITER:  'meta.delimiter.object.comma.js'
  MODIFIER:   'storage.modifier.js'
  TERMINATOR: 'punctuation.terminator.statement.js'

module.exports =
  ###
  # @name Has Valid Block Indentation
  # @description
  # Ensure that the difference between each block is some indentation of 4 to account
  # for the `var `.
  #
  # @example
  # var one = 'one',
  #     two = 'two';
  ###

  hasValidBlockIndentation: (block_one, block_two) ->
    for row, first_line of block_one
      break

    for row, second_line of block_two
      break

    return unless first_line?.indentation?.tab_text is second_line?.indentation?.tab_text

    return (
      # if aligned with spaces
      (first_line.indentation.soft_tabs is true and ((second_line.indentation.level - first_line.indentation.level) * first_line.indentation.tab_length) is 4) or

      # if aligned with tabs
      (first_line.indentation.soft_tabs is false and second_line.indentation.level - first_line.indentation.level is 1)
    )

  ###
  # @name Is Active Row Assignment
  # @description
  # Determines if the line contains an `=`
  ###

  isActiveRowAssignment: (line) ->
    return true if (
      line.operator is '=' and
      (
        @isLineDelimiter(line) or
        @isLineModifier(line)
      )
    )

    return false

  ###
  # @name Is Line Delimiter
  # @description
  # Determines if the line ends with a `,`
  ###

  isLineDelimiter: (line) ->
    tokens = line.tokens

    return true if tokens[tokens.length - 1].scopes.indexOf(SCOPES.DELIMITER) isnt -1

    return false

  ###
  # @name Is Line Modifier
  # @description
  # Determines if the line starts with a `var`
  ###

  isLineModifier: (line) ->
    tokens = line.tokens

    for token in tokens
      return true if token.scopes.indexOf(SCOPES.MODIFIER) isnt -1

    return false

  ###
  # @name Is Line Terminator
  # @description
  # Determines if the line ends with a `;`
  ###

  isLineTerminator: (line) ->
    tokens = line.tokens

    return true if tokens[tokens.length - 1].scopes.indexOf(SCOPES.TERMINATOR) isnt -1

    return false
