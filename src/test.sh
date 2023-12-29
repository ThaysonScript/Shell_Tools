#!/usr/bin/env bash

source ../core/strings/strings.sh

var=$(upper 'hello           lflflflflf')

lower "$var"

trim_all "$var"
