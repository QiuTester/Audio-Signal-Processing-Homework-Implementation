//
// File: FFTImplementationCallback.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "FFTImplementationCallback.h"
#include "middle_ear_transfer_function_data.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <cmath>
#include <cstring>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                ::coder::array<double, 2U> &hcostab
//                ::coder::array<double, 2U> &hsintab
// Return Type  : void
//
namespace coder {
namespace internal {
namespace fft {
void FFTImplementationCallback::get_half_twiddle_tables(
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab,
    ::coder::array<double, 2U> &hcostab, ::coder::array<double, 2U> &hsintab)
{
  int hszCostab;
  hszCostab = costab.size(1) / 2;
  hcostab.set_size(1, static_cast<int>(static_cast<unsigned short>(hszCostab)));
  hsintab.set_size(1, static_cast<int>(static_cast<unsigned short>(hszCostab)));
  for (int i{0}; i < hszCostab; i++) {
    int hcostab_tmp;
    hcostab_tmp = ((i + 1) << 1) - 2;
    hcostab[i] = costab[hcostab_tmp];
    hsintab[i] = sintab[hcostab_tmp];
  }
}

//
// Arguments    : const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                const ::coder::array<double, 2U> &costabinv
//                const ::coder::array<double, 2U> &sintabinv
//                ::coder::array<double, 2U> &hcostab
//                ::coder::array<double, 2U> &hsintab
//                ::coder::array<double, 2U> &hcostabinv
//                ::coder::array<double, 2U> &hsintabinv
// Return Type  : void
//
void FFTImplementationCallback::get_half_twiddle_tables(
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab,
    const ::coder::array<double, 2U> &costabinv,
    const ::coder::array<double, 2U> &sintabinv,
    ::coder::array<double, 2U> &hcostab, ::coder::array<double, 2U> &hsintab,
    ::coder::array<double, 2U> &hcostabinv,
    ::coder::array<double, 2U> &hsintabinv)
{
  int hszCostab;
  hszCostab = costab.size(1) / 2;
  hcostab.set_size(1, static_cast<int>(static_cast<unsigned short>(hszCostab)));
  hsintab.set_size(1, static_cast<int>(static_cast<unsigned short>(hszCostab)));
  hcostabinv.set_size(1,
                      static_cast<int>(static_cast<unsigned short>(hszCostab)));
  hsintabinv.set_size(1,
                      static_cast<int>(static_cast<unsigned short>(hszCostab)));
  for (int i{0}; i < hszCostab; i++) {
    int hcostab_tmp;
    hcostab_tmp = ((i + 1) << 1) - 2;
    hcostab[i] = costab[hcostab_tmp];
    hsintab[i] = sintab[hcostab_tmp];
    hcostabinv[i] = costabinv[hcostab_tmp];
    hsintabinv[i] = sintabinv[hcostab_tmp];
  }
}

//
// Arguments    : ::coder::array<creal_T, 1U> &y
//                const ::coder::array<creal_T, 1U> &reconVar1
//                const ::coder::array<creal_T, 1U> &reconVar2
//                const ::coder::array<int, 2U> &wrapIndex
//                int hnRows
// Return Type  : void
//
void FFTImplementationCallback::getback_radix2_fft(
    ::coder::array<creal_T, 1U> &y,
    const ::coder::array<creal_T, 1U> &reconVar1,
    const ::coder::array<creal_T, 1U> &reconVar2,
    const ::coder::array<int, 2U> &wrapIndex, int hnRows)
{
  double b_temp1_re_tmp;
  double b_temp2_re_tmp;
  double b_y_re_tmp;
  double c_temp1_re_tmp;
  double c_temp2_re_tmp;
  double c_y_re_tmp;
  double d_y_re_tmp;
  double temp1_im_tmp;
  double temp1_re_tmp;
  double y_re_tmp;
  int b_i;
  int iterVar;
  iterVar = hnRows / 2;
  temp1_re_tmp = y[0].re;
  temp1_im_tmp = y[0].im;
  y[0].re =
      0.5 *
      ((temp1_re_tmp * reconVar1[0].re - temp1_im_tmp * reconVar1[0].im) +
       (temp1_re_tmp * reconVar2[0].re - -temp1_im_tmp * reconVar2[0].im));
  y[0].im =
      0.5 *
      ((temp1_re_tmp * reconVar1[0].im + temp1_im_tmp * reconVar1[0].re) +
       (temp1_re_tmp * reconVar2[0].im + -temp1_im_tmp * reconVar2[0].re));
  y[hnRows].re =
      0.5 *
      ((temp1_re_tmp * reconVar2[0].re - temp1_im_tmp * reconVar2[0].im) +
       (temp1_re_tmp * reconVar1[0].re - -temp1_im_tmp * reconVar1[0].im));
  y[hnRows].im =
      0.5 *
      ((temp1_re_tmp * reconVar2[0].im + temp1_im_tmp * reconVar2[0].re) +
       (temp1_re_tmp * reconVar1[0].im + -temp1_im_tmp * reconVar1[0].re));
  for (int i{2}; i <= iterVar; i++) {
    double temp2_im_tmp;
    double temp2_re_tmp;
    int i1;
    temp1_re_tmp = y[i - 1].re;
    temp1_im_tmp = y[i - 1].im;
    b_i = wrapIndex[i - 1];
    temp2_re_tmp = y[b_i - 1].re;
    temp2_im_tmp = y[b_i - 1].im;
    y_re_tmp = reconVar1[i - 1].im;
    b_y_re_tmp = reconVar1[i - 1].re;
    c_y_re_tmp = reconVar2[i - 1].im;
    d_y_re_tmp = reconVar2[i - 1].re;
    y[i - 1].re =
        0.5 * ((temp1_re_tmp * b_y_re_tmp - temp1_im_tmp * y_re_tmp) +
               (temp2_re_tmp * d_y_re_tmp - -temp2_im_tmp * c_y_re_tmp));
    y[i - 1].im =
        0.5 * ((temp1_re_tmp * y_re_tmp + temp1_im_tmp * b_y_re_tmp) +
               (temp2_re_tmp * c_y_re_tmp + -temp2_im_tmp * d_y_re_tmp));
    i1 = (hnRows + i) - 1;
    y[i1].re = 0.5 * ((temp1_re_tmp * d_y_re_tmp - temp1_im_tmp * c_y_re_tmp) +
                      (temp2_re_tmp * b_y_re_tmp - -temp2_im_tmp * y_re_tmp));
    y[i1].im = 0.5 * ((temp1_re_tmp * c_y_re_tmp + temp1_im_tmp * d_y_re_tmp) +
                      (temp2_re_tmp * y_re_tmp + -temp2_im_tmp * b_y_re_tmp));
    c_temp2_re_tmp = reconVar1[b_i - 1].im;
    b_temp2_re_tmp = reconVar1[b_i - 1].re;
    b_temp1_re_tmp = reconVar2[b_i - 1].im;
    c_temp1_re_tmp = reconVar2[b_i - 1].re;
    y[b_i - 1].re =
        0.5 *
        ((temp2_re_tmp * b_temp2_re_tmp - temp2_im_tmp * c_temp2_re_tmp) +
         (temp1_re_tmp * c_temp1_re_tmp - -temp1_im_tmp * b_temp1_re_tmp));
    y[b_i - 1].im =
        0.5 *
        ((temp2_re_tmp * c_temp2_re_tmp + temp2_im_tmp * b_temp2_re_tmp) +
         (temp1_re_tmp * b_temp1_re_tmp + -temp1_im_tmp * c_temp1_re_tmp));
    b_i = (b_i + hnRows) - 1;
    y[b_i].re =
        0.5 *
        ((temp2_re_tmp * c_temp1_re_tmp - temp2_im_tmp * b_temp1_re_tmp) +
         (temp1_re_tmp * b_temp2_re_tmp - -temp1_im_tmp * c_temp2_re_tmp));
    y[b_i].im =
        0.5 *
        ((temp2_re_tmp * b_temp1_re_tmp + temp2_im_tmp * c_temp1_re_tmp) +
         (temp1_re_tmp * c_temp2_re_tmp + -temp1_im_tmp * b_temp2_re_tmp));
  }
  if (iterVar != 0) {
    temp1_re_tmp = y[iterVar].re;
    temp1_im_tmp = y[iterVar].im;
    y_re_tmp = reconVar1[iterVar].im;
    b_y_re_tmp = reconVar1[iterVar].re;
    c_y_re_tmp = reconVar2[iterVar].im;
    d_y_re_tmp = reconVar2[iterVar].re;
    b_temp2_re_tmp = temp1_re_tmp * d_y_re_tmp;
    b_temp1_re_tmp = temp1_re_tmp * b_y_re_tmp;
    y[iterVar].re = 0.5 * ((b_temp1_re_tmp - temp1_im_tmp * y_re_tmp) +
                           (b_temp2_re_tmp - -temp1_im_tmp * c_y_re_tmp));
    c_temp1_re_tmp = temp1_re_tmp * c_y_re_tmp;
    c_temp2_re_tmp = temp1_re_tmp * y_re_tmp;
    y[iterVar].im = 0.5 * ((c_temp2_re_tmp + temp1_im_tmp * b_y_re_tmp) +
                           (c_temp1_re_tmp + -temp1_im_tmp * d_y_re_tmp));
    b_i = hnRows + iterVar;
    y[b_i].re = 0.5 * ((b_temp2_re_tmp - temp1_im_tmp * c_y_re_tmp) +
                       (b_temp1_re_tmp - -temp1_im_tmp * y_re_tmp));
    y[b_i].im = 0.5 * ((c_temp1_re_tmp + temp1_im_tmp * d_y_re_tmp) +
                       (c_temp2_re_tmp + -temp1_im_tmp * b_y_re_tmp));
  }
}

//
// Arguments    : const ::coder::array<creal_T, 1U> &x
//                int unsigned_nRows
//                const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                ::coder::array<creal_T, 1U> &y
// Return Type  : void
//
void FFTImplementationCallback::r2br_r2dit_trig_impl(
    const ::coder::array<creal_T, 1U> &x, int unsigned_nRows,
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab, ::coder::array<creal_T, 1U> &y)
{
  array<creal_T, 1U> b_y;
  double temp_im;
  double temp_re;
  double temp_re_tmp;
  double twid_re;
  int i;
  int iDelta2;
  int istart;
  int iy;
  int ju;
  int k;
  int nRowsD2;
  b_y.set_size(unsigned_nRows);
  if (unsigned_nRows > x.size(0)) {
    b_y.set_size(unsigned_nRows);
    for (iDelta2 = 0; iDelta2 < unsigned_nRows; iDelta2++) {
      b_y[iDelta2].re = 0.0;
      b_y[iDelta2].im = 0.0;
    }
  }
  y.set_size(b_y.size(0));
  iy = b_y.size(0);
  for (iDelta2 = 0; iDelta2 < iy; iDelta2++) {
    y[iDelta2] = b_y[iDelta2];
  }
  iDelta2 = x.size(0);
  if (iDelta2 > unsigned_nRows) {
    iDelta2 = unsigned_nRows;
  }
  istart = unsigned_nRows - 2;
  nRowsD2 = unsigned_nRows / 2;
  k = nRowsD2 / 2;
  iy = 0;
  ju = 0;
  for (i = 0; i <= iDelta2 - 2; i++) {
    boolean_T tst;
    y[iy] = x[i];
    iy = unsigned_nRows;
    tst = true;
    while (tst) {
      iy >>= 1;
      ju ^= iy;
      tst = ((ju & iy) == 0);
    }
    iy = ju;
  }
  y[iy] = x[iDelta2 - 1];
  b_y.set_size(y.size(0));
  iy = y.size(0);
  for (iDelta2 = 0; iDelta2 < iy; iDelta2++) {
    b_y[iDelta2] = y[iDelta2];
  }
  if (unsigned_nRows > 1) {
    for (i = 0; i <= istart; i += 2) {
      temp_re_tmp = b_y[i + 1].re;
      temp_im = b_y[i + 1].im;
      temp_re = b_y[i].re;
      twid_re = b_y[i].im;
      b_y[i + 1].re = temp_re - temp_re_tmp;
      b_y[i + 1].im = twid_re - temp_im;
      b_y[i].re = temp_re + temp_re_tmp;
      b_y[i].im = twid_re + temp_im;
    }
  }
  iy = 2;
  iDelta2 = 4;
  ju = ((k - 1) << 2) + 1;
  while (k > 0) {
    int b_temp_re_tmp;
    for (i = 0; i < ju; i += iDelta2) {
      b_temp_re_tmp = i + iy;
      temp_re = b_y[b_temp_re_tmp].re;
      temp_im = b_y[b_temp_re_tmp].im;
      b_y[b_temp_re_tmp].re = b_y[i].re - temp_re;
      b_y[b_temp_re_tmp].im = b_y[i].im - temp_im;
      b_y[i].re = b_y[i].re + temp_re;
      b_y[i].im = b_y[i].im + temp_im;
    }
    istart = 1;
    for (int j{k}; j < nRowsD2; j += k) {
      double twid_im;
      int ihi;
      twid_re = costab[j];
      twid_im = sintab[j];
      i = istart;
      ihi = istart + ju;
      while (i < ihi) {
        b_temp_re_tmp = i + iy;
        temp_re_tmp = b_y[b_temp_re_tmp].im;
        temp_im = b_y[b_temp_re_tmp].re;
        temp_re = twid_re * temp_im - twid_im * temp_re_tmp;
        temp_im = twid_re * temp_re_tmp + twid_im * temp_im;
        b_y[b_temp_re_tmp].re = b_y[i].re - temp_re;
        b_y[b_temp_re_tmp].im = b_y[i].im - temp_im;
        b_y[i].re = b_y[i].re + temp_re;
        b_y[i].im = b_y[i].im + temp_im;
        i += iDelta2;
      }
      istart++;
    }
    k /= 2;
    iy = iDelta2;
    iDelta2 += iDelta2;
    ju -= iy;
  }
  y.set_size(b_y.size(0));
  iy = b_y.size(0);
  for (iDelta2 = 0; iDelta2 < iy; iDelta2++) {
    y[iDelta2] = b_y[iDelta2];
  }
}

//
// Arguments    : const ::coder::array<creal_T, 1U> &x
//                int n1_unsigned
//                const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                ::coder::array<creal_T, 1U> &y
// Return Type  : void
//
void FFTImplementationCallback::b_r2br_r2dit_trig(
    const ::coder::array<creal_T, 1U> &x, int n1_unsigned,
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab, ::coder::array<creal_T, 1U> &y)
{
  double temp_im;
  double temp_re;
  double temp_re_tmp;
  double twid_re;
  int i;
  int iDelta2;
  int iheight;
  int istart;
  int iy;
  int ju;
  int k;
  int nRowsD2;
  y.set_size(n1_unsigned);
  if (n1_unsigned > x.size(0)) {
    y.set_size(n1_unsigned);
    for (iDelta2 = 0; iDelta2 < n1_unsigned; iDelta2++) {
      y[iDelta2].re = 0.0;
      y[iDelta2].im = 0.0;
    }
  }
  iheight = x.size(0);
  if (iheight > n1_unsigned) {
    iheight = n1_unsigned;
  }
  istart = n1_unsigned - 2;
  nRowsD2 = n1_unsigned / 2;
  k = nRowsD2 / 2;
  iy = 0;
  ju = 0;
  for (i = 0; i <= iheight - 2; i++) {
    boolean_T tst;
    y[iy] = x[i];
    iDelta2 = n1_unsigned;
    tst = true;
    while (tst) {
      iDelta2 >>= 1;
      ju ^= iDelta2;
      tst = ((ju & iDelta2) == 0);
    }
    iy = ju;
  }
  y[iy] = x[iheight - 1];
  if (n1_unsigned > 1) {
    for (i = 0; i <= istart; i += 2) {
      temp_re_tmp = y[i + 1].re;
      temp_im = y[i + 1].im;
      temp_re = y[i].re;
      twid_re = y[i].im;
      y[i + 1].re = temp_re - temp_re_tmp;
      y[i + 1].im = twid_re - temp_im;
      y[i].re = temp_re + temp_re_tmp;
      y[i].im = twid_re + temp_im;
    }
  }
  iy = 2;
  iDelta2 = 4;
  iheight = ((k - 1) << 2) + 1;
  while (k > 0) {
    int b_temp_re_tmp;
    for (i = 0; i < iheight; i += iDelta2) {
      b_temp_re_tmp = i + iy;
      temp_re = y[b_temp_re_tmp].re;
      temp_im = y[b_temp_re_tmp].im;
      y[b_temp_re_tmp].re = y[i].re - temp_re;
      y[b_temp_re_tmp].im = y[i].im - temp_im;
      y[i].re = y[i].re + temp_re;
      y[i].im = y[i].im + temp_im;
    }
    istart = 1;
    for (ju = k; ju < nRowsD2; ju += k) {
      double twid_im;
      int ihi;
      twid_re = costab[ju];
      twid_im = sintab[ju];
      i = istart;
      ihi = istart + iheight;
      while (i < ihi) {
        b_temp_re_tmp = i + iy;
        temp_re_tmp = y[b_temp_re_tmp].im;
        temp_im = y[b_temp_re_tmp].re;
        temp_re = twid_re * temp_im - twid_im * temp_re_tmp;
        temp_im = twid_re * temp_re_tmp + twid_im * temp_im;
        y[b_temp_re_tmp].re = y[i].re - temp_re;
        y[b_temp_re_tmp].im = y[i].im - temp_im;
        y[i].re = y[i].re + temp_re;
        y[i].im = y[i].im + temp_im;
        i += iDelta2;
      }
      istart++;
    }
    k /= 2;
    iy = iDelta2;
    iDelta2 += iDelta2;
    iheight -= iy;
  }
  if (y.size(0) > 1) {
    temp_im = 1.0 / static_cast<double>(y.size(0));
    iy = y.size(0);
    for (iDelta2 = 0; iDelta2 < iy; iDelta2++) {
      y[iDelta2].re = temp_im * y[iDelta2].re;
      y[iDelta2].im = temp_im * y[iDelta2].im;
    }
  }
}

//
// Arguments    : const ::coder::array<double, 1U> &x
//                ::coder::array<creal_T, 1U> &y
//                int nrowsx
//                int nRows
//                int nfft
//                const ::coder::array<creal_T, 1U> &wwc
//                const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                const ::coder::array<double, 2U> &costabinv
//                const ::coder::array<double, 2U> &sintabinv
// Return Type  : void
//
void FFTImplementationCallback::doHalfLengthBluestein(
    const ::coder::array<double, 1U> &x, ::coder::array<creal_T, 1U> &y,
    int nrowsx, int nRows, int nfft, const ::coder::array<creal_T, 1U> &wwc,
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab,
    const ::coder::array<double, 2U> &costabinv,
    const ::coder::array<double, 2U> &sintabinv)
{
  array<creal_T, 1U> fv;
  array<creal_T, 1U> r;
  array<creal_T, 1U> reconVar1;
  array<creal_T, 1U> reconVar2;
  array<creal_T, 1U> ytmp;
  array<double, 2U> a__1;
  array<double, 2U> b_costab;
  array<double, 2U> b_sintab;
  array<double, 2U> b_sintabinv;
  array<double, 2U> costab1q;
  array<double, 2U> costable;
  array<double, 2U> hcostab;
  array<double, 2U> hcostabinv;
  array<double, 2U> hsintab;
  array<double, 2U> hsintabinv;
  array<double, 2U> sintable;
  array<int, 2U> wrapIndex;
  cuint8_T y_data[32767];
  double a_im;
  double a_re;
  double b_im;
  double b_re;
  double e;
  int hnRows;
  int i;
  int k;
  int n;
  int nd2;
  int u0;
  boolean_T nxeven;
  hnRows = nRows / 2;
  if ((hnRows > nrowsx) && (0 <= hnRows - 1)) {
    std::memset(&y_data[0], 0, hnRows * sizeof(cuint8_T));
  }
  ytmp.set_size(hnRows);
  for (i = 0; i < hnRows; i++) {
    ytmp[i].re = 0.0;
    ytmp[i].im = y_data[i].im;
  }
  if ((x.size(0) & 1) == 0) {
    nxeven = true;
    u0 = x.size(0);
  } else if (x.size(0) >= nRows) {
    nxeven = true;
    u0 = nRows;
  } else {
    nxeven = false;
    u0 = x.size(0) - 1;
  }
  if (u0 > nRows) {
    u0 = nRows;
  }
  nd2 = nRows << 1;
  e = 6.2831853071795862 / static_cast<double>(nd2);
  n = nd2 / 2 / 2;
  costab1q.set_size(1, n + 1);
  costab1q[0] = 1.0;
  nd2 = n / 2 - 1;
  for (k = 0; k <= nd2; k++) {
    costab1q[k + 1] = std::cos(e * (static_cast<double>(k) + 1.0));
  }
  i = nd2 + 2;
  nd2 = n - 1;
  for (k = i; k <= nd2; k++) {
    costab1q[k] = std::sin(e * static_cast<double>(n - k));
  }
  costab1q[n] = 0.0;
  n = costab1q.size(1) - 1;
  nd2 = (costab1q.size(1) - 1) << 1;
  b_costab.set_size(1, nd2 + 1);
  b_sintab.set_size(1, nd2 + 1);
  b_costab[0] = 1.0;
  b_sintab[0] = 0.0;
  b_sintabinv.set_size(1, nd2 + 1);
  for (k = 0; k < n; k++) {
    b_sintabinv[k + 1] = costab1q[(n - k) - 1];
  }
  i = costab1q.size(1);
  for (k = i; k <= nd2; k++) {
    b_sintabinv[k] = costab1q[k - n];
  }
  for (k = 0; k < n; k++) {
    b_costab[k + 1] = costab1q[k + 1];
    b_sintab[k + 1] = -costab1q[(n - k) - 1];
  }
  i = costab1q.size(1);
  for (k = i; k <= nd2; k++) {
    b_costab[k] = -costab1q[nd2 - k];
    b_sintab[k] = -costab1q[k - n];
  }
  costable.set_size(1, b_costab.size(1));
  n = b_costab.size(1);
  for (i = 0; i < n; i++) {
    costable[i] = b_costab[i];
  }
  sintable.set_size(1, b_sintab.size(1));
  n = b_sintab.size(1);
  for (i = 0; i < n; i++) {
    sintable[i] = b_sintab[i];
  }
  a__1.set_size(1, b_sintabinv.size(1));
  n = b_sintabinv.size(1);
  for (i = 0; i < n; i++) {
    a__1[i] = b_sintabinv[i];
  }
  FFTImplementationCallback::get_half_twiddle_tables(
      costab, sintab, costabinv, sintabinv, hcostab, hsintab, hcostabinv,
      hsintabinv);
  reconVar1.set_size(hnRows);
  reconVar2.set_size(hnRows);
  wrapIndex.set_size(1, hnRows);
  for (nd2 = 0; nd2 < hnRows; nd2++) {
    i = nd2 << 1;
    e = sintable[i];
    a_re = costable[i];
    reconVar1[nd2].re = 1.0 - e;
    reconVar1[nd2].im = -a_re;
    reconVar2[nd2].re = e + 1.0;
    reconVar2[nd2].im = a_re;
    if (nd2 + 1 != 1) {
      wrapIndex[nd2] = (hnRows - nd2) + 1;
    } else {
      wrapIndex[0] = 1;
    }
  }
  e = static_cast<double>(u0) / 2.0;
  i = static_cast<int>(e);
  for (n = 0; n < i; n++) {
    nd2 = (hnRows + n) - 1;
    a_re = wwc[nd2].re;
    a_im = wwc[nd2].im;
    nd2 = n << 1;
    b_re = x[nd2];
    b_im = x[nd2 + 1];
    ytmp[n].re = a_re * b_re + a_im * b_im;
    ytmp[n].im = a_re * b_im - a_im * b_re;
  }
  if (!nxeven) {
    nd2 = (hnRows + static_cast<int>(e)) - 1;
    a_re = wwc[nd2].re;
    a_im = wwc[nd2].im;
    b_re = x[static_cast<int>(e) << 1];
    ytmp[static_cast<int>(e)].re = a_re * b_re + a_im * 0.0;
    ytmp[static_cast<int>(e)].im = a_re * 0.0 - a_im * b_re;
    if (static_cast<int>(e) + 2 <= hnRows) {
      i = static_cast<int>(static_cast<double>(u0) / 2.0) + 2;
      for (nd2 = i; nd2 <= hnRows; nd2++) {
        ytmp[nd2 - 1].re = 0.0;
        ytmp[nd2 - 1].im = 0.0;
      }
    }
  } else if (static_cast<int>(e) + 1 <= hnRows) {
    i = static_cast<int>(static_cast<double>(u0) / 2.0) + 1;
    for (nd2 = i; nd2 <= hnRows; nd2++) {
      ytmp[nd2 - 1].re = 0.0;
      ytmp[nd2 - 1].im = 0.0;
    }
  }
  nd2 = static_cast<int>(static_cast<double>(nfft) / 2.0);
  FFTImplementationCallback::r2br_r2dit_trig_impl(ytmp, nd2, hcostab, hsintab,
                                                  fv);
  FFTImplementationCallback::r2br_r2dit_trig(wwc, nd2, hcostab, hsintab, r);
  n = fv.size(0);
  for (i = 0; i < n; i++) {
    e = fv[i].re;
    a_re = r[i].im;
    a_im = fv[i].im;
    b_re = r[i].re;
    fv[i].re = e * b_re - a_im * a_re;
    fv[i].im = e * a_re + a_im * b_re;
  }
  FFTImplementationCallback::b_r2br_r2dit_trig(fv, nd2, hcostabinv, hsintabinv,
                                               r);
  fv.set_size(r.size(0));
  n = r.size(0);
  for (i = 0; i < n; i++) {
    fv[i] = r[i];
  }
  i = wwc.size(0);
  for (k = hnRows; k <= i; k++) {
    e = wwc[k - 1].re;
    a_re = fv[k - 1].im;
    a_im = wwc[k - 1].im;
    b_re = fv[k - 1].re;
    b_im = e * b_re + a_im * a_re;
    e = e * a_re - a_im * b_re;
    if (e == 0.0) {
      nd2 = k - hnRows;
      ytmp[nd2].re = b_im / static_cast<double>(hnRows);
      ytmp[nd2].im = 0.0;
    } else if (b_im == 0.0) {
      nd2 = k - hnRows;
      ytmp[nd2].re = 0.0;
      ytmp[nd2].im = e / static_cast<double>(hnRows);
    } else {
      nd2 = k - hnRows;
      ytmp[nd2].re = b_im / static_cast<double>(hnRows);
      ytmp[nd2].im = e / static_cast<double>(hnRows);
    }
  }
  for (nd2 = 0; nd2 < hnRows; nd2++) {
    double b_ytmp_re_tmp;
    double ytmp_im_tmp;
    double ytmp_re_tmp;
    i = wrapIndex[nd2];
    e = ytmp[nd2].re;
    a_re = reconVar1[nd2].im;
    a_im = ytmp[nd2].im;
    b_re = reconVar1[nd2].re;
    b_im = ytmp[i - 1].re;
    ytmp_im_tmp = -ytmp[i - 1].im;
    ytmp_re_tmp = reconVar2[nd2].im;
    b_ytmp_re_tmp = reconVar2[nd2].re;
    y[nd2].re = 0.5 * ((e * b_re - a_im * a_re) +
                       (b_im * b_ytmp_re_tmp - ytmp_im_tmp * ytmp_re_tmp));
    y[nd2].im = 0.5 * ((e * a_re + a_im * b_re) +
                       (b_im * ytmp_re_tmp + ytmp_im_tmp * b_ytmp_re_tmp));
    i = hnRows + nd2;
    y[i].re = 0.5 * ((e * b_ytmp_re_tmp - a_im * ytmp_re_tmp) +
                     (b_im * b_re - ytmp_im_tmp * a_re));
    y[i].im = 0.5 * ((e * ytmp_re_tmp + a_im * b_ytmp_re_tmp) +
                     (b_im * a_re + ytmp_im_tmp * b_re));
  }
  n = y.size(0);
  for (i = 0; i < n; i++) {
    b_im = y[i].re;
    e = y[i].im;
    if (e == 0.0) {
      a_re = b_im / 2.0;
      e = 0.0;
    } else if (b_im == 0.0) {
      a_re = 0.0;
      e /= 2.0;
    } else {
      a_re = b_im / 2.0;
      e /= 2.0;
    }
    y[i].re = a_re;
    y[i].im = e;
  }
}

//
// Arguments    : const ::coder::array<double, 1U> &x
//                ::coder::array<creal_T, 1U> &y
//                int unsigned_nRows
//                const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
// Return Type  : void
//
void FFTImplementationCallback::doHalfLengthRadix2(
    const ::coder::array<double, 1U> &x, ::coder::array<creal_T, 1U> &y,
    int unsigned_nRows, const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab)
{
  array<creal_T, 1U> b_y;
  array<creal_T, 1U> reconVar1;
  array<creal_T, 1U> reconVar2;
  array<double, 2U> hcostab;
  array<double, 2U> hsintab;
  array<int, 2U> wrapIndex;
  array<int, 1U> bitrevIndex;
  double temp_im;
  double temp_re;
  double temp_re_tmp;
  double twid_re;
  double z;
  int i;
  int iDelta;
  int istart;
  int iy;
  int j;
  int ju;
  int k;
  int nRows;
  int nRowsD2;
  int nRowsM2;
  boolean_T tst;
  nRows = unsigned_nRows / 2;
  istart = y.size(0);
  if (istart > nRows) {
    istart = nRows;
  }
  nRowsM2 = nRows - 2;
  nRowsD2 = nRows / 2;
  k = nRowsD2 / 2;
  FFTImplementationCallback::get_half_twiddle_tables(costab, sintab, hcostab,
                                                     hsintab);
  reconVar1.set_size(nRows);
  reconVar2.set_size(nRows);
  wrapIndex.set_size(1, nRows);
  for (i = 0; i < nRows; i++) {
    temp_re = sintab[i];
    temp_im = costab[i];
    reconVar1[i].re = temp_re + 1.0;
    reconVar1[i].im = -temp_im;
    reconVar2[i].re = 1.0 - temp_re;
    reconVar2[i].im = temp_im;
    if (i + 1 != 1) {
      wrapIndex[i] = (nRows - i) + 1;
    } else {
      wrapIndex[0] = 1;
    }
  }
  z = static_cast<double>(unsigned_nRows) / 2.0;
  ju = 0;
  iy = 1;
  iDelta = static_cast<int>(static_cast<double>(unsigned_nRows) / 2.0);
  bitrevIndex.set_size(iDelta);
  for (j = 0; j < iDelta; j++) {
    bitrevIndex[j] = 0;
  }
  for (j = 0; j <= istart - 2; j++) {
    bitrevIndex[j] = iy;
    iDelta = static_cast<int>(z);
    tst = true;
    while (tst) {
      iDelta >>= 1;
      ju ^= iDelta;
      tst = ((ju & iDelta) == 0);
    }
    iy = ju + 1;
  }
  bitrevIndex[istart - 1] = iy;
  if ((x.size(0) & 1) == 0) {
    tst = true;
    istart = x.size(0);
  } else if (x.size(0) >= unsigned_nRows) {
    tst = true;
    istart = unsigned_nRows;
  } else {
    tst = false;
    istart = x.size(0) - 1;
  }
  if (istart > unsigned_nRows) {
    istart = unsigned_nRows;
  }
  temp_re = static_cast<double>(istart) / 2.0;
  j = static_cast<int>(temp_re);
  for (i = 0; i < j; i++) {
    iDelta = i << 1;
    y[bitrevIndex[i] - 1].re = x[iDelta];
    y[bitrevIndex[i] - 1].im = x[iDelta + 1];
  }
  if (!tst) {
    j = bitrevIndex[static_cast<int>(temp_re)] - 1;
    y[j].re = x[static_cast<int>(temp_re) << 1];
    y[j].im = 0.0;
  }
  b_y.set_size(y.size(0));
  iDelta = y.size(0);
  for (j = 0; j < iDelta; j++) {
    b_y[j] = y[j];
  }
  if (nRows > 1) {
    for (i = 0; i <= nRowsM2; i += 2) {
      temp_re_tmp = b_y[i + 1].re;
      temp_re = b_y[i + 1].im;
      temp_im = b_y[i].re;
      twid_re = b_y[i].im;
      b_y[i + 1].re = temp_im - temp_re_tmp;
      b_y[i + 1].im = twid_re - temp_re;
      b_y[i].re = temp_im + temp_re_tmp;
      b_y[i].im = twid_re + temp_re;
    }
  }
  iDelta = 2;
  iy = 4;
  ju = ((k - 1) << 2) + 1;
  while (k > 0) {
    for (i = 0; i < ju; i += iy) {
      nRowsM2 = i + iDelta;
      temp_re = b_y[nRowsM2].re;
      temp_im = b_y[nRowsM2].im;
      b_y[nRowsM2].re = b_y[i].re - temp_re;
      b_y[nRowsM2].im = b_y[i].im - temp_im;
      b_y[i].re = b_y[i].re + temp_re;
      b_y[i].im = b_y[i].im + temp_im;
    }
    istart = 1;
    for (j = k; j < nRowsD2; j += k) {
      double twid_im;
      twid_re = hcostab[j];
      twid_im = hsintab[j];
      i = istart;
      nRows = istart + ju;
      while (i < nRows) {
        nRowsM2 = i + iDelta;
        temp_re_tmp = b_y[nRowsM2].im;
        temp_im = b_y[nRowsM2].re;
        temp_re = twid_re * temp_im - twid_im * temp_re_tmp;
        temp_im = twid_re * temp_re_tmp + twid_im * temp_im;
        b_y[nRowsM2].re = b_y[i].re - temp_re;
        b_y[nRowsM2].im = b_y[i].im - temp_im;
        b_y[i].re = b_y[i].re + temp_re;
        b_y[i].im = b_y[i].im + temp_im;
        i += iy;
      }
      istart++;
    }
    k /= 2;
    iDelta = iy;
    iy += iy;
    ju -= iDelta;
  }
  y.set_size(b_y.size(0));
  iDelta = b_y.size(0);
  for (j = 0; j < iDelta; j++) {
    y[j] = b_y[j];
  }
  FFTImplementationCallback::getback_radix2_fft(y, reconVar1, reconVar2,
                                                wrapIndex, static_cast<int>(z));
}

//
// Arguments    : const ::coder::array<creal_T, 1U> &x
//                int n1_unsigned
//                const ::coder::array<double, 2U> &costab
//                const ::coder::array<double, 2U> &sintab
//                ::coder::array<creal_T, 1U> &y
// Return Type  : void
//
void FFTImplementationCallback::r2br_r2dit_trig(
    const ::coder::array<creal_T, 1U> &x, int n1_unsigned,
    const ::coder::array<double, 2U> &costab,
    const ::coder::array<double, 2U> &sintab, ::coder::array<creal_T, 1U> &y)
{
  double temp_im;
  double temp_re;
  double temp_re_tmp;
  double twid_re;
  int i;
  int iDelta2;
  int iheight;
  int iy;
  int ju;
  int k;
  int nRowsD2;
  y.set_size(n1_unsigned);
  if (n1_unsigned > x.size(0)) {
    y.set_size(n1_unsigned);
    for (iy = 0; iy < n1_unsigned; iy++) {
      y[iy].re = 0.0;
      y[iy].im = 0.0;
    }
  }
  iDelta2 = x.size(0);
  if (iDelta2 > n1_unsigned) {
    iDelta2 = n1_unsigned;
  }
  iheight = n1_unsigned - 2;
  nRowsD2 = n1_unsigned / 2;
  k = nRowsD2 / 2;
  iy = 0;
  ju = 0;
  for (i = 0; i <= iDelta2 - 2; i++) {
    boolean_T tst;
    y[iy] = x[i];
    iy = n1_unsigned;
    tst = true;
    while (tst) {
      iy >>= 1;
      ju ^= iy;
      tst = ((ju & iy) == 0);
    }
    iy = ju;
  }
  y[iy] = x[iDelta2 - 1];
  if (n1_unsigned > 1) {
    for (i = 0; i <= iheight; i += 2) {
      temp_re_tmp = y[i + 1].re;
      temp_im = y[i + 1].im;
      temp_re = y[i].re;
      twid_re = y[i].im;
      y[i + 1].re = temp_re - temp_re_tmp;
      y[i + 1].im = twid_re - temp_im;
      y[i].re = temp_re + temp_re_tmp;
      y[i].im = twid_re + temp_im;
    }
  }
  iy = 2;
  iDelta2 = 4;
  iheight = ((k - 1) << 2) + 1;
  while (k > 0) {
    int b_temp_re_tmp;
    for (i = 0; i < iheight; i += iDelta2) {
      b_temp_re_tmp = i + iy;
      temp_re = y[b_temp_re_tmp].re;
      temp_im = y[b_temp_re_tmp].im;
      y[b_temp_re_tmp].re = y[i].re - temp_re;
      y[b_temp_re_tmp].im = y[i].im - temp_im;
      y[i].re = y[i].re + temp_re;
      y[i].im = y[i].im + temp_im;
    }
    ju = 1;
    for (int j{k}; j < nRowsD2; j += k) {
      double twid_im;
      int ihi;
      twid_re = costab[j];
      twid_im = sintab[j];
      i = ju;
      ihi = ju + iheight;
      while (i < ihi) {
        b_temp_re_tmp = i + iy;
        temp_re_tmp = y[b_temp_re_tmp].im;
        temp_im = y[b_temp_re_tmp].re;
        temp_re = twid_re * temp_im - twid_im * temp_re_tmp;
        temp_im = twid_re * temp_re_tmp + twid_im * temp_im;
        y[b_temp_re_tmp].re = y[i].re - temp_re;
        y[b_temp_re_tmp].im = y[i].im - temp_im;
        y[i].re = y[i].re + temp_re;
        y[i].im = y[i].im + temp_im;
        i += iDelta2;
      }
      ju++;
    }
    k /= 2;
    iy = iDelta2;
    iDelta2 += iDelta2;
    iheight -= iy;
  }
}

} // namespace fft
} // namespace internal
} // namespace coder

//
// File trailer for FFTImplementationCallback.cpp
//
// [EOF]
//
