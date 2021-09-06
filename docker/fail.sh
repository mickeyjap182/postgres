#!/bin/bash

set -o pipefail

false | true
echo "won't be printed" # この行は実行されない
