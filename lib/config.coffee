module.exports =
  '=':
    type: 'object'

    properties:
      align:
        title:       'Alignment "="'
        description: 'Controls the alignment of the "=" operator to the left or right hand side (e.g. "x= 1", "x =1").'
        type:        'string'
        enum:        ['left', 'right']
        default:     'right'

      padding:
        title:       'Padding "="'
        description: 'Controls the surrounding padding of the "=" operator (e.g. "= ", " =", " = ", "=").'
        type:        'string'
        enum:        ['left', 'right', 'both', 'none']
        default:     'both'

  ':':
    type: 'object'

    properties:
      align:
        title:    'Alignment ":"'
        description: 'Controls the alignment of the ":" operator to the left or right hand side (e.g. "x: 1", "x :1").'
        type:    'string'
        enum:    ['left', 'right']
        default: 'left'

      padding:
        title:       'Padding ":"'
        description: 'Controls the surrounding padding of the ":" operator (e.g. ": ", " :", " : ", ":").'
        type:        'string'
        enum:        ['left', 'right', 'both', 'none']
        default:     'right'

  '=>':
    type: 'object'

    properties:
      align:
        title:       'Alignment "=>"'
        description: 'Controls the alignment of the "=>" operator to the left or right hand side (e.g. "x=> 1", "x =>1").'
        type:        'string'
        enum:        ['left', 'right']
        default:     'right'

      padding:
        title:       'Padding "=>"'
        description: 'Controls the surrounding padding of the "=>" operator (e.g. "=> ", " =>", " => ", "=>").'
        type:        'string'
        enum:        ['left', 'right', 'both', 'none']
        default:     'both'
