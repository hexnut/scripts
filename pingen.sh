#!/bin/bash

LC_ALL=C tr -dc 0-9 < /dev/urandom | head -c${1:-4}
echo
