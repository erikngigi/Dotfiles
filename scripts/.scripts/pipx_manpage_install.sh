#!/bin/bash
# Create links from `~/.local/share` to the files in `share` subdirectories
# of virtual environments installed with `pipx`.

# Run with `-n` option for a dry run, with `-D` to undo.
# You may have to resolve conflicts manually.
# Assumes there are only directories in the venv dir.

cd $(pipx environment -v PIPX_LOCAL_VENVS)
stow --ignore='^((?!share).)*$' --target=$(realpath ~/.local) -v $@ *
