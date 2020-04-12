# vim-opine

## TOML Formatting

This is a plugin I extracted for formatting TOML the way I like. You're right, there are no rules, but this is the way I like it. I have been working with Hugo a log and copy/pasta-ing those ocnfig files leaves all the tomls in different states on indent and I can't stand that it would indent on save. 

I use it with [vim-toml](https://github.com/cespare/vim-toml). It formats it the way I like. Ex
```
title = "TOML Example"

[owner]
  name = "Tom Preston-Werner"
  dob = 1979-05-27T07:32:00-08:00 # First class dates

[database]
  server = "192.168.1.1"
  ports = [ 8001, 8001, 8002 ]
  connection_max = 5000
  enabled = true

[servers]

  # Indentation (tabs and/or spaces) is allowed but not required
[servers.alpha]
  ip = "10.0.0.1"
  dc = "eqdc10"

[servers.beta]
  ip = "10.0.0.2"
  dc = "eqdc10"

[clients]
[clients.thing]
  data = [ ["gamma", "delta"], [1, 2] ]

  # Line breaks are OK when inside arrays
  hosts = [
  "alpha",
  "omega"
  ]
```

It's basically just the `toml.vim` file for the indent. It set setlocal indentexpr

## Usage
Use Install with your favorite Plugin manager.
### Install
#### vim-plug
`
Plug 'guygrigsby/vim-opine', { 'for': 'toml' }
`
#### Vundle
`
Plugin 'guygrigsby/vim-opine'
`
etc...
### Use
In your `.vimrc` put:
```
au BufRead,BufWritePre *.toml :normal gg=G``
```

## Vars
No vars. Uses shiftwidth for indentation
