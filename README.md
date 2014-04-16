# Atom.io – Valign Package

> Align operators and comma separated values in atom editor for CoffeeScript with `ctrl-\`.

![valign](https://raw.github.com/chemoish/atom-valign/master/demo.gif)

## Examples

#### Equal

```coffeescript
# from
one  ="uno"
two="dos"
three="thres"
four=  "quatro"

# to
one   = "uno"
two   = "dos"
three = "thres"
four  = "quatro"
```

#### Colon

```coffeescript
# from
numero =
  one  :"uno"
  two:"dos"
  three:"thres"
  four: "quatro"

# to
numero =
  one:   "uno"
  two:   "dos"
  three: "thres"
  four:  "quatro"
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

#### Comma seperated objects

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
