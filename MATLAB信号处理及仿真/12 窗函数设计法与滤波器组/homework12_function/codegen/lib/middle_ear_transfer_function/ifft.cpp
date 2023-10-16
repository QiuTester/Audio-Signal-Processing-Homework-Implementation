//
// File: ifft.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "ifft.h"
#include "FFTImplementationCallback.h"
#include "middle_ear_transfer_function_data.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <cmath>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &x
//                ::coder::array<creal_T, 2U> &y
// Return Type  : void
//
namespace coder {
void ifft(const ::coder::array<double, 2U> &x, ::coder::array<creal_T, 2U> &y)
{
  array<creal_T, 1U> b_fv;
  array<creal_T, 1U> fv;
  array<creal_T, 1U> wwc;
  array<creal_T, 1U> yCol;
  array<double, 2U> costab;
  array<double, 2U> costab1q;
  array<double, 2U> sintab;
  array<double, 2U> sintabinv;
  array<double, 1U> b_x;
  if (x.size(1) == 0) {
    y.set_size(1, 0);
  } else {
    double nt_re;
    int N2blue;
    int i;
    int k;
    int pmax;
    int pmin;
    int pow2p;
    int rt;
    boolean_T useRadix2;
    useRadix2 = ((x.size(1) & (x.size(1) - 1)) == 0);
    N2blue = 1;
    if (useRadix2) {
      pmin = x.size(1);
    } else {
      rt = (x.size(1) + x.size(1)) - 1;
      pmax = 31;
      if (rt <= 1) {
        pmax = 0;
      } else {
        boolean_T exitg1;
        pmin = 0;
        exitg1 = false;
        while ((!exitg1) && (pmax - pmin > 1)) {
          k = (pmin + pmax) >> 1;
          pow2p = 1 << k;
          if (pow2p == rt) {
            pmax = k;
            exitg1 = true;
          } else if (pow2p > rt) {
            pmax = k;
          } else {
            pmin = k;
          }
        }
      }
      N2blue = 1 << pmax;
      pmin = N2blue;
    }
    nt_re = 6.2831853071795862 / static_cast<double>(pmin);
    rt = pmin / 2 / 2;
    costab1q.set_size(1, rt + 1);
    costab1q[0] = 1.0;
    pmax = rt / 2 - 1;
    for (k = 0; k <= pmax; k++) {
      costab1q[k + 1] = std::cos(nt_re * (static_cast<double>(k) + 1.0));
    }
    i = pmax + 2;
    pmax = rt - 1;
    for (k = i; k <= pmax; k++) {
      costab1q[k] = std::sin(nt_re * static_cast<double>(rt - k));
    }
    costab1q[rt] = 0.0;
    if (!useRadix2) {
      rt = costab1q.size(1) - 1;
      pmax = (costab1q.size(1) - 1) << 1;
      costab.set_size(1, pmax + 1);
      sintab.set_size(1, pmax + 1);
      costab[0] = 1.0;
      sintab[0] = 0.0;
      sintabinv.set_size(1, pmax + 1);
      for (k = 0; k < rt; k++) {
        sintabinv[k + 1] = costab1q[(rt - k) - 1];
      }
      i = costab1q.size(1);
      for (k = i; k <= pmax; k++) {
        sintabinv[k] = costab1q[k - rt];
      }
      for (k = 0; k < rt; k++) {
        costab[k + 1] = costab1q[k + 1];
        sintab[k + 1] = -costab1q[(rt - k) - 1];
      }
      i = costab1q.size(1);
      for (k = i; k <= pmax; k++) {
        costab[k] = -costab1q[pmax - k];
        sintab[k] = -costab1q[k - rt];
      }
    } else {
      rt = costab1q.size(1) - 1;
      pmax = (costab1q.size(1) - 1) << 1;
      costab.set_size(1, pmax + 1);
      sintab.set_size(1, pmax + 1);
      costab[0] = 1.0;
      sintab[0] = 0.0;
      for (k = 0; k < rt; k++) {
        costab[k + 1] = costab1q[k + 1];
        sintab[k + 1] = costab1q[(rt - k) - 1];
      }
      i = costab1q.size(1);
      for (k = i; k <= pmax; k++) {
        costab[k] = -costab1q[pmax - k];
        sintab[k] = costab1q[k - rt];
      }
      sintabinv.set_size(1, 0);
    }
    if (useRadix2) {
      pmax = x.size(1);
      b_x = x.reshape(pmax);
      pmax = x.size(1);
      yCol.set_size(pmax);
      if (pmax > b_x.size(0)) {
        yCol.set_size(pmax);
        for (i = 0; i < pmax; i++) {
          yCol[i].re = 0.0;
          yCol[i].im = 0.0;
        }
      }
      if (pmax != 1) {
        internal::fft::FFTImplementationCallback::doHalfLengthRadix2(
            b_x, yCol, pmax, costab, sintab);
      } else {
        pmax = b_x.size(0);
        if (pmax > 1) {
          pmax = 1;
        }
        yCol[0].re = b_x[pmax - 1];
        yCol[0].im = 0.0;
        wwc.set_size(yCol.size(0));
        pmax = yCol.size(0);
        for (i = 0; i < pmax; i++) {
          wwc[i] = yCol[i];
        }
        yCol.set_size(wwc.size(0));
        pmax = wwc.size(0);
        for (i = 0; i < pmax; i++) {
          yCol[i] = wwc[i];
        }
      }
      if (yCol.size(0) > 1) {
        nt_re = 1.0 / static_cast<double>(yCol.size(0));
        pmax = yCol.size(0);
        for (i = 0; i < pmax; i++) {
          yCol[i].re = nt_re * yCol[i].re;
          yCol[i].im = nt_re * yCol[i].im;
        }
      }
    } else {
      double nt_im;
      int nfft;
      pmax = x.size(1);
      b_x = x.reshape(pmax);
      nfft = x.size(1);
      if ((nfft != 1) && ((nfft & 1) == 0)) {
        int nInt2;
        pmin = nfft / 2;
        pow2p = (pmin + pmin) - 1;
        wwc.set_size(pow2p);
        rt = 0;
        wwc[pmin - 1].re = 1.0;
        wwc[pmin - 1].im = 0.0;
        nInt2 = pmin << 1;
        for (k = 0; k <= pmin - 2; k++) {
          pmax = ((k + 1) << 1) - 1;
          if (nInt2 - rt <= pmax) {
            rt += pmax - nInt2;
          } else {
            rt += pmax;
          }
          nt_im = 3.1415926535897931 * static_cast<double>(rt) /
                  static_cast<double>(pmin);
          if (nt_im == 0.0) {
            nt_re = 1.0;
            nt_im = 0.0;
          } else {
            nt_re = std::cos(nt_im);
            nt_im = std::sin(nt_im);
          }
          i = (pmin - k) - 2;
          wwc[i].re = nt_re;
          wwc[i].im = -nt_im;
        }
        i = pow2p - 1;
        for (k = i; k >= pmin; k--) {
          wwc[k] = wwc[(pow2p - k) - 1];
        }
      } else {
        int nInt2;
        pow2p = (nfft + nfft) - 1;
        wwc.set_size(pow2p);
        rt = 0;
        wwc[nfft - 1].re = 1.0;
        wwc[nfft - 1].im = 0.0;
        nInt2 = nfft << 1;
        for (k = 0; k <= nfft - 2; k++) {
          pmax = ((k + 1) << 1) - 1;
          if (nInt2 - rt <= pmax) {
            rt += pmax - nInt2;
          } else {
            rt += pmax;
          }
          nt_im = 3.1415926535897931 * static_cast<double>(rt) /
                  static_cast<double>(nfft);
          if (nt_im == 0.0) {
            nt_re = 1.0;
            nt_im = 0.0;
          } else {
            nt_re = std::cos(nt_im);
            nt_im = std::sin(nt_im);
          }
          i = (nfft - k) - 2;
          wwc[i].re = nt_re;
          wwc[i].im = -nt_im;
        }
        i = pow2p - 1;
        for (k = i; k >= nfft; k--) {
          wwc[k] = wwc[(pow2p - k) - 1];
        }
      }
      yCol.set_size(nfft);
      if (nfft > b_x.size(0)) {
        yCol.set_size(nfft);
        for (i = 0; i < nfft; i++) {
          yCol[i].re = 0.0;
          yCol[i].im = 0.0;
        }
      }
      if ((N2blue != 1) && ((nfft & 1) == 0)) {
        internal::fft::FFTImplementationCallback::doHalfLengthBluestein(
            b_x, yCol, b_x.size(0), nfft, N2blue, wwc, costab, sintab, costab,
            sintabinv);
      } else {
        double b_re_tmp;
        double re_tmp;
        pmax = b_x.size(0);
        if (nfft <= pmax) {
          pmax = nfft;
        }
        for (k = 0; k < pmax; k++) {
          pmin = (nfft + k) - 1;
          yCol[k].re = wwc[pmin].re * b_x[k];
          yCol[k].im = wwc[pmin].im * -b_x[k];
        }
        i = pmax + 1;
        for (k = i; k <= nfft; k++) {
          yCol[k - 1].re = 0.0;
          yCol[k - 1].im = 0.0;
        }
        internal::fft::FFTImplementationCallback::r2br_r2dit_trig(
            yCol, N2blue, costab, sintab, fv);
        internal::fft::FFTImplementationCallback::r2br_r2dit_trig(
            wwc, N2blue, costab, sintab, b_fv);
        b_fv.set_size(fv.size(0));
        pmax = fv.size(0);
        for (i = 0; i < pmax; i++) {
          nt_re = fv[i].re;
          nt_im = b_fv[i].im;
          re_tmp = fv[i].im;
          b_re_tmp = b_fv[i].re;
          b_fv[i].re = nt_re * b_re_tmp - re_tmp * nt_im;
          b_fv[i].im = nt_re * nt_im + re_tmp * b_re_tmp;
        }
        internal::fft::FFTImplementationCallback::b_r2br_r2dit_trig(
            b_fv, N2blue, costab, sintabinv, fv);
        i = wwc.size(0);
        for (k = nfft; k <= i; k++) {
          double ar;
          nt_re = wwc[k - 1].re;
          nt_im = fv[k - 1].im;
          re_tmp = wwc[k - 1].im;
          b_re_tmp = fv[k - 1].re;
          ar = nt_re * b_re_tmp + re_tmp * nt_im;
          nt_re = nt_re * nt_im - re_tmp * b_re_tmp;
          if (nt_re == 0.0) {
            pmax = k - nfft;
            yCol[pmax].re = ar / static_cast<double>(nfft);
            yCol[pmax].im = 0.0;
          } else if (ar == 0.0) {
            pmax = k - nfft;
            yCol[pmax].re = 0.0;
            yCol[pmax].im = nt_re / static_cast<double>(nfft);
          } else {
            pmax = k - nfft;
            yCol[pmax].re = ar / static_cast<double>(nfft);
            yCol[pmax].im = nt_re / static_cast<double>(nfft);
          }
        }
      }
    }
    y.set_size(1, x.size(1));
    pmax = x.size(1);
    for (i = 0; i < pmax; i++) {
      y[i] = yCol[i];
    }
  }
}

} // namespace coder

//
// File trailer for ifft.cpp
//
// [EOF]
//
