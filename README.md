# Atom.io – Valign Package

Easily align your code.

```js
// from
var easily = 'align';
var your = 'code';

// to
var easily = 'align';
var your   = 'code';

```

## Hotkey

| Command | Mac | PC and Linux |
| --- | --- | --- |
| Align code | Ctrl + \ | Alt + Ctrl + \ |

## Features

- General, works on **ANY** language without needing specific support
- Aligns many kinds of operators (E.g. `%=`, `?=`, `|=`, `=>`, etc.)
- Can configure alignment and padding of operators
- Basic functionality works on untitled files (No grammar needed)

## Settings

- `Alignment "=" (Default: right)`
- `Padding "=" (Default: both)`
- `Alignment ":" (Default: left)`
- `Padding ":" (Default: right)`
- `Alignment "=>" (Default: right)`
- `Padding "=>" (Default: both)`

## Few Examples <small><sub>(html, css, less, scss, etc. also work)</small>

### JavaScript

#### Assignment
```js
// from
var one  =  "uno",
two="dos",
three  ="thres",
four=  "quatro";

one  =  "uno";
two+="dos";
three  -="thres";
```

```js
// to
var one   = "uno",
    two   = "dos",
    three = "thres",
    four  = "quatro";

one    = "uno";
two   += "dos";
three -= "thres";
```

#### Object
```js
// from
var numero = {
  one  :  "uno",
  two:"dos",
  three  :"thres",
  four:  "quatro"
};
```

```js
// to
var numero = {
  one:   "uno",
  two:   "dos",
  three: "thres",
  four:  "quatro"
};
```

### CoffeeScript

#### Assignment

```coffee
# from
one  =  "uno"
two+="dos"
three  -="thres"
four?=  "quatro"
```

```coffee
# to
one    = "uno"
two   += "dos"
three -= "thres"
four  ?= "quatro"
```

#### Object

```coffee
# from
numero =
  one  :  "uno"
  two:"dos"
  three  :"thres"
  four:  "quatro"
```

```coffee
# to
numero =
  one:   "uno"
  two:   "dos"
  three: "thres"
  four:  "quatro"
```

### PHP

#### Assignment

```php
// from
var one  =  "uno";
two+="dos";
three  -="thres";
four*=  "four";
```

```php
// to
var one  = "uno";
two     += "dos";
three   -= "thres";
four    *= "four";
```

#### Array

```php
// from
var numero = array(
  "one"  =>  "uno"
  "two"=>"dos"
  "three"  =>"thres"
  "four"=>  "quatro"
);
```

```php
// to
var numero = array(
  "one"   => "uno"
  "two"   => "dos"
  "three" => "thres"
  "four"  => "quatro"
);
```

## Notice

This package has been fully rewritten and has stripped out array, object, and space alignment.

If you would like to see these come back please [submit a issue](https://github.com/chemoish/atom-valign/issues).
