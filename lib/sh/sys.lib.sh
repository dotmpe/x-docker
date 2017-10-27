#!/bin/sh

set -e




# Error unless non-empty and true-ish
trueish()
{
  test -n "$1" || return 1
  case "$1" in
    [Oo]n|[Tt]rue|[Yyj]|[Yy]es|1)
      return 0;;
    * )
      return 1;;
  esac
}

# No error on empty or value unless matches trueish
not_trueish()
{
  test -n "$1" || return 0
  trueish "$1" && return 1 || return 0
}

# Error unless non-empty and falseish
falseish()
{
  test -n "$1" || return 1
  case "$1" in
    [Oo]ff|[Ff]alse|[Nn]|[Nn]o|0)
      return 0;;
    * )
      return 1;;
  esac
}

# Error on empty or other falseish, but not other values
not_falseish()
{
  test -n "$1" || return 1
  falseish "$1" && return 1 || return 0
}

# sys-prompt PROMPT [VAR=choice_confirm]
sys_prompt()
{
  test -n "$1" || error "sys-prompt: arg expected" 1
  test -n "$2" || set -- "$1" choice_confirm
  test -z "$3" || error "surplus-args '$3'" 1
  echo $1
  read $2
}

# sys-confirm PROMPT
sys_confirm()
{
  local choice_confirm=
  sys_prompt "$1" choice_confirm
  trueish "$choice_confirm"
}

# Id: x-docker/
