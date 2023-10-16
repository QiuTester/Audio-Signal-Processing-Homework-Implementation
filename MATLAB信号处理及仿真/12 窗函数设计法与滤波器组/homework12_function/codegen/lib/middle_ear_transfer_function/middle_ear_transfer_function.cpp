//
// File: middle_ear_transfer_function.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "middle_ear_transfer_function.h"
#include "casyi.h"
#include "cmlri.h"
#include "gammaln.h"
#include "ifft.h"
#include "interp1.h"
#include "middle_ear_transfer_function_data.h"
#include "middle_ear_transfer_function_initialize.h"
#include "middle_ear_transfer_function_rtwutil.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <algorithm>
#include <cmath>

// Function Declarations
static void binary_expand_op(coder::array<creal_T, 2U> &h,
                             const coder::array<double, 1U> &r);

static double rt_powd_snf(double u0, double u1);

// Function Definitions
//
// Arguments    : coder::array<creal_T, 2U> &h
//                const coder::array<double, 1U> &r
// Return Type  : void
//
static void binary_expand_op(coder::array<creal_T, 2U> &h,
                             const coder::array<double, 1U> &r)
{
  coder::array<creal_T, 2U> b_h;
  int i;
  int loop_ub;
  int stride_0_1;
  int stride_1_1;
  if (r.size(0) == 1) {
    i = h.size(1);
  } else {
    i = r.size(0);
  }
  b_h.set_size(1, i);
  stride_0_1 = (h.size(1) != 1);
  stride_1_1 = (r.size(0) != 1);
  if (r.size(0) == 1) {
    loop_ub = h.size(1);
  } else {
    loop_ub = r.size(0);
  }
  for (i = 0; i < loop_ub; i++) {
    double d;
    d = r[i * stride_1_1];
    b_h[i].re = d * h[i * stride_0_1].re;
    b_h[i].im = d * h[i * stride_0_1].im;
  }
  h.set_size(1, b_h.size(1));
  loop_ub = b_h.size(1);
  for (i = 0; i < loop_ub; i++) {
    h[i] = b_h[i];
  }
}

