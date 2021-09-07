#!/bin/bash

asdf plugin add ghq
asdf install ghq latest

asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf install terraform latest
