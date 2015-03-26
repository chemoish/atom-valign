Base = require './Base'

module.exports =
  writeBlock: (text_editor, block) ->
    base = new Base text_editor

    base.writeMatchingBlock block
