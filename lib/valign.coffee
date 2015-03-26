config = require './config'

format = require './format/format'
read   = require './read/read'
write  = require './write/write'

module.exports =
  config: config

  activate: ->
    atom.commands.add 'atom-text-editor',
      'valign:align': =>
        @align atom.workspace.getActiveTextEditor()

  align: (text_editor) ->
    if not text_editor or text_editor.hasMultipleCursors()
      return

    block = read.getBlock text_editor

    block = format.formatBlock text_editor, block

    write.writeBlock text_editor, block
