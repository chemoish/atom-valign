# Atom.io – Valign Package

> Align operators and comma separated values in atom editor for CoffeeScript with `ctrl-\`.
> Technically works for Jade and CoffeeScript in Markdown.

![valign](https://raw.github.com/chemoish/atom-valign/master/demo.gif)

## Examples

#### Colon

```coffeescript
# from
numero =
  one  :  "uno"
  two:"dos"
  # TODO: ignore me
  three  :"thres"
  four:  "quatro"

# to
numero =
  one:   "uno"
  two:   "dos"
  # TODO: ignore me
  three: "thres"
  four:  "quatro"
```

#### Equal

```coffeescript
# from
one  =  "uno"
two="dos"
three  ="thres"
four=  "quatro"
# TODO: ignore me
five = contar 2, 3

# to
one   = "uno"
two   = "dos"
three = "thres"
four  = "quatro"
# TODO: ignore me
five  = contar 2, 3
```

#### Assignment Operator

```coffeescript
# from
one  =  "uno"
two+="dos"
three  -="thres"
four=  "quatro"

# to
one    = "uno"
two   += "dos"
three -= "thres"
four   = "quatro"
```

#### Comma

```coffeescript
# from
["uno",1,"one"]
["dos",2,"two"]
["diez",10,"ten"]

# to
["uno",   1, "one"]
["dos",   2, "two"]
["diez", 10, "ten"]
```

#### Comma seperated object

```coffeescript
# from
["uno":1,"dos":2]
["diez":10,"once":11]
["vente":20,"vente y uno":21]

# to
["uno":   1,  "dos":         2]
["diez":  10, "once":        11]
["vente": 20, "vente y uno": 21]
```

#### Jade

```jade
div(
  data-uno  ="1"
  data-dos="2"
  ng-diez=  getDiez(10, 0)
)

div(
  data-uno = "1"
  data-dos = "2"
  ng-diez  = getDiez(10, 0)
)
```
####
