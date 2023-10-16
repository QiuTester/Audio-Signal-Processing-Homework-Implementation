//
// File: casyi.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "casyi.h"
#include "middle_ear_transfer_function_data.h"
#include "middle_ear_transfer_function_rtwutil.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
// Arguments    : const creal_T z
//                creal_T *y
// Return Type  : int
//
namespace coder {
int casyi(const creal_T z, creal_T *y)
{
  double absxi;
  double absxr;
  double ak1_im;
  double ak1_re;
  int nz;
  nz = 0;
  if (z.im == 0.0) {
    ak1_re = 0.15915494309189535 / z.re;
    ak1_im = 0.0;
  } else if (z.re == 0.0) {
    ak1_re = 0.0;
    ak1_im = -(0.15915494309189535 / z.im);
  } else {
    ak1_im = std::abs(z.re);
    absxi = std::abs(z.im);
    if (ak1_im > absxi) {
      absxi = z.im / z.re;
      absxr = z.re + absxi * z.im;
      ak1_re = (absxi * 0.0 + 0.15915494309189535) / absxr;
      ak1_im = (0.0 - absxi * 0.15915494309189535) / absxr;
    } else if (absxi == ak1_im) {
      if (z.re > 0.0) {
        absxi = 0.5;
      } else {
        absxi = -0.5;
      }
      if (z.im > 0.0) {
        absxr = 0.5;
      } else {
        absxr = -0.5;
      }
      ak1_re = (0.15915494309189535 * absxi + 0.0 * absxr) / ak1_im;
      ak1_im = (0.0 * absxi - 0.15915494309189535 * absxr) / ak1_im;
    } else {
      absxi = z.re / z.im;
      absxr = z.im + absxi * z.re;
      ak1_re = absxi * 0.15915494309189535 / absxr;
      ak1_im = (absxi * 0.0 - 0.15915494309189535) / absxr;
    }
  }
  if (ak1_im == 0.0) {
    if (ak1_re < 0.0) {
      absxi = 0.0;
      ak1_re = std::sqrt(-ak1_re);
    } else {
      absxi = std::sqrt(ak1_re);
      ak1_re = 0.0;
    }
  } else if (ak1_re == 0.0) {
    if (ak1_im < 0.0) {
      absxi = std::sqrt(-ak1_im / 2.0);
      ak1_re = -absxi;
    } else {
      absxi = std::sqrt(ak1_im / 2.0);
      ak1_re = absxi;
    }
  } else if (std::isnan(ak1_re)) {
    absxi = ak1_re;
  } else if (std::isnan(ak1_im)) {
    absxi = ak1_im;
    ak1_re = ak1_im;
  } else if (std::isinf(ak1_im)) {
    absxi = std::abs(ak1_im);
    ak1_re = ak1_im;
  } else if (std::isinf(ak1_re)) {
    if (ak1_re < 0.0) {
      absxi = 0.0;
      ak1_re = ak1_im * -ak1_re;
    } else {
      absxi = ak1_re;
      ak1_re = 0.0;
    }
  } else {
    absxr = std::abs(ak1_re);
    absxi = std::abs(ak1_im);
    if ((absxr > 4.4942328371557893E+307) ||
        (absxi > 4.4942328371557893E+307)) {
      absxr *= 0.5;
      absxi = rt_hypotd_snf(absxr, absxi * 0.5);
      if (absxi > absxr) {
        absxi = std::sqrt(absxi) * std::sqrt(absxr / absxi + 1.0);
      } else {
        absxi = std::sqrt(absxi) * 1.4142135623730951;
      }
    } else {
      absxi = std::sqrt((rt_hypotd_snf(absxr, absxi) + absxr) * 0.5);
    }
    if (ak1_re > 0.0) {
      ak1_re = 0.5 * (ak1_im / absxi);
    } else {
      if (ak1_im < 0.0) {
        ak1_re = -absxi;
      } else {
        ak1_re = absxi;
      }
      absxi = 0.5 * (ak1_im / ak1_re);
    }
  }
  if (std::abs(z.re) > 700.92179369444591) {
    nz = -1;
    y->re = rtNaN;
    y->im = 0.0;
  } else {
    double aa;
    double aez;
    double ak;
    double b_atol;
    double b_re;
    double bb;
    double cs1_im;
    double cs1_re;
    double cs2_im;
    double cs2_re;
    double dk_im;
    double dk_re;
    double ez_im;
    double im;
    double re;
    double sgn;
    double sqk;
    double tmp_im;
    double tmp_re;
    int bk;
    signed char p1_im;
    boolean_T errflag;
    boolean_T exitg1;
    if (z.im == 0.0) {
      tmp_re = std::exp(z.re);
      tmp_im = 0.0;
    } else if (std::isinf(z.im) && std::isinf(z.re) && (z.re < 0.0)) {
      tmp_re = 0.0;
      tmp_im = 0.0;
    } else {
      absxr = std::exp(z.re / 2.0);
      tmp_re = absxr * (absxr * std::cos(z.im));
      tmp_im = absxr * (absxr * std::sin(z.im));
    }
    re = absxi * tmp_re - ak1_re * tmp_im;
    im = absxi * tmp_im + ak1_re * tmp_re;
    ak1_re = 8.0 * z.re;
    ez_im = 8.0 * z.im;
    aez = 8.0 * rt_hypotd_snf(z.re, z.im);
    if (z.im != 0.0) {
      bk = 1;
      if (z.im < 0.0) {
        bk = -1;
      }
      p1_im = static_cast<signed char>(bk);
    } else {
      p1_im = 0;
    }
    sqk = -1.0;
    b_atol = 2.2204460492503131E-16 / aez;
    sgn = 1.0;
    cs1_re = 1.0;
    cs1_im = 0.0;
    cs2_re = 1.0;
    cs2_im = 0.0;
    tmp_re = 1.0;
    tmp_im = 0.0;
    ak = 0.0;
    aa = 1.0;
    bb = aez;
    dk_re = ak1_re;
    dk_im = ez_im;
    errflag = true;
    bk = 0;
    exitg1 = false;
    while ((!exitg1) && (bk < 45)) {
      tmp_re *= sqk;
      tmp_im *= sqk;
      if (dk_im == 0.0) {
        if (tmp_im == 0.0) {
          b_re = tmp_re / dk_re;
          tmp_im = 0.0;
        } else if (tmp_re == 0.0) {
          b_re = 0.0;
          tmp_im /= dk_re;
        } else {
          b_re = tmp_re / dk_re;
          tmp_im /= dk_re;
        }
      } else if (dk_re == 0.0) {
        if (tmp_re == 0.0) {
          b_re = tmp_im / dk_im;
          tmp_im = 0.0;
        } else if (tmp_im == 0.0) {
          b_re = 0.0;
          tmp_im = -(tmp_re / dk_im);
        } else {
          b_re = tmp_im / dk_im;
          tmp_im = -(tmp_re / dk_im);
        }
      } else {
        ak1_im = std::abs(dk_re);
        absxi = std::abs(dk_im);
        if (ak1_im > absxi) {
          absxi = dk_im / dk_re;
          absxr = dk_re + absxi * dk_im;
          b_re = (tmp_re + absxi * tmp_im) / absxr;
          tmp_im = (tmp_im - absxi * tmp_re) / absxr;
        } else if (absxi == ak1_im) {
          if (dk_re > 0.0) {
            absxi = 0.5;
          } else {
            absxi = -0.5;
          }
          if (dk_im > 0.0) {
            absxr = 0.5;
          } else {
            absxr = -0.5;
          }
          b_re = (tmp_re * absxi + tmp_im * absxr) / ak1_im;
          tmp_im = (tmp_im * absxi - tmp_re * absxr) / ak1_im;
        } else {
          absxi = dk_re / dk_im;
          absxr = dk_im + absxi * dk_re;
          b_re = (absxi * tmp_re + tmp_im) / absxr;
          tmp_im = (absxi * tmp_im - tmp_re) / absxr;
        }
      }
      tmp_re = b_re;
      cs2_re += b_re;
      cs2_im += tmp_im;
      sgn = -sgn;
      cs1_re += b_re * sgn;
      cs1_im += tmp_im * sgn;
      dk_re += ak1_re;
      dk_im += ez_im;
      aa = aa * std::abs(sqk) / bb;
      bb += aez;
      ak += 8.0;
      sqk -= ak;
      if (aa <= b_atol) {
        errflag = false;
        exitg1 = true;
      } else {
        bk++;
      }
    }
    if (errflag) {
      nz = -2;
    } else {
      if (z.re + z.re < 700.92179369444591) {
        tmp_re = -2.0 * z.re;
        tmp_im = -2.0 * z.im;
        if (tmp_im == 0.0) {
          tmp_re = std::exp(tmp_re);
          tmp_im = 0.0;
        } else if (std::isinf(tmp_im) && std::isinf(tmp_re) && (tmp_re < 0.0)) {
          tmp_re = 0.0;
          tmp_im = 0.0;
        } else {
          absxr = std::exp(tmp_re / 2.0);
          tmp_re = absxr * (absxr * std::cos(tmp_im));
          tmp_im = absxr * (absxr * std::sin(tmp_im));
        }
        b_re = tmp_re * cs2_re - tmp_im * cs2_im;
        absxi = tmp_re * cs2_im + tmp_im * cs2_re;
        cs1_re += b_re * 0.0 - absxi * static_cast<double>(p1_im);
        cs1_im += b_re * static_cast<double>(p1_im) + absxi * 0.0;
      }
      y->re = cs1_re * re - cs1_im * im;
      y->im = cs1_re * im + cs1_im * re;
    }
  }
  return nz;
}

} // namespace coder

//
// File trailer for casyi.cpp
//
// [EOF]
//
