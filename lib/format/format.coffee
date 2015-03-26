Base = require './Base'

module.exports =
  formatBlock: (text_editor, block) ->
    try
      Grammar = require "./#{text_editor.getGrammar().name}"

      grammar = new Grammar text_editor

      block = grammar.formatMatchingBlock block

    catch error
      base = new Base text_editor

      block = base.formatMatchingBlock block

    return block
