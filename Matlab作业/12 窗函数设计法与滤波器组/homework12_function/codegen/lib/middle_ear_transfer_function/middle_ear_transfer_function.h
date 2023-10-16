//
// File: middle_ear_transfer_function.h
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

#ifndef MIDDLE_EAR_TRANSFER_FUNCTION_H
#define MIDDLE_EAR_TRANSFER_FUNCTION_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include "omp.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
extern void
middle_ear_transfer_function(short L, double Freqz[39], double Amp[39],
                             coder::array<double, 2U> &freq_response,
                             coder::array<double, 2U> &y_freq,
                             coder::array<creal_T, 2U> &h);

#endif
//
// File trailer for middle_ear_transfer_function.h
//
// [EOF]
//
