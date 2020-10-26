#include <iostream>
#include <pybind11/pybind11.h>

#include "omp.h"

//#define VERBOSE
#define SHOWRESULTS

static int N = 100000;

int doLoop(int notused) { 

    int temp = 1; 
    int a[N+1], b[N+1];
    int tcnt = 0;

    // initialize 
    for (int i = 0; i < N; i++) {
        a[i] = temp;
        b[i] = i;
    }

#ifdef VERBOSE
    printf(" T,  i)   A   B   tmp\n");
#endif

    #pragma omp parallel
    {
        int cnt = 0;
        int id = omp_get_thread_num();
        #pragma omp for schedule(static)
        //#pragma omp for schedule(dynamic)
        for (int i = 0; i < N; i++) {
            a[i] = temp;
            a[i+1] = b[i+1];
            temp = a[i];

            // on a single socket we see more collisions
            if ( temp != 1 ) {
                cnt++;
#ifdef VERBOSE
                printf("%2d, %3d) %3d %3d %3d\n", id,i,a[i],b[i],temp);
#endif
            }
        }

        #pragma omp critical
        {
#ifdef SHOWRESULTS
           printf("T%02d collisions:   %5d\n", id,cnt);
#endif
           tcnt += cnt;
        }
    }

    return tcnt;
}

namespace py = pybind11;

PYBIND11_PLUGIN(loop) { 
    py::module m("loop", "pybind11 and openmp example");

    m.def("doLoop", &doLoop, "Demo openmp w/ python to get around python's GIL");

    return m.ptr();
}

