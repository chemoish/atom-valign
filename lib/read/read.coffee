Base = require './Base'

module.exports =
  getBlock: (text_editor) ->
    try
      Grammar = require "./#{text_editor.getGrammar().name}"

      grammar = new Grammar text_editor

      block = grammar.findMatchingBlock()

    catch error
      base = new Base text_editor

      block = base.findMatchingBlock()

    return block
