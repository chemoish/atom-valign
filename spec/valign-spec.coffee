# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'Valign:', ->
  [
    buffer
    editor
    editorView
    valignActivation
  ] = []

  trigger = (callback) ->
    atom.commands.dispatch editorView, 'valign:align'

    waitsForPromise ->
      valignActivation

    runs(callback)

  describe 'CoffeeScript:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-coffee-script'

      waitsForPromise ->
        atom.workspace.open 'sample.coffee'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format ":" correctly.', ->
      editor.setCursorBufferPosition [1, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 1).toBe '  one:   "uno"'
        expect(editor.lineTextForBufferRow 2).toBe '  two:   "dos"'
        expect(editor.lineTextForBufferRow 3).toBe '  three: "thres"'
        expect(editor.lineTextForBufferRow 4).toBe '  four:  "quatro"'

    it 'should format "=" correctly.', ->
      editor.setCursorBufferPosition [6, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 6).toBe 'one    = "uno"'
        expect(editor.lineTextForBufferRow 7).toBe 'two   += "dos"'
        expect(editor.lineTextForBufferRow 8).toBe '# comment'
        expect(editor.lineTextForBufferRow 9).toBe 'three -= "thres"'
        expect(editor.lineTextForBufferRow 10).toBe 'four  ?= "quatro"'

  describe 'JavaScript:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-javascript'

      waitsForPromise ->
        atom.workspace.open 'sample.js'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format ":" correctly.', ->
      editor.setCursorBufferPosition [1, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 1).toBe '  one:   "uno",'
        expect(editor.lineTextForBufferRow 2).toBe '  two:   "dos",'
        expect(editor.lineTextForBufferRow 3).toBe '  three: "thres",'
        expect(editor.lineTextForBufferRow 4).toBe '  four:  "quatro"'

    it 'should format multiline "=" correctly.', ->
      editor.setCursorBufferPosition [7, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 7).toBe 'var one   = "uno",'
        expect(editor.lineTextForBufferRow 8).toBe '    two   = "dos",'
        expect(editor.lineTextForBufferRow 9).toBe '    three = "thres",'
        expect(editor.lineTextForBufferRow 10).toBe '    four  = "quatro";'

    it 'should format complex "=" correctly.', ->
      editor.setCursorBufferPosition [12, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 12).toBe 'one    = "uno";'
        expect(editor.lineTextForBufferRow 13).toBe 'two   += "dos";'
        expect(editor.lineTextForBufferRow 14).toBe '// comment'
        expect(editor.lineTextForBufferRow 15).toBe 'three -= "thres";'

  describe 'PHP:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-php'

      waitsForPromise ->
        atom.workspace.open 'sample.php'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format "=>" correctly.', ->
      editor.setCursorBufferPosition [3, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 3).toBe '  "one"   => "uno"'
        expect(editor.lineTextForBufferRow 4).toBe '  "two"   => "dos"'
        expect(editor.lineTextForBufferRow 5).toBe '  "three" => "thres"'
        expect(editor.lineTextForBufferRow 6).toBe '  "four"  => "quatro"'

    it 'should format "=" correctly.', ->
      editor.setCursorBufferPosition [9, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 9).toBe 'var one  = "uno";'
        expect(editor.lineTextForBufferRow 10).toBe 'two     += "dos";'
        expect(editor.lineTextForBufferRow 11).toBe '// comment'
        expect(editor.lineTextForBufferRow 12).toBe 'three   -= "thres";'
        expect(editor.lineTextForBufferRow 13).toBe 'four    *= "four";'

  describe 'Sass:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-sass'

      waitsForPromise ->
        atom.workspace.open 'sample.scss'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format variable ":" correctly.', ->
      editor.setCursorBufferPosition [0, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 0).toBe '$font-stack:    Helvetica, sans-serif;'
        expect(editor.lineTextForBufferRow 1).toBe '$primary-color: #333;'

    it 'should format ":" correctly.', ->
      editor.setCursorBufferPosition [4, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 4).toBe '  color: $primary-color;'
        expect(editor.lineTextForBufferRow 5).toBe '  // comment'
        expect(editor.lineTextForBufferRow 6).toBe '  font:  100% $font-stack;'

  describe 'less:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-less'

      waitsForPromise ->
        atom.workspace.open 'sample.less'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format variable ":" correctly.', ->
      editor.setCursorBufferPosition [0, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 0).toBe '@nice-blue:  #5B83AD;'
        expect(editor.lineTextForBufferRow 1).toBe '@light-blue: @nice-blue + #111;'

    it 'should format ":" correctly.', ->
      editor.setCursorBufferPosition [4, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 4).toBe '  background-color: @nice-blue;'
        expect(editor.lineTextForBufferRow 5).toBe '  // comment'
        expect(editor.lineTextForBufferRow 6).toBe '  color:            @light-blue;'

  describe 'Text:', ->
    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'language-text'

      waitsForPromise ->
        atom.workspace.open 'sample.txt'

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)

        valignActivation = atom.packages.activatePackage 'valign'

    it 'should format variable ":" correctly.', ->
      editor.setCursorBufferPosition [1, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 1).toBe '  one:   "uno",'
        expect(editor.lineTextForBufferRow 2).toBe '  two:   "dos",'
        expect(editor.lineTextForBufferRow 3).toBe '  three: "thres",'
        expect(editor.lineTextForBufferRow 4).toBe '  four:  "quatro"'

    it 'should format ":" correctly.', ->
      editor.setCursorBufferPosition [7, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 7).toBe 'one    = "uno";'
        expect(editor.lineTextForBufferRow 8).toBe 'two   += "dos";'
        expect(editor.lineTextForBufferRow 9).toBe 'three -= "thres";'

    it 'should format 10 or more lines of code correctly.', ->
      editor.setCursorBufferPosition [11, 0]

      trigger ->
        expect(editor.lineTextForBufferRow 11).toBe 'one:   "uno",'
        expect(editor.lineTextForBufferRow 12).toBe 'two:   "dos",'
        expect(editor.lineTextForBufferRow 13).toBe 'three: "thres",'
        expect(editor.lineTextForBufferRow 14).toBe 'four:  "quatro",'
        expect(editor.lineTextForBufferRow 15).toBe 'one:   "uno",'
        expect(editor.lineTextForBufferRow 16).toBe 'two:   "dos",'
        expect(editor.lineTextForBufferRow 17).toBe 'three: "thres",'
        expect(editor.lineTextForBufferRow 18).toBe 'four:  "quatro",'
        expect(editor.lineTextForBufferRow 19).toBe 'one:   "uno",'
        expect(editor.lineTextForBufferRow 20).toBe 'two:   "dos",'
        expect(editor.lineTextForBufferRow 21).toBe 'three: "thres",'
        expect(editor.lineTextForBufferRow 22).toBe 'four:  "quatro"'
