#!/usr/bin/env bats

load suite

@test 'move should should exit 0 and change the issue state' {
  # ensure we avoid false positives by moving away from the initial state
  run build/bin/zenhub issue rockymadden/zenhub-cli 1 --filter='.pipeline | .name'
  [ "${status}" -eq 0 ]
  [ "${output}" == "New Issues" ] && expected="In Progress" || expected="New Issues"

  run build/bin/zenhub move rockymadden/zenhub-cli 1 "${expected}" "top"
  [ "${status}" -eq 0 ]

  run build/bin/zenhub issue rockymadden/zenhub-cli 1 --filter='.pipeline | .name'
  [ "${status}" -eq 0 ]
  [ "${output}" == "${expected}" ]
}
