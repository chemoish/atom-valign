SCOPES =
  DELIMITER:  'meta.delimiter.object.comma.js'
  MODIFIER:   'storage.modifier.js'
  TERMINATOR: 'punctuation.terminator.statement.js'
  
module.exports =
  isActiveRowAssignment: (line) ->
    return true if line.operator is '='

    return false

  isLineDelimiter: (line) ->
    tokens = line.tokens

    return true if tokens[tokens.length - 1].scopes.indexOf(SCOPES.DELIMETER) isnt -1

    return false

  isLineModifier: (line) ->
    tokens = line.tokens

    return true if tokens[0].scopes.indexOf(SCOPES.MODIFIER) isnt -1

    return false

  isLineTerminator: (line) ->
    tokens = line.tokens

    return true if tokens[tokens.length - 1].scopes.indexOf(SCOPES.TERMINATOR) isnt -1

    return false
