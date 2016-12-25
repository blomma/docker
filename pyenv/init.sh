#!/bin/bash

export PYENV_ROOT="/root/.pyenv" && \
export PATH="$PYENV_ROOT/bin:$PATH" && \
eval "$(pyenv init -)"
