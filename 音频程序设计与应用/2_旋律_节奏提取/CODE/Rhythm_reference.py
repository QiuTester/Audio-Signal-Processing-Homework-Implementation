import librosa
import os
import numpy as np

cwd = os.getcwd()
path = cwd + '/' + 'ensemble.wav'
y, fs = librosa.load(path)

onset_env = librosa.onset.onset_strength(y=y, sr=fs, aggregate=np.median)
bpm, beats = librosa.beat.beat_track(onset_envelope=onset_env, sr=fs)

print('BPM:', bpm)