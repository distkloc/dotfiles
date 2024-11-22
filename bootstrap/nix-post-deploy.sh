#!/bin/bash

mise use -g usage
mise use -g node@latest
mise use -g kubectl@latest
mise use -g kubectl-convert@latest


exec -l $(which zsh)
