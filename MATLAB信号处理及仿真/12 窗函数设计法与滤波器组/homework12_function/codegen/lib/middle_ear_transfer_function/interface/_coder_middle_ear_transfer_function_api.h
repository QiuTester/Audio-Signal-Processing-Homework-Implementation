//
// File: _coder_middle_ear_transfer_function_api.h
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

#ifndef _CODER_MIDDLE_EAR_TRANSFER_FUNCTION_API_H
#define _CODER_MIDDLE_EAR_TRANSFER_FUNCTION_API_H

// Include Files
#include "coder_array_mex.h"
#include "emlrt.h"
#include "tmwtypes.h"
#include <algorithm>
#include <cstring>

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void middle_ear_transfer_function(int16_T L, real_T Freqz[39], real_T Amp[39],
                                  coder::array<real_T, 2U> *freq_response,
                                  coder::array<real_T, 2U> *y_freq,
                                  coder::array<creal_T, 2U> *h);

void middle_ear_transfer_function_api(const mxArray *prhs, int32_T nlhs,
                                      const mxArray *plhs[5]);

void middle_ear_transfer_function_atexit();

void middle_ear_transfer_function_initialize();

void middle_ear_transfer_function_terminate();

void middle_ear_transfer_function_xil_shutdown();

void middle_ear_transfer_function_xil_terminate();

#endif
//
// File trailer for _coder_middle_ear_transfer_function_api.h
//
// [EOF]
//
