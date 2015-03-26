extend = require 'extend'

module.exports =
  operators:
    '=':
      match:  '=|\\+=|-=|&=|\\|=|~=|%=|/=|\\*=|\\.=|\\?='

    ':':
      match:  ':'

    '=>':
      match: '=>'

  getBaseOperator: (operator) ->
    return operator unless operator?
    
    return operator if this.operators[operator]?

    for key, value of this.operators
      return key if operator.match value.match

    return operator

  getOperatorFromText: (text) ->
    match = []

    for key, value of this.operators
      match.push value.match

    # prioritize more granular operators
    operator = text.match match.reverse().join('|')

    return null unless operator?

    return operator[0]

  hasMatch: (operator1, operator2) ->
    return true if operator1 is operator2

    return this.getBaseOperator(operator1) is this.getBaseOperator(operator2)
