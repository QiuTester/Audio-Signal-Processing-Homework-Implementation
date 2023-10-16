//
// File: main.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

// Include Files
#include "main.h"
#include "middle_ear_transfer_function.h"
#include "middle_ear_transfer_function_terminate.h"
#include "rt_nonfinite.h"
#include "coder_array.h"

// Function Declarations
static short argInit_int16_T();

static void main_middle_ear_transfer_function();

// Function Definitions
//
// Arguments    : void
// Return Type  : short
//
static short argInit_int16_T()
{
  return 0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_middle_ear_transfer_function()
{
  coder::array<creal_T, 2U> h;
  coder::array<double, 2U> freq_response;
  coder::array<double, 2U> y_freq;
  double Amp[39];
  double Freqz[39];
  // Initialize function 'middle_ear_transfer_function' input arguments.
  // Call the entry-point 'middle_ear_transfer_function'.
  middle_ear_transfer_function(argInit_int16_T(), Freqz, Amp, freq_response,
                               y_freq, h);
}

//
// Arguments    : int argc
//                char **argv
// Return Type  : int
//
int main(int, char **)
{
  // The initialize function is being called automatically from your entry-point
  // function. So, a call to initialize is not included here. Invoke the
  // entry-point functions.
  // You can call entry-point functions multiple times.
  main_middle_ear_transfer_function();
  // Terminate the application.
  // You do not need to do this more than one time.
  middle_ear_transfer_function_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
