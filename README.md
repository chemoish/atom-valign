# Atom.io – Valign Package

> Align operators and comma separated values in atom editor with `ctrl-\`.
> Intended for CoffeeScript, Jade, and Stylus, but works in Javascript, Markdown, others?

![valign](https://raw.github.com/chemoish/atom-valign/master/demo.gif)

## Javascript Example

#### Assignment

```javascript
// from
var beer = "belly";
var pork_belly = "yummy";
var yummy = 42;

// to
var beer       = "belly";
var pork_belly = "yummy";
var yummy      = 42;
```

#### Object

```javascript
// from
var obj = {
  "beer": "belly",
  "pork belly": "yummy",
  "yummy": 42
};

// to
var obj = {
  "beer":       "belly",
  "pork belly": "yummy",
  "yummy":      42
};
```

## CoffeeScript Example

#### Assignment

```coffeescript
# from
one  =  "uno"
two="dos"
three  ="thres"
# TODO: ignore me
five = contar 2, 3

# to
one   = "uno"
two   = "dos"
three = "thres"
# TODO: ignore me
five  = contar 2, 3
```

#### Assignment Operator

```coffeescript
# from
one  =  "uno"
two+="dos"
three  -="thres"
four?=  "quatro"

# to
one    = "uno"
two   += "dos"
three -= "thres"
four  ?= "quatro"
```

#### Object

```coffeescript
# from
numero =
  one  :  "uno"
  two:"dos"
  # TODO: ignore me
  three  :"thres"

# to
numero =
  one:   "uno"
  two:   "dos"
  # TODO: ignore me
  three: "thres"
```

#### Array

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

#### Object in Array

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

## Jade Example

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

## Stylus Example

```stylus
#numero
  color  blanco
  font-size grande

#numero
  color     blanco
  font-size grande
```
