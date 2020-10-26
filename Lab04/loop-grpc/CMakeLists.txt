cmake_minimum_required(VERSION 3.3)

project (loop)

add_compile_options(-std=c++11)
add_compile_options(-g)

# ------------------------------------------------------
# LINUX: uncomment these lines and modify executable
#
# on mac we want xcode because of library builds (brew) 
# using LLVM

#set(CMAKE_C_COMPILER /usr/local/bin/gcc-8)
#set(CMAKE_CXX_COMPILER /usr/local/bin/g++-8)

# manually set openmp flags (find_package may set this for you)
#set(OPENMP_CXX_FLAGS "-fopenmp")
#set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${OPENMP_CXX_FLAGS} -03")

# ------------------------------------------------------

# Use if you are not using /usr/local (change GRPC and Protocol Buffers locations)
#list(APPEND CMAKE_PREFIX_PATH "/usr/local/Cellar/grpc/1.15.0" "/usr/local/Cellar/protobuf/3.6.1")

# project specific cmake modules (grpc, protobuf)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Modules")

# cmake's proto discovery (/usr/local/lib), grpc from project's Module directory. This
# uses the bespoke grpc find methods (see README.md)
find_package(OpenMP REQUIRED)
find_package(Protobuf REQUIRED)
find_package(GRPC REQUIRED)

# the protobuf definitions
set(PROTOS ${CMAKE_CURRENT_SOURCE_DIR}/resources/loop.proto)

set(PROTO_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated-src)
file(MAKE_DIRECTORY ${PROTO_SRC_DIR})
include_directories(${PROTO_SRC_DIR})

protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTO_SRC_DIR} ${PROTOS})
grpc_generate_cpp(GRPC_SRCS GRPC_HDRS ${PROTO_SRC_DIR} ${PROTOS})

# Debug: generated files
#message ("** PROTO_SRCS = ${PROTO_SRCS}")
#message ("** PROTO_HDRS = ${PROTO_HDRS}")
#message ("** GRPC_SRCS  = ${GRPC_SRCS}")
#message ("** GRPC_HDRS  = ${GRPC_HDRS}")

# standalone binary (note default compiler on mac is xcode)
add_executable(loop-main
   src/looping.cc
)

# server binary
add_executable(loop-server 
   src/loopImpl.cc 
   ${PROTO_SRCS} 
   ${GRPC_SRCS} 
)

# Note Linux users may need to remove the OpenMP::... line

target_link_libraries(loop-main
   OpenMP::OpenMP_CXX
)

target_link_libraries(loop-server
   gRPC::grpc++_reflection
   protobuf::libprotobuf
   OpenMP::OpenMP_CXX
)
