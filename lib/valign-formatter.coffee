getSpaces = (length) ->
  return Array(length).join ' '

module.exports =
  ###
  @name Build Text
  @description
  Take the formatted lines and the given max indexes to build the formatted
  text block.

  @param {Object} formatted_lines
  @param {Object} index_map
  @returns {String} text
  ###

  buildText: (formatted_lines, index_map) ->
    for formatted_line in formatted_lines
      for part, i in formatted_line.parts
        spaces = getSpaces index_map[i] - part.index + 1

        content = switch part.type
          when ':'
            part.input.replace /[\s]*([:])[\s]*/, "$1 #{spaces}"
          # TODO: `>` is a one-off hack for php suffix
          when '=', '+=', '-=', '?=', '=>'
            part.input.replace /[\s]*([+-\?]?[=][>]?)[\s]*/, "#{spaces} $1 "
          when ' '
            part.input.replace /([\s]+)/, " #{spaces}"
          when 'string' then "#{part.input}"
          when 'number' then "#{spaces}#{part.input}"
          else ''

        part.content = content

    content_map = []

    for formatted_line in formatted_lines
      for part, i in formatted_line.parts
        if not content_map[i] || part.content.length > content_map[i]
          content_map[i] = part.content.length

    text = []

    for formatted_line in formatted_lines
      parts = []

      {
        indent
        indent_level
        prefix
        suffix
      } = formatted_line

      indentation = getSpaces indent * indent_level + 1

      for part, i in formatted_line.parts
        max_content_length = content_map[i - 1]

        if max_content_length?
          content_length = formatted_line.parts[i - 1].content.length

          spaces = getSpaces max_content_length - content_length + 1
        else
          spaces = ''

        parts.push "#{spaces}#{part.content}"

      text.push "#{indentation}#{prefix}#{parts.join ', '}#{suffix}"

    return text.join "\n"

  ###
  @name Find Block
  @description
  Find the start and end line positions for the matching cursor block.

  @param {Object} editor
  @returns {Object} block
  ###

  findBlock: (editor) ->
    space_regex = /[^ ]+[ ]+[^ ]+/
    symbol_regex = /[:=,]/

    row  = editor.getCursorBufferPosition().row
    line = editor.lineTextForBufferRow row

    indentation = editor.indentationForBufferRow row

    # validate type of line in two steps. first for symbol, next by space.
    # this is primarly to get around not utilizing atom's language parsers.
    # we do not want the space regex to conflict with typical symbol formatting.

    is_symbol_block = symbol_regex.test line

    is_space_block  = not is_symbol_block and space_regex.test line

    # TODO: make more robust for string containing symbols
    # TODO: atom may have line parsing?
    if (line is '' or (not is_symbol_block and not is_space_block))
      return null

    isRowValid = (row) ->
      line = editor.lineTextForBufferRow row

      return line and
             indentation is editor.indentationForBufferRow(row) and
             (
               editor.isBufferRowCommented(row) or
               # row matches symbol block
               (is_symbol_block and symbol_regex.test line) or
               # row matches space block
               (is_space_block and space_regex.test line)
             )

    nextLine = previousLine = line
    nextRow = previousRow = row

    while isRowValid nextRow
      nextRow += 1

    while isRowValid previousRow
      previousRow -= 1

    return {
      start: previousRow + 1
      end: nextRow - 1
    }

  ###
  @name Format Block
  @description
  Format selected cursor block

  @param {Object} editor
  ###

  formatBlock: (editor) ->
    block = @findBlock editor

    return unless block

    lines = @getLines editor, block

    formatted_lines = @formatLines lines

    index_map = @getIndexMap formatted_lines

    text = @buildText formatted_lines, index_map

    @writeText editor, text, block

  ###
  @name Format Lines
  @description
  Attach Split a given line into parts and attach the associated meta data to each
  line part.

  @param {Object} lines
  @return {Object} formatted_lines
  ###

  formatLines: (lines) ->
    # TODO: `>` is a one-off hack for php suffix
    symbol_regex  = /(.*?)[\s]*([+\-?]?[:=][>]?)/
    space_regex = /(.*?)([ ])/

    for line in lines
      line_parts = []

      if line.is_comment
        line_parts.push
          index: 0
          input: line.input.trim()
          type:  'string'

      else
        if line.prefix and line.suffix
          parts = line.input.split ','
        else
          parts = [line.input]

        for part in parts
          content = part.trim()

          # if the content contains symbol
          if symbol_match = symbol_regex.exec content
            operator = symbol_match[2]

            # assignment operators will be longer and we should attach the extra
            # character to the index
            index = symbol_match[1].length + operator.length - 1

            # TODO: one-off hack for php suffix
            index-- if operator is '=>'

            line_parts.push
              index: index
              input: symbol_match.input
              type:  operator

          # if the content is space
          else if space_match = space_regex.exec content
            operator = space_match[2]

            index = space_match[1].length

            line_parts.push
              index: index
              input: space_match.input
              type:  operator

          # if the content is string/int
          else
            line_parts.push
              index: content.length
              input: content
              type:  if content.match /[\d.]+/ then 'number' else 'string'

      line.parts = line_parts

    return lines;

  ###
  @name Get Index Map
  @description
  Find the largest index per each line part. There will be multiple parts
  if there are commas.

  @param {Object} formatted_lines
  @returns {Array} index_map
  ###
  getIndexMap: (formatted_lines) ->
    index_map = []

    for formatted_line in formatted_lines
      for part, i in formatted_line.parts
        if not index_map[i] || part.index > index_map[i]
          index_map[i] = part.index

    return index_map

  ###
  @name Get Lines
  @description
  Parse lines from given block start and end positions. Additionally, set any
  extra line meta data for later use.

  @param {Object} editor
  @param {Object} block
  @returns {Array} lines
  ###
  getLines: (editor, block) ->
    lines = []

    wrapper_regex = /^([\{\[])(.*?)([\}\]])$/

    for i in [block.start..block.end]
      input = editor.lineTextForBufferRow i

      if match = wrapper_regex.exec input.trim()
        input  = match[2]
        prefix = match[1]
        suffix = match[3]
      else
        prefix = ''
        suffix = ''

      lines.push
        indent:       editor.getTabLength()
        indent_level: editor.indentationForBufferRow i
        input:        input.trim()
        is_comment:   editor.isBufferRowCommented i
        prefix:       prefix
        suffix:       suffix

    return lines

  ###
  @name Write Text
  @description
  Write text block to buffer, overriding previous text. Replace cursor to the
  end of the current line.

  @param {Object} editor
  @param {String} text
  @param {Object} block
  ###

  writeText: (editor, text, block) ->
    # get cursor row
    cursor_row = editor.getCursorBufferPosition().row

    # get the point at the end of the block
    last_line = editor.lineTextForBufferRow block.end

    # replace text
    editor.setTextInBufferRange [[block.start, 0], [block.end, last_line.length]], text

    # reset cursor position to end of previous selected line
    editor.setCursorBufferPosition [cursor_row, 0]
    editor.moveToEndOfLine()
