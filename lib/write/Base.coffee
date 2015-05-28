class Base
  constructor: (@text_editor) ->

  writeMatchingBlock: (block) ->
    {
      start
      end
    } = this.getTextRange block

    text = this.getText block

    return unless text

    cursor_row = @text_editor.getCursorBufferPosition().row
    last_row   = @text_editor.lineTextForBufferRow end

    @text_editor.setTextInBufferRange [[start, 0], [end, last_row.length]], text

    @text_editor.setCursorBufferPosition [cursor_row, 0]
    @text_editor.moveToEndOfLine()

  getText: (block) ->
    text = []

    for row, line of block
      text.push line.line_text

    return text.join "\n"

  getTextRange: (block) ->
    rows = (parseInt(row, 10) for row, line of block)

    rows.sort (a, b) ->
      return a - b

    start = (rows.slice 0, 1)[0]
    end   = (rows.slice -1)[0]

    return {
      start
      end
    }


module.exports = Base
