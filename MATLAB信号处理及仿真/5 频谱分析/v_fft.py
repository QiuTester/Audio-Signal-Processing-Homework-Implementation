import math

def v_fft(x, N, inv):           # inv=1:FFT；inv=-1:IFFT
    if N == 1: return           # 递归出口（分解只剩最后一项）

    N_half = N // 2
    E = [0] * N_half           # E:偶数项
    O = [0] * N_half           # O:奇数项
    for k in range(0, N-1, 2):  # X[k] -> E[k] + W[1,k]*O[k]（奇偶分解）
        E[k//2] = x[k]
        O[k//2] = x[k+1]

    v_fft(E, N_half, inv)      # 偶数项递归
    v_fft(O, N_half, inv)      # 奇数项递归

    w0 = complex(1, 0)             # 奇数项提取的公因数W[1, k](此时为W[1, 0])
    wn = complex(math.cos(2 * math.pi / N), -inv * math.sin(2 * math.pi / N)) 
                                   # 正变换和逆变换的区别其实相当于因子共轭关系，逆变换最后多乘一个1/N即可
    
    for k in range(0, N_half):
        x[k] = E[k] + w0 * O[k]          # X[k] = E[k] + W[1, k]*O[k]
        x[k + N//2] = E[k] - w0 * O[k]   # X[k+N/2] = E[k] - W[1,k]*O[k]
        w0 *= wn                         # 奇数项公因数W[1, k]，与k成正比

x = [1, 2, 3, 4, 5, 6, 7, 8]
N = 8
v_fft(x, N, 1)        # 正变换
for i in range(0, N):
    print(x[i])

v_fft(x, N, -1)
for i in range(0, N): # 逆变换
    print(x[i].real / N)