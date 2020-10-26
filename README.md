# Lab4_Binding

Binding lab: 3 parts=====================
This is three part lab looking at language binding.
Note in preparation for this lab you will need to install several newpackages.
Linux users should use your package installer (e.g., apt-get),and Mac OS X users, brew is recommended.
This is a good transition to the next module on parallel coding asyou will need most of these packages.
# Part 1: Simple python bindings Pre-reqs:
pybind11, C++ (gnu 8 or newer)  
* simple binding (add) * threaded source code (loop)

# Part 2: python to grpc C++ Pre-reqs: 
pybind11,
C++ (xcode or gnu 8), cmake, grpc, protobuf, libomp  
* re-implementation of the loop binding through a C++ grpc server (loop-grpc)
* standalone (baseline) w/o grpc or cmake (loop-baseline) * observation and timing studies of parts 1 and 2


# Part 3: cython and pybindgen (TBD)Pre-reqs: cython, pybindgen, C++ (gnu 8 or newer), cmake * Simple binding using pybindgen * Cython (TBD)
