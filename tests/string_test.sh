#!/usr/bin/env bash

source ../core/strings/strings.sh
trim "    Hello,  World    "

name="   John   Black  is     my    name.    "; trim_all "$name"

var="'Hello', \"World\""; trim_quotes "$var"

pattern_strip "The Quick Brown Fox" "[[:space:]]"

first_strip "The Quick Brown Fox" "[[:space:]]"

lstrip "The Quick Brown Fox" "The "

rstrip "The Quick Brown Fox" " Fox"

regex '    hello' '^\s*(.*)'

split "hello---world---my---name---is---john" "---"

lower "HELLO"

upper "hello"

reverse "hello"

url_encode "https://github.com/dylanaraps/pure-bash-bible"

url_decode "https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible"