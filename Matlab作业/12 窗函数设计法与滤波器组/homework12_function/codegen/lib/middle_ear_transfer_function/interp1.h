//
// File: interp1.h
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

#ifndef INTERP1_H
#define INTERP1_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include "omp.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
namespace coder {
void interp1Linear(const double y[39], const ::coder::array<double, 2U> &xi,
                   ::coder::array<double, 2U> &yi, const double varargin_1[39]);

}

#endif
//
// File trailer for interp1.h
//
// [EOF]
//
