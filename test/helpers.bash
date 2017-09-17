#!/bin/bash


type fail >/dev/null 2>&1 || {
  fail() {
    if test -n "$1" 
    then
      echo "Failed: $1" >>"$BATS_OUT"
    fi
    exit 0
  }
}


type TODO >/dev/null 2>&1 || {
  TODO() {
    BATS_TEST_TODO=${1:-1}
    BATS_TEST_COMPLETED=1
    exit 0
  }
}


type diag >/dev/null 2>&1 || {
  diag() {
    BATS_TEST_DIAGNOSTICS=1
    echo "$1" >>"$BATS_OUT"
  }
}


type stdfail >/dev/null 2>&1 || {
  stdfail()
  {
    test -n "$1" || set -- "Unexpected. Status"
    fail "$1: $status, output(${#lines[@]}) is '${lines[*]}'"
  }
}
