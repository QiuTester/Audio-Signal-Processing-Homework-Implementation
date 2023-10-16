//
// File: _coder_middle_ear_transfer_function_mex.h
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

#ifndef _CODER_MIDDLE_EAR_TRANSFER_FUNCTION_MEX_H
#define _CODER_MIDDLE_EAR_TRANSFER_FUNCTION_MEX_H

// Include Files
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"

// Function Declarations
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[],
                                     int32_T nrhs, const mxArray *prhs[]);

emlrtCTX mexFunctionCreateRootTLS();

void unsafe_middle_ear_transfer_function_mexFunction(int32_T nlhs,
                                                     mxArray *plhs[5],
                                                     int32_T nrhs,
                                                     const mxArray *prhs[1]);

#endif
//
// File trailer for _coder_middle_ear_transfer_function_mex.h
//
// [EOF]
//
