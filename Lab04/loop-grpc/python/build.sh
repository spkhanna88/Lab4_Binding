#!/bin/sh

# your protoc must match version numbers
PROTOC=/usr/local/bin/protoc

# output generated code to
GENOUT=./looper

if [ ! -d $GENOUT ]; then
  mkdir $GENOUT
  touch ${GENOUT}/__init__.py
fi

$PROTOC -I ../resources --grpc_out=$GENOUT --plugin=protoc-gen-grpc=`which grpc_python_plugin` ../resources/loop.proto
$PROTOC -I ../resources --python_out=$GENOUT ../resources/loop.proto
