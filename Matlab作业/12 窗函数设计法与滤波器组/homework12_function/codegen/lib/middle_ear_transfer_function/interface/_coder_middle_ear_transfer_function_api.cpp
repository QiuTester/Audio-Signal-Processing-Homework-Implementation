//
// File: _coder_middle_ear_transfer_function_api.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "_coder_middle_ear_transfer_function_api.h"
#include "_coder_middle_ear_transfer_function_mex.h"
#include "coder_array_mex.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131611U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "middle_ear_transfer_function",                       // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, // fSigWrd
    nullptr                                               // fSigMem
};

// Function Declarations
static int16_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *L,
                                const char_T *identifier);

static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId);

static const mxArray *emlrt_marshallOut(const real_T u[39]);

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 2U> &u);

static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const coder::array<creal_T, 2U> &u);

// Function Definitions
//
// Arguments    : const emlrtStack *sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : int16_T
//
static int16_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  int16_T ret;
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"int16",
                          false, 0U, (void *)&dims);
  ret = *(int16_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack *sp
//                const mxArray *L
//                const char_T *identifier
// Return Type  : int16_T
//
static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *L,
                                const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  int16_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(sp, emlrtAlias(L), &thisId);
  emlrtDestroyArray(&L);
  return y;
}

//
// Arguments    : const emlrtStack *sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : int16_T
//
static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId)
{
  int16_T y;
  y = b_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const real_T u[39]
// Return Type  : const mxArray *
//
static const mxArray *emlrt_marshallOut(const real_T u[39])
{
  static const int32_T iv[2]{0, 0};
  static const int32_T iv1[2]{1, 39};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, &iv1[0], 2);
  emlrtAssign(&y, m);
  return y;
}

//
// Arguments    : const coder::array<real_T, 2U> &u
// Return Type  : const mxArray *
//
static const mxArray *emlrt_marshallOut(const coder::array<real_T, 2U> &u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &(((coder::array<real_T, 2U> *)&u)->data())[0]);
  emlrtSetDimensions((mxArray *)m, ((coder::array<real_T, 2U> *)&u)->size(), 2);
  emlrtAssign(&y, m);
  return y;
}

//
// Arguments    : const emlrtStack *sp
//                const coder::array<creal_T, 2U> &u
// Return Type  : const mxArray *
//
static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const coder::array<creal_T, 2U> &u)
{
  const mxArray *m;
  const mxArray *y;
  int32_T iv[2];
  y = nullptr;
  iv[0] = 1;
  iv[1] = u.size(1);
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxCOMPLEX);
  emlrtExportNumericArrayR2013b((emlrtCTX)sp, m, &u[0], 8);
  emlrtAssign(&y, m);
  return y;
}

//
// Arguments    : const mxArray *prhs
//                int32_T nlhs
//                const mxArray *plhs[5]
// Return Type  : void
//
void middle_ear_transfer_function_api(const mxArray *prhs, int32_T nlhs,
                                      const mxArray *plhs[5])
{
  coder::array<creal_T, 2U> h;
  coder::array<real_T, 2U> freq_response;
  coder::array<real_T, 2U> y_freq;
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  real_T(*Amp)[39];
  real_T(*Freqz)[39];
  int16_T L;
  st.tls = emlrtRootTLSGlobal;
  Freqz = (real_T(*)[39])mxMalloc(sizeof(real_T[39]));
  Amp = (real_T(*)[39])mxMalloc(sizeof(real_T[39]));
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  // Marshall function inputs
  L = emlrt_marshallIn(&st, emlrtAliasP(prhs), "L");
  // Invoke the target function
  middle_ear_transfer_function(L, *Freqz, *Amp, freq_response, y_freq, h);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(*Freqz);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(*Amp);
  }
  if (nlhs > 2) {
    freq_response.no_free();
    plhs[2] = emlrt_marshallOut(freq_response);
  }
  if (nlhs > 3) {
    y_freq.no_free();
    plhs[3] = emlrt_marshallOut(y_freq);
  }
  if (nlhs > 4) {
    plhs[4] = emlrt_marshallOut(&st, h);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

//
// Arguments    : void
// Return Type  : void
//
void middle_ear_transfer_function_atexit()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  middle_ear_transfer_function_xil_terminate();
  middle_ear_transfer_function_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

//
// Arguments    : void
// Return Type  : void
//
void middle_ear_transfer_function_initialize()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

//
// Arguments    : void
// Return Type  : void
//
void middle_ear_transfer_function_terminate()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

//
// File trailer for _coder_middle_ear_transfer_function_api.cpp
//
// [EOF]
//
