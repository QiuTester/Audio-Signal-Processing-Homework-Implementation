clc; close all; clear;

per_win = hamming(8, "symmetric");
sym_win = hamming(7, "periodic");

wvt = wvtool(sym_win, per_win);
legend(wvt.CurrentAxes,'Symmetric','Periodic')

