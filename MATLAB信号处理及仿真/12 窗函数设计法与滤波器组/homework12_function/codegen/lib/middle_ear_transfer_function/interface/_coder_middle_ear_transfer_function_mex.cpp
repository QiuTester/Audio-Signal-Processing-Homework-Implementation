//
// File: _coder_middle_ear_transfer_function_mex.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "_coder_middle_ear_transfer_function_mex.h"
#include "_coder_middle_ear_transfer_function_api.h"

// Function Definitions
//
// Arguments    : int32_T nlhs
//                mxArray *plhs[]
//                int32_T nrhs
//                const mxArray *prhs[]
// Return Type  : void
//
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&middle_ear_transfer_function_atexit);
  // Module initialization.
  middle_ear_transfer_function_initialize();
  try {
    emlrtShouldCleanupOnError((emlrtCTX *)emlrtRootTLSGlobal, false);
    // Dispatch the entry-point.
    unsafe_middle_ear_transfer_function_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    middle_ear_transfer_function_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
}

//
// Arguments    : void
// Return Type  : emlrtCTX
//
emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr);
  return emlrtRootTLSGlobal;
}

//
// Arguments    : int32_T nlhs
//                mxArray *plhs[5]
//                int32_T nrhs
//                const mxArray *prhs[1]
// Return Type  : void
//
void unsafe_middle_ear_transfer_function_mexFunction(int32_T nlhs,
                                                     mxArray *plhs[5],
                                                     int32_T nrhs,
                                                     const mxArray *prhs[1])
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  const mxArray *outputs[5];
  int32_T b_nlhs;
  st.tls = emlrtRootTLSGlobal;
  // Check for proper number of arguments.
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4,
                        28, "middle_ear_transfer_function");
  }
  if (nlhs > 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 28,
                        "middle_ear_transfer_function");
  }
  // Call the function.
  middle_ear_transfer_function_api(prhs[0], nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }
  emlrtReturnArrays(b_nlhs, &plhs[0], &outputs[0]);
}

//
// File trailer for _coder_middle_ear_transfer_function_mex.cpp
//
// [EOF]
//
