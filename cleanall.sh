#!/bin/bash

find -type f -name "*.cf"  -execdir rm -vf {} \;
find -type f -name "*.vcd" -execdir rm -vf {} \;
