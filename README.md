# purescript-monaco

[![Latest release](http://img.shields.io/github/release/purescript/purescript-monaco.svg)](https://github.com/maxhillaert/purescript-monaco/releases)
[![Build status](https://travis-ci.org/purescript/purescript-foreign.svg?branch=master)](https://travis-ci.org/maxhillaert/purescript-monaco)

Purescript bindings for the Monaco Editor.

## Installation

```
bower install purescript-monaco
```

Note: Monaco uses AMD modules which doesn't play nicely with the purescript FFI modules.  Unfortunatly it requires a manual
script inclusion in your html file, and a pretty ugly global variable. Hopefully the community can come up with a better solution.

## Examples

- [Basic Sample](example/src/EditorBasic.purs)

## Building And Running Examples

```bash
git clone https://github.com/maxhillaert/purescript-monaco.git
npm install
bower install
npm run build
npm run serve
```

Then go to `localhost:5050`


## Documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-foreign).
