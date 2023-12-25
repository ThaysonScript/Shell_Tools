#!/usr/bin/env bash

# EXAMPLE USAGE:
#   $ trim "    Hello,  World    "
#   Hello,  World

#   $ name="   John Black  "
#   $ trim "$name"
#   John Black
trim() {
    # Usage: trim_string "   example   string    "
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

# EXAMPLE USAGE:
#   $ trim_all "    Hello,    World    "
#   Hello, World

#   $ name="   John   Black  is     my    name.    "
#   $ trim_all "$name"
#   John Black is my name.
trim_all() {
    # Usage: trim_all "   example   string    "
    set -f

    # shellcheck disable=SC2086,SC2048
    set -- $*
    printf '%s\n' "$*"
    set +f
}

# EXAMPLE USAGE:
#   $ var="'Hello', \"World\""
#   $ trim_quotes "$var"
#   Hello, World
trim_quotes() {
    # Usage: trim_quotes "string"
    : "${1//\'}"
    printf '%s\n' "${_//\"}"
}

# EXAMPLE USAGE:
#   $ pattern_strip "The Quick Brown Fox" "[aeiou]"
#   Th Qck Brwn Fx

#   $ pattern_strip "The Quick Brown Fox" "[[:space:]]"
#   TheQuickBrownFox

#   $ pattern_strip "The Quick Brown Fox" "Quick "
#   The Brown Fox
pattern_strip() {
    # Usage: pattern_strip "string" "pattern"
    printf '%s\n' "${1//$2}"
}

# EXAMPLE USAGE:
#   $ first_strip "The Quick Brown Fox" "[aeiou]"
#   Th Quick Brown Fox

#   $ first_strip "The Quick Brown Fox" "[[:space:]]"
#   TheQuick Brown Fox
first_strip() {
    # Usage: first_strip "string" "pattern"
    printf '%s\n' "${1/$2}"
}

# EXAMPLE USAGE:
#   $ lstrip "The Quick Brown Fox" "The "
#   Quick Brown Fox
lstrip() {
    # Usage: lstrip "string" "pattern"
    printf '%s\n' "${1##"$2"}"
}

# EXAMPLE USAGE:
#   $ rstrip "The Quick Brown Fox" " Fox"
#   The Quick Brown
rstrip() {
    # Usage: rstrip "string" "pattern"
    printf '%s\n' "${1%%"$2"}"
}

# EXAMPLE USAGE
#   $ # Trim leading white-space.
#   $ regex '    hello' '^\s*(.*)'
#   hello

#   $ # Validate a hex color.
#   $ regex "#FFFFFF" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
#   #FFFFFF

#   $ # Validate a hex color (invalid).
#   $ regex "red" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
#   no output (invalid)
regex() {
    # Usage: regex "string" "regex"
    [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

# EXAMPLE USAGE:
#   $ split "apples,oranges,pears,grapes" ","
#   apples
#   oranges
#   pears
#   grapes

#   $ split "1, 2, 3, 4, 5" ", "
#   1
#   2
#   3
#   4
#   5

#   Multi char delimiters work too!
#   $ split "hello---world---my---name---is---john" "---"
#   hello
#   world
#   my
#   name
#   is
#   john
split() {
   # Usage: split "string" "delimiter"
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

# EXAMPLE USAGE:
#   $ lower "HELLO"
#   hello

#   $ lower "HeLlO"
#   hello

#   $ lower "hello"
#   hello
lower() {
    # Usage: lower "string"
    printf '%s\n' "${1,,}"
}

# EXAMPLE USAGE:
# $ upper "hello"
# HELLO

# $ upper "HeLlO"
# HELLO

# $ upper "HELLO"
# HELLO
upper() {
    # Usage: upper "string"
    printf '%s\n' "${1^^}"
}

# EXAMPLE USAGE:
#   $ reverse "hello"
#   HELLO

#   $ reverse "HeLlO"
#   hElLo

#   $ reverse "HELLO"
#   hello
reverse() {
    # Usage: reverse "string"
    printf '%s\n' "${1~~}"
}

# EXAMPLE USAGE:
#   $ url_encode "https://github.com/dylanaraps/pure-bash-bible"
#   https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible
url_encode() {
    # Usage: url_encode "string"
    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9.~_-])
                printf '%s' "$_"
            ;;

            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

# EXAMPLE USAGE:
#   $ url_decode "https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible"
#   https://github.com/dylanaraps/pure-bash-bible
url_decode() {
    # Usage: url_decode "string"
    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}