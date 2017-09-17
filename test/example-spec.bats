#!/usr/bin/env bats

load helpers

@test "Example test case in BATS" {
  run printf -- "$(tput bold)$(tput setaf 5)Yay it works!\033[0m$(tput setaf 0)"
  diag "Works, and with diagnostics"
}

@test "Skipped test case in BATS" {
  skip "skip works too"
}

@test "TODO test case in BATS" {
  TODO "still more todo"
}