//
// Arguments    : double u0
//                double u1
// Return Type  : double
//
static double rt_powd_snf(double u0, double u1)
{
  double y;
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    double d;
    double d1;
    d = std::abs(u0);
    d1 = std::abs(u1);
    if (std::isinf(u1)) {
      if (d == 1.0) {
        y = 1.0;
      } else if (d > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }
  return y;
}

//
// Arguments    : short L
//                double Freqz[39]
//                double Amp[39]
//                coder::array<double, 2U> &freq_response
//                coder::array<double, 2U> &y_freq
//                coder::array<creal_T, 2U> &h
// Return Type  : void
//
void middle_ear_transfer_function(short L, double Freqz[39], double Amp[39],
                                  coder::array<double, 2U> &freq_response,
                                  coder::array<double, 2U> &y_freq,
                                  coder::array<creal_T, 2U> &h)
{
  static const double dv[39]{
      20.0,    25.0,    31.5,    40.0,    50.0,    63.0,    80.0,   100.0,
      125.0,   160.0,   200.0,   250.0,   315.0,   400.0,   500.0,  630.0,
      750.0,   800.0,   1000.0,  1250.0,  1500.0,  1600.0,  2000.0, 2500.0,
      3000.0,  3150.0,  4000.0,  5000.0,  6000.0,  6300.0,  8000.0, 9000.0,
      10000.0, 11200.0, 12500.0, 14000.0, 15000.0, 16000.0, 20000.0};
  static const double dv1[39]{
      -39.2, -31.4, -25.4, -20.9, -18.0, -16.1, -14.2, -12.5, -11.1, -9.7,
      -8.4,  -7.2,  -6.1,  -4.7,  -3.7,  -3.0,  -2.7,  -2.6,  -2.6,  -2.7,
      -3.7,  -4.6,  -8.5,  -10.8, -7.3,  -6.7,  -5.7,  -5.7,  -7.6,  -8.4,
      -11.3, -10.6, -9.9,  -11.9, -13.9, -16.0, -17.3, -17.8, -20.0};
  coder::array<double, 2U> b;
  coder::array<double, 1U> r;
  creal_T tmp;
  creal_T zn;
  double delta1;
  int i;
  int inw;
  int iseven;
  int k;
  int mid;
  int nx;
  unsigned short b_tmp_data[32767];
  boolean_T tmp_data[32767];
  if (!isInitialized_middle_ear_transfer_function) {
    middle_ear_transfer_function_initialize();
  }
  std::copy(&dv[0], &dv[39], &Freqz[0]);
  std::copy(&dv1[0], &dv1[39], &Amp[0]);
  if (L < 0) {
    y_freq.set_size(1, 0);
  } else {
    y_freq.set_size(1, static_cast<int>(L));
    if (L >= 1) {
      y_freq[L - 1] = 20000.0;
      if (y_freq.size(1) >= 2) {
        y_freq[0] = 20.0;
        if (y_freq.size(1) >= 3) {
          delta1 = 19980.0 / (static_cast<double>(y_freq.size(1)) - 1.0);
          mid = y_freq.size(1);
          for (k = 0; k <= mid - 3; k++) {
            y_freq[k + 1] = (static_cast<double>(k) + 1.0) * delta1 + 20.0;
          }
        }
      }
    }
  }
  freq_response.set_size(
      1, static_cast<int>(static_cast<unsigned short>(y_freq.size(1))));
  nx = static_cast<unsigned short>(y_freq.size(1));
  for (mid = 0; mid < nx; mid++) {
    freq_response[mid] = rtNaN;
  }
  if (y_freq.size(1) != 0) {
    coder::interp1Linear(Amp, y_freq, freq_response, Freqz);
  }
  iseven = freq_response.size(1);
  nx = freq_response.size(1);
  for (mid = 0; mid < nx; mid++) {
    tmp_data[mid] = std::isnan(freq_response[mid]);
  }
  nx = iseven - 1;
  iseven = 0;
  mid = 0;
  for (i = 0; i <= nx; i++) {
    if (tmp_data[i]) {
      iseven++;
      b_tmp_data[mid] = static_cast<unsigned short>(i + 1);
      mid++;
    }
  }
  nx = iseven - 1;
  for (mid = 0; mid <= nx; mid++) {
    freq_response[b_tmp_data[mid] - 1] = -40.0;
  }
  b.set_size(1, freq_response.size(1));
  nx = freq_response.size(1);
  for (mid = 0; mid < nx; mid++) {
    b[mid] = freq_response[mid] / 20.0;
  }
  freq_response.set_size(
      1, static_cast<int>(static_cast<unsigned short>(b.size(1))));
  nx = static_cast<unsigned short>(b.size(1));
  for (k = 0; k < nx; k++) {
    freq_response[k] = rt_powd_snf(10.0, b[k]);
  }
  coder::ifft(freq_response, h);
  nx = L;
  r.set_size(static_cast<int>(L));
  if (L <= 1) {
    r.set_size(static_cast<int>(L));
    nx = L;
    for (mid = 0; mid < nx; mid++) {
      r[0] = 1.0;
    }
  } else {
    iseven = 1 - (L & 1);
    mid = (L >> 1) + 1;
    for (k = mid; k <= nx; k++) {
      double hz_im;
      double hz_re;
      double zd_re;
      delta1 = static_cast<double>(iseven + ((k - mid) << 1)) /
               (static_cast<double>(L) - 1.0);
      zd_re = 0.5 * std::sqrt((1.0 - delta1) * (delta1 + 1.0));
      if (std::isnan(zd_re)) {
        tmp.re = rtNaN;
        tmp.im = 0.0;
      } else {
        double az_tmp;
        double im;
        double re;
        int nw;
        boolean_T guard1{false};
        i = 0;
        delta1 = rt_hypotd_snf(zd_re, 0.0);
        if (delta1 > 1.0737418235E+9) {
          i = 4;
        } else if (delta1 > 32767.999992370605) {
          i = 3;
        }
        zn.re = zd_re;
        zn.im = 0.0;
        if (zd_re < 0.0) {
          zn.re = -zd_re;
          zn.im = -0.0;
        }
        tmp.re = 0.0;
        tmp.im = 0.0;
        az_tmp = rt_hypotd_snf(zn.re, zn.im);
        guard1 = false;
        if (az_tmp <= 2.0) {
          nw = 0;
          if (az_tmp == 0.0) {
            tmp.re = 1.0;
            tmp.im = 0.0;
          } else if (az_tmp < 2.2250738585072014E-305) {
            tmp.re = 1.0;
            tmp.im = 0.0;
          } else {
            double acz;
            double ak1_re;
            double cz_im;
            double cz_re;
            hz_re = 0.5 * zn.re;
            hz_im = 0.5 * zn.im;
            if (az_tmp > 4.7170688552396617E-153) {
              cz_re = hz_re * hz_re - hz_im * hz_im;
              delta1 = hz_re * hz_im;
              cz_im = delta1 + delta1;
              acz = rt_hypotd_snf(cz_re, cz_im);
            } else {
              cz_re = 0.0;
              cz_im = 0.0;
              acz = 0.0;
            }
            if (hz_re < 0.0) {
              hz_re = std::log(std::abs(hz_re));
            } else {
              hz_re = std::log(hz_re);
            }
            delta1 = 1.0;
            coder::gammaln(&delta1);
            ak1_re = hz_re * 0.0 - delta1;
            if (ak1_re > -700.92179369444591) {
              double b_atol;
              double coef_im;
              double coef_re_tmp;
              coef_re_tmp = std::exp(ak1_re);
              coef_im = coef_re_tmp * 0.0;
              b_atol = 2.2204460492503131E-16 * acz;
              hz_re = 1.0;
              hz_im = 0.0;
              if (!(acz < 2.2204460492503131E-16)) {
                double aa;
                double ak;
                double s;
                ak1_re = 1.0;
                delta1 = 0.0;
                ak = 3.0;
                s = 1.0;
                aa = 2.0;
                double rs;
                do {
                  rs = 1.0 / s;
                  re = ak1_re * cz_re - delta1 * cz_im;
                  im = ak1_re * cz_im + delta1 * cz_re;
                  ak1_re = rs * re;
                  delta1 = rs * im;
                  hz_re += ak1_re;
                  hz_im += delta1;
                  s += ak;
                  ak += 2.0;
                  aa = aa * acz * rs;
                } while (!!(aa > b_atol));
              }
              delta1 = hz_re * coef_re_tmp - hz_im * coef_im;
              hz_im = hz_re * coef_im + hz_im * coef_re_tmp;
              tmp.re = delta1 - hz_im * 0.0;
              tmp.im = delta1 * 0.0 + hz_im;
            } else {
              nw = 1;
              if (acz > 0.0) {
                nw = -1;
              }
            }
          }
          if (nw < 0) {
            inw = 1;
          } else {
            inw = nw;
          }
          if ((1 - inw != 0) && (nw < 0)) {
            guard1 = true;
          }
        } else {
          guard1 = true;
        }
        if (guard1) {
          if (az_tmp < 21.784271729432426) {
            nw = coder::cmlri(zn, &tmp);
            if (nw < 0) {
              if (nw == -2) {
                inw = -2;
              } else {
                inw = -1;
              }
            } else {
              inw = 0;
            }
          } else {
            nw = coder::casyi(zn, &tmp);
            if (nw < 0) {
              if (nw == -2) {
                inw = -2;
              } else {
                inw = -1;
              }
            } else {
              inw = 0;
            }
          }
        }
        if (inw < 0) {
          if (inw == -2) {
            i = 5;
          } else {
            i = 2;
          }
        } else if ((!(zd_re >= 0.0)) && (inw != 1)) {
          if (std::fmax(std::abs(tmp.re), std::abs(tmp.im)) <=
              1.0020841800044864E-289) {
            tmp.re *= 4.503599627370496E+15;
            tmp.im *= 4.503599627370496E+15;
            delta1 = 2.2204460492503131E-16;
          } else {
            delta1 = 1.0;
          }
          re = tmp.re - tmp.im * 0.0;
          im = tmp.re * 0.0 + tmp.im;
          tmp.re = delta1 * re;
          tmp.im = delta1 * im;
        }
        if (i == 5) {
          tmp.re = rtNaN;
          tmp.im = 0.0;
        } else if (i == 2) {
          tmp.re = rtInf;
          tmp.im = 0.0;
        }
        if (zd_re > 0.0) {
          delta1 = tmp.re;
          tmp.re = delta1;
          tmp.im = 0.0;
        }
      }
      if (tmp.im == 0.0) {
        hz_re = tmp.re / 1.0634833707413236;
        hz_im = 0.0;
      } else if (tmp.re == 0.0) {
        hz_re = 0.0;
        hz_im = tmp.im / 1.0634833707413236;
      } else {
        hz_re = tmp.re / 1.0634833707413236;
        hz_im = tmp.im / 1.0634833707413236;
      }
      r[k - 1] = rt_hypotd_snf(hz_re, hz_im);
    }
    for (k = 0; k <= mid - 2; k++) {
      r[k] = r[(L - k) - 1];
    }
  }
  if (r.size(0) == h.size(1)) {
    h.set_size(1, h.size(1));
    nx = h.size(1);
    for (mid = 0; mid < nx; mid++) {
      h[mid].re = r[mid] * h[mid].re;
      h[mid].im = r[mid] * h[mid].im;
    }
  } else {
    binary_expand_op(h, r);
  }
  delta1 = static_cast<double>(h.size(1)) / 2.0;
  if (1.0 > delta1) {
    nx = 0;
  } else {
    nx = static_cast<int>(delta1);
  }
  for (mid = 0; mid < nx; mid++) {
    h[mid] = h[mid];
  }
  h.set_size(1, nx);
}

//
// File trailer for middle_ear_transfer_function.cpp
//
// [EOF]
//
