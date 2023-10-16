//
// File: middle_ear_transfer_function_terminate.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "middle_ear_transfer_function_terminate.h"
#include "middle_ear_transfer_function_data.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : void
// Return Type  : void
//
void middle_ear_transfer_function_terminate()
{
  omp_destroy_nest_lock(&middle_ear_transfer_function_nestLockGlobal);
  isInitialized_middle_ear_transfer_function = false;
}

//
// File trailer for middle_ear_transfer_function_terminate.cpp
//
// [EOF]
//
