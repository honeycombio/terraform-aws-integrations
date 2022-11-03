#!/usr/bin/env bash

if [ -n "$1" ] && [ $1 == true ]; then
  echo "Running terraform format validation"
  git grep --cached -Il '' -- '*.tf' '*.tfvars' | xargs -L1 terraform fmt -check=true -diff=true -list=true
else
  echo "Running terraform format validation and auto update"
  git grep --cached -Il '' -- '*.tf' '*.tfvars' | xargs -L1 terraform fmt -write=true -diff=true -list=true
fi
