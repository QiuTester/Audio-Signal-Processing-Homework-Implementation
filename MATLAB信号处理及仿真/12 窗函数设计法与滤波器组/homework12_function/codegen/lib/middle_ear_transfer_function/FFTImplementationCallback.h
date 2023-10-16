//
// File: FFTImplementationCallback.h
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

#ifndef FFTIMPLEMENTATIONCALLBACK_H
#define FFTIMPLEMENTATIONCALLBACK_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include "omp.h"
#include <cstddef>
#include <cstdlib>

// Type Definitions
namespace coder {
namespace internal {
namespace fft {
class FFTImplementationCallback {
public:
  static void r2br_r2dit_trig(const ::coder::array<creal_T, 1U> &x,
                              int n1_unsigned,
                              const ::coder::array<double, 2U> &costab,
                              const ::coder::array<double, 2U> &sintab,
                              ::coder::array<creal_T, 1U> &y);
  static void b_r2br_r2dit_trig(const ::coder::array<creal_T, 1U> &x,
                                int n1_unsigned,
                                const ::coder::array<double, 2U> &costab,
                                const ::coder::array<double, 2U> &sintab,
                                ::coder::array<creal_T, 1U> &y);
  static void doHalfLengthRadix2(const ::coder::array<double, 1U> &x,
                                 ::coder::array<creal_T, 1U> &y,
                                 int unsigned_nRows,
                                 const ::coder::array<double, 2U> &costab,
                                 const ::coder::array<double, 2U> &sintab);
  static void
  doHalfLengthBluestein(const ::coder::array<double, 1U> &x,
                        ::coder::array<creal_T, 1U> &y, int nrowsx, int nRows,
                        int nfft, const ::coder::array<creal_T, 1U> &wwc,
                        const ::coder::array<double, 2U> &costab,
                        const ::coder::array<double, 2U> &sintab,
                        const ::coder::array<double, 2U> &costabinv,
                        const ::coder::array<double, 2U> &sintabinv);

protected:
  static void get_half_twiddle_tables(const ::coder::array<double, 2U> &costab,
                                      const ::coder::array<double, 2U> &sintab,
                                      ::coder::array<double, 2U> &hcostab,
                                      ::coder::array<double, 2U> &hsintab);
  static void
  get_half_twiddle_tables(const ::coder::array<double, 2U> &costab,
                          const ::coder::array<double, 2U> &sintab,
                          const ::coder::array<double, 2U> &costabinv,
                          const ::coder::array<double, 2U> &sintabinv,
                          ::coder::array<double, 2U> &hcostab,
                          ::coder::array<double, 2U> &hsintab,
                          ::coder::array<double, 2U> &hcostabinv,
                          ::coder::array<double, 2U> &hsintabinv);
  static void r2br_r2dit_trig_impl(const ::coder::array<creal_T, 1U> &x,
                                   int unsigned_nRows,
                                   const ::coder::array<double, 2U> &costab,
                                   const ::coder::array<double, 2U> &sintab,
                                   ::coder::array<creal_T, 1U> &y);
  static void getback_radix2_fft(::coder::array<creal_T, 1U> &y,
                                 const ::coder::array<creal_T, 1U> &reconVar1,
                                 const ::coder::array<creal_T, 1U> &reconVar2,
                                 const ::coder::array<int, 2U> &wrapIndex,
                                 int hnRows);
};

} // namespace fft
} // namespace internal
} // namespace coder

#endif
//
// File trailer for FFTImplementationCallback.h
//
// [EOF]
//
