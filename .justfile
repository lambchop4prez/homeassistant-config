#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

[private]
default:
    just -l

[private]
log lvl msg *args:
    gum log --time rfc822 -s --level "{{ lvl }}" "{{ msg }}" {{ args }}

[private]
template file *args:
    bws run -- minijinja-cli --env "{{ file }}" {{ args }}

secrets:
    just template ./templates/secrets.yaml.j2 > secrets.yaml