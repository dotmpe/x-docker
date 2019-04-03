#!/usr/bin/env bash
test ${SHLVL:-0} -le ${lib_lvl:-0} && status=return || { lib_lvl=$SHLVL && set -euo pipefail -o posix && status=exit ; } # Inherit shell or init new

# XXX: requires logger-print helper...
true "${U_S:="/srv/project-local/user-scripts"}"
true "${LOG:="$U_S/tools/sh/log.sh"}"
test -x "${LOG:-}" -o "$(type -t ${LOG})" = "function" || $status 103

true "${PROJECT_BASE:="`git rev-parse --show-toplevel`"}"
true "${BRANCH_NAME:="`git rev-parse --abbrev-ref HEAD`"}"

test ! -e "ReadMe-$BRANCH_NAME.md" && {

  $LOG warn "" "No special README for branch '$BRANCH_NAME', ignored"

} || {

  test -h "$PROJECT_BASE/README.md" || {
    $LOG warn "" "README.md is not a symlink" "" 1
  }

  test "$(readlink README.md)" = "ReadMe-$BRANCH_NAME.md" && {
    $LOG pass "" "README--branch matches" "$BRANCH_NAME"
  } || {

    $LOG warn "" "README--branch mismatch, fixxing" "$BRANCH_NAME"
    # Auto-fix and force update README.md symlink
    rm README.md && ln -s ReadMe-$BRANCH_NAME.md README.md
    git add README.md
    $status 1
  }
}
