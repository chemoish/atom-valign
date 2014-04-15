valignFormatter = require './valign-formatter'

module.exports =
  activate: ->
    atom.workspaceView.command 'valign:align', => @align()

  align: ->
    editor = atom.workspace.activePaneItem

    if not editor or editor.hasMultipleCursors()
      return

    valignFormatter.formatBlock editor
