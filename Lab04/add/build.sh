#!/bin/bash
# pybind11 is a header (.h) only binding of C++ to python.
#
# What this does is to generate wrappers around the C++ code to allow 
# C++ code to be imported into python as a module
#

# Note:
# MAC OS X: if building using xcode, you need to run 'xcode-select --install'

# using GNU!
CXX=g++-6

# This is where I used git to download the pybind11 source code
PY11=~/Developer/pybind11/pybind11-master/include

# I installed through brew - Cellar is where the python include files are located:
PY3=/usr/local/Cellar/python/3.7.2_2/Frameworks/Python.framework/Versions/3.7/include/python3.7m

# compiling into a python module (example.so)
$CXX -shared -std=c++11 -undefined dynamic_lookup -fPIC -O2 -I $PY11 -I $PY3 `cat py-args` example.c -o example.so

# echo on how to run
echo -e "\nTo Run:\n python3 -c \"import example; s = example.add(3,6); print('s = ',s);\""
