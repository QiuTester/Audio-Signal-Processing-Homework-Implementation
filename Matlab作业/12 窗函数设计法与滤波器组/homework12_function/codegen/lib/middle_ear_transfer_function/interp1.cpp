//
// File: interp1.cpp
//
// MATLAB Coder version            : 5.3
// C/C++ source code generated on  : 26-Dec-2022 02:21:36
//

// Include Files
#include "interp1.h"
#include "rt_nonfinite.h"
#include "coder_array.h"

// Function Definitions
//
// Arguments    : const double y[39]
//                const ::coder::array<double, 2U> &xi
//                ::coder::array<double, 2U> &yi
//                const double varargin_1[39]
// Return Type  : void
//
namespace coder {
void interp1Linear(const double y[39], const ::coder::array<double, 2U> &xi,
                   ::coder::array<double, 2U> &yi, const double varargin_1[39])
{
  double maxx;
  double minx;
  double r;
  double r_tmp;
  int high_i;
  int low_i;
  int low_ip1;
  int mid_i;
  int ub_loop;
  minx = varargin_1[0];
  maxx = varargin_1[38];
  ub_loop = xi.size(1) - 1;
#pragma omp parallel for num_threads(omp_get_max_threads()) private(           \
    r_tmp, low_i, low_ip1, high_i, mid_i, r)

  for (int k = 0; k <= ub_loop; k++) {
    r_tmp = xi[k];
    if ((!(r_tmp > maxx)) && (!(r_tmp < minx))) {
      low_i = 1;
      low_ip1 = 2;
      high_i = 39;
      while (high_i > low_ip1) {
        mid_i = (low_i + high_i) >> 1;
        if (xi[k] >= varargin_1[mid_i - 1]) {
          low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      r_tmp = varargin_1[low_i - 1];
      r = (xi[k] - r_tmp) / (varargin_1[low_i] - r_tmp);
      if (r == 0.0) {
        yi[k] = y[low_i - 1];
      } else if (r == 1.0) {
        yi[k] = y[low_i];
      } else {
        r_tmp = y[low_i - 1];
        if (r_tmp == y[low_i]) {
          yi[k] = r_tmp;
        } else {
          yi[k] = (1.0 - r) * r_tmp + r * y[low_i];
        }
      }
    }
  }
}

} // namespace coder

//
// File trailer for interp1.cpp
//
// [EOF]
//
