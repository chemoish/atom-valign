valignFormatter = require './valign-formatter'

module.exports =
  activate: ->
    atom.workspaceView.command 'valign:align', => @align atom.workspace.activePaneItem

  align: (editor) ->
    if not editor or editor.hasMultipleCursors()
      return

    valignFormatter.formatBlock editor
