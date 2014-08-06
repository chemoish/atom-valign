{WorkspaceView} = require 'atom'

Valign = require '../lib/valign'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'Valign:', ->
  editor = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-coffee-script'

    runs ->
      atom.workspaceView = new WorkspaceView
      atom.workspaceView.openSync()

      editorView = atom.workspaceView.getActiveView()
      editor = editorView.getEditor()

      editor.setGrammar atom.syntax.selectGrammar "test.coffee"

  describe 'Formatting ":"', ->
    beforeEach ->
      editor.setText """
        numero =
          one  :  "uno"
          two:"dos"
          three  :"thres"
          four:  "quatro"
      """

      Valign.align editor

    it 'should allow for multiple surrounding spaces to align correctly', ->
      expect(editor.lineForBufferRow 1).toBe '  one:   "uno"'

    it 'should allow for no spaces to align correctly', ->
      expect(editor.lineForBufferRow 2).toBe '  two:   "dos"'

    it 'should allow for left only spaces to align correctly', ->
      expect(editor.lineForBufferRow 3).toBe '  three: "thres"'

    it 'should allow for right only spaces to align correctly', ->
      expect(editor.lineForBufferRow 4).toBe '  four:  "quatro"'

  describe 'Formatting "="', ->
    beforeEach ->
      editor.setText """
        one  =  "uno"
        two="dos"
        three  ="thres"
        four=  "quatro"
        five += 5
        twenty-=20
        hundred  ?=  "cien"
        thousand => "mil"
      """

      Valign.align editor

    it 'should allow for multiple surrounding spaces to align correctly', ->
      expect(editor.lineForBufferRow 0).toBe 'one      = "uno"'

    it 'should allow for no spaces to align correctly', ->
      expect(editor.lineForBufferRow 1).toBe 'two      = "dos"'

    it 'should allow largest line with no spaces to format correctly', ->
      expect(editor.lineForBufferRow 2).toBe 'three    = "thres"'

    it 'should allow for right only spaces to align correctly', ->
      expect(editor.lineForBufferRow 3).toBe 'four     = "quatro"'

    it 'should allow for assignment operators to align correctly', ->
      expect(editor.lineForBufferRow 4).toBe 'five    += 5'
      expect(editor.lineForBufferRow 5).toBe 'twenty  -= 20'
      expect(editor.lineForBufferRow 6).toBe 'hundred ?= "cien"'
      expect(editor.lineForBufferRow 7).toBe 'thousand => "mil"'


  describe 'Formatting ","', ->
    beforeEach ->
      editor.setText """
        ["uno", 1, "one"]
        ["dos", 2, "two"]
        ["diez", 10, "ten"]

        ["uno": 1, "dos": 2]
        ["diez": 10, "once": 11]
        ["vente": 20, "vente y uno": 21]
      """

    it 'should align strings and numbers correctly', ->
      editor.setCursorBufferPosition [0, 0]

      Valign.align editor

      expect(editor.lineForBufferRow 0).toBe '["uno",   1, "one"]'
      expect(editor.lineForBufferRow 1).toBe '["dos",   2, "two"]'
      expect(editor.lineForBufferRow 2).toBe '["diez", 10, "ten"]'

    it 'should align objects, then commas correctly', ->
      editor.setCursorBufferPosition [4, 0]

      Valign.align editor

      expect(editor.lineForBufferRow 4).toBe  '["uno":   1,  "dos":         2]'
      expect(editor.lineForBufferRow 5).toBe  '["diez":  10, "once":        11]'
      expect(editor.lineForBufferRow 6).toBe '["vente": 20, "vente y uno": 21]'

  describe 'Formatting "method call assignments"', ->
    beforeEach ->
      editor.setText """
        uno=count 1
        dos  =count 1, 1
        diez=  count 10, 0
      """

      Valign.align editor

    it 'should align method calls correctly', ->
      expect(editor.lineForBufferRow 0).toBe 'uno  = count 1'
      expect(editor.lineForBufferRow 1).toBe 'dos  = count 1, 1'
      expect(editor.lineForBufferRow 2).toBe 'diez = count 10, 0'

  describe 'Formatting "comments"', ->
    beforeEach ->
      editor.setText """
        one  =  "uno"
        two="dos"
        # TODO: delete three
        three="thres"
        four =    "quatro"
      """

      Valign.align editor

    it 'should align correctly, but capture and ignore formatting of commented lines', ->
      expect(editor.lineForBufferRow 0).toBe 'one   = "uno"'
      expect(editor.lineForBufferRow 2).toBe '# TODO: delete three'

  describe 'Formatting "spaces"', ->
    beforeEach ->
      editor.setText """
        one uno
        two dos
        three thres
        four quatro
      """

      Valign.align editor

    it 'should align correctly', ->
      expect(editor.lineForBufferRow 0).toBe 'one   uno'
