function Sp_Structure = DOA_Estimator(InputSigConva, ArraySetup, Wavelength, TotalSourceNum)

    Sp_Structure = music_1d(InputSigConva, TotalSourceNum, ArraySetup, Wavelength, 180, 'RefineEstimates', true);

end