module.exports =
  buildText: (lines, alignment_index) ->
    text = []

    for line in lines
      spaces = Array(alignment_index - line.index + 1).join ' '

      replacement = switch line.symbol
        when ':' then "$1 #{spaces}"
        when '=' then "#{spaces} $1 "
        else ''

      text.push line.content.replace /[\s]*([:=])[\s]*/, replacement

    return text.join "\n"

  findBlock: (editor) ->
    row  = editor.getCursorBufferPosition().row
    line = editor.lineForBufferRow row

    if (line is '' or !line.match /[:=]/)
      return null

    isRowValid = (row) ->
      line = editor.lineForBufferRow row

      return line and
             line.match(/[:=]/) and
             indentation is editor.indentationForBufferRow row

    nextLine = previousLine = line
    nextRow = previousRow = row

    # get line indentation
    indentation = editor.indentationForBufferRow row

    while isRowValid nextRow
      nextRow += 1

    while isRowValid previousRow
      previousRow -= 1

    return {
      start: previousRow + 1
      end: nextRow - 1
    }

  formatBlock: (editor) ->
    block = @findBlock editor

    return unless block

    lines = @getLines editor, block

    alignment_index = @getSymbolIndexFromLines lines

    text = @buildText lines, alignment_index

    @writeText editor, text, block, lines

  getLines: (editor, block) ->
    lines = []

    for i in [block.start..block.end]
      line = editor.lineForBufferRow i

      regex = /(.*?)[\s]*([:=])/

      if match = regex.exec line
        lines.push
          index:   match[1].length
          content: match.input
          symbol:  match[2]

    return lines

  getSymbolIndexFromLines: (lines) ->
    return Math.max.apply null, (line.index for line in lines)

  writeText: (editor, text, block, lines) ->
    # get cursor row
    cursor_row = editor.getCursorBufferPosition().row

    # get the point at the end of the block
    last_line = editor.lineForBufferRow block.end

    # replace text
    editor.setTextInBufferRange [[block.start, 0], [block.end, last_line.length]], "#{text}"

    # reset cursor position to end of previous selected line
    editor.setCursorBufferPosition [cursor_row, 0]
    editor.moveCursorToEndOfLine()
