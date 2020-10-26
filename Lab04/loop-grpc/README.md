GRPC threading Loop example
============================

This example uses Cmake to build a grpc server to test python to C++ integration as a
client-server relationship.

A script (build.sh) is provided to setup the project's build directory. Compiling, you
will need to cd to build and run make.
 
# Windows Building

Visual Studio is your best bet here. VS already includes openmp.


# MAC OSX Building

If you have used brew to install your C++ compiler, grpc, protobuf, 
and possibily built other packages using gcc-x (GNUs not XCode) then
there is a likelihood that you are mixing libraries built with 
XCode (brew) and GNU.

This mixing is bad because of name mangling between LLVM and GNU. Errors
during linking is a sign that you are mixing.

What to do:

 * Instruct brew to use GNU only - CXX and CC environment variables
 * Build from source - this includes all dependencies
 * Build with XCode (see below) 


# Building w/ XCode (likely the easiest)

 * You will need ensure that you used brew to install grpc, libomp, and protobuf
 * For openmp (libomp): brew install libomp

# Linux

 * Use apt-git, yum, or rpm whichever is your package installer for the distro.

# Credit/References

 * https://github.com/IvanSafonov/grpc-cmake-example
 * https://iscinumpy.gitlab.io/post/omp-on-high-sierra
