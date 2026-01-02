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
    bws run --project-id a417b9ed-1eb3-458a-82b9-b3c5015fa0f0 -- minijinja-cli --env "{{ file }}" {{ args }}

secrets:
    just template ./templates/secrets.yaml.j2 > secrets.yaml