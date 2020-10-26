#!/bin/bash
#
# another example

# which C++ compiler
CXX=g++-6

# This is where I used git to download the source code
PY11=~/Developer/pybind11/pybind11-master/include

# installed through brew - where the python include files are located:
PY3=/usr/local/Cellar/python/3.7.2_2/Frameworks/Python.framework/Versions/3.7/include/python3.7m

PYTHON_LIB=$PYTHON_LIB:/usr/local/Cellar/gcc\@6/6.5.0/lib/gcc/6

rm loop.so

# compiling
$CXX -shared -Xpreprocessor -fopenmp -std=c++11 -undefined dynamic_lookup -fPIC -O2 -I$PY11 -I$PY3 -lgomp `cat py-args` loop.c -o loop.so

