import librosa
import matplotlib.pyplot as plt
import numpy as np

y, sr = librosa.load('/Users/qiu/Desktop/Matlab作业/Matlab第五次作业/audiofile/犬夜叉.wav')
frame_length = 1024
f0, voiced_flag, voiced_probs = librosa.pyin(y, fmin=librosa.note_to_hz('C2'), fmax=librosa.note_to_hz('C7'), sr=sr, 
                                            frame_length=frame_length, hop_length=frame_length//4, fill_na=None)
Y = librosa.stft(y, n_fft=frame_length, win_length=frame_length)
Y_power = np.abs(Y) ** 2
Y_power_max = [ ]

for i in range(0, Y.shape[0]):
    max_index = np.argmax(Y[i])
    Y_power_max[i] = Y_power[i][max_index]
print(Y_power_max)

times = librosa.times_like(f0)
plt.plot(times, f0)
plt.title('PYIN calculate fundamental frequency')
plt.show()