#!/bin/bash

asdf plugin-add nodejs
asdf plugin-add python

asdf install nodejs latest
asdf install python latest

exec $SHELL -l
