function DirAC_struct = DirAC_init_stft(ls_dirs, fs)
% Return different processing parameters for DirAC processing
% Archontis Politis and Ville Pulkki 2016

if fs == 44100 | fs == 48000
    DirAC_struct.fs = fs; % Sample rate
else
    disp('Sample rate has to be 44.1 or 48 kHz');
    return
end

DirAC_struct.ls_dirs = ls_dirs;
% 2D/3D test
if min(size(ls_dirs))==1 || all(ls_dirs(:,2)==0)
    DirAC_struct.dimension = 2;
else
    DirAC_struct.dimension = 3;
end
nOutChan = length(ls_dirs);
DirAC_struct.nOutChan = nOutChan;

% compute VBAP gain table
DirAC_struct.VBAPtable = getGainTable(ls_dirs);
% compute virtual-microphone/ambisonic static decoding matrix
dirCoeff = (sqrt(3)-1)/2; % supercardioid virtual microphones
DirAC_struct.decodingMtx = computeVMICdecMtx(ls_dirs, dirCoeff);
% load/design decorrelating filters
[DirAC_struct.decorFilt, DirAC_struct.decorDelay] = computeDecorrelators(nOutChan, fs);
% winsize for STFT, with 50% overlap
DirAC_struct.winsize = 1024; % about 20ms
% smoothing parameters
DirAC_struct.dirsmooth_cycles = 20;
DirAC_struct.dirsmooth_limf = 3000;
DirAC_struct.diffsmooth_cycles = 50;
DirAC_struct.diffsmooth_limf = 10000;
DirAC_struct.gainsmooth_cycles = 200;
DirAC_struct.gainsmooth_limf = 1500;
% compute recursive smoothing coefficients for the given above values
freq = (0:DirAC_struct.winsize/2)'*fs/DirAC_struct.winsize;
period = 1./freq;
period(1) = period(2); % omit infinity value for DC

% diffuseness smoothing time constant in sec
tau_diff = period*DirAC_struct.diffsmooth_cycles;
% diffuseness smoothing recursive coefficient
alpha_diff = exp(-DirAC_struct.winsize./(2*tau_diff*fs));
% limit recursive coefficient
alpha_diff(freq>DirAC_struct.diffsmooth_limf) = min(alpha_diff(freq<=DirAC_struct.diffsmooth_limf));
DirAC_struct.alpha_diff = alpha_diff;

% direction smoothing time constant in sec
tau_dir = period*DirAC_struct.dirsmooth_cycles;
% diffuseness smoothing recursive coefficient
alpha_dir = exp(-DirAC_struct.winsize./(2*tau_dir*fs));
% limit recursive coefficient
alpha_dir(freq>DirAC_struct.dirsmooth_limf) = min(alpha_dir(freq<=DirAC_struct.dirsmooth_limf));
DirAC_struct.alpha_dir = alpha_dir;

% gain smoothing time constant in sec
tau_gain = period*DirAC_struct.gainsmooth_cycles;
% gain smoothing recursive coefficient
alpha_gain = exp(-DirAC_struct.winsize./(2*tau_gain*fs));
% limit recursive coefficient
alpha_gain(freq>DirAC_struct.gainsmooth_limf) = min(alpha_gain(freq<=DirAC_struct.gainsmooth_limf));
DirAC_struct.alpha_gain = alpha_gain * ones(1,nOutChan);

% Inverse directivity factor of vmics
DirAC_struct.invQ = dirCoeff^2 + (1/3)*(1-dirCoeff)^2;
Q = 1./DirAC_struct.invQ; % directivity factor of vmics
% correction factor for energy of diffuse sound
DirAC_struct.diffCorrection = sqrt(Q)*ones(1,nOutChan);

% Diffuse energy proportion to each loudspeaker.
DirAC_struct.lsDiffCoeff = sqrt(1/nOutChan)*ones(1,nOutChan);
DirAC_struct.parhistory = [];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function VMICdecMtx = computeVMICdecMtx(ls_dirs, alpha)
% virtual microphone type d(theta) = alpha + (1-alpha)*cos(theta)
% reshape ls_dirs, if 2D vector
if min(size(ls_dirs))==1
    if isrow(ls_dirs), ls_dirs = ls_dirs'; end
    ls_dirs(:,2) = zeros(size(ls_dirs));
end
% get the unit vectors of each vmic direction
Nvmic = size(ls_dirs, 1);
u_vmic = zeros(Nvmic, 3);
[u_vmic(:,1), u_vmic(:,2), u_vmic(:,3)] = sph2cart(ls_dirs(:,1)*pi/180, ls_dirs(:,2)*pi/180, ones(Nvmic, 1));
% divide dipoles with /sqrt(2) due to B-format convention
VMICdecMtx = [alpha*ones(Nvmic, 1) 1/sqrt(2)*(1-alpha)*u_vmic]';
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [decorFilt, decorDelay] = computeDecorrelators(nOutChan, fs)
% calls function that designs FIR filters for decorrelation
%decorFilt = compute_delay_decorrelation_response(fs,nOutChan);
decorDelay = 1500;

%This script creates decorrelation filters that have randomly
% delayed impulses at different frequency bands.
order = 3000;       %order of the bandpass filters
len = 1024*8;       %length of the decorrelation filters
maxdel = 80;        %maximum delay of the filters
mindel = 3;         %minimum delay of the filters
minmaxlocal = 30;   %above 1500Hz the value for delay upper limit
maxminlocal = 20;   %below 1500Hz the value for delay upper limit
mincycles = 10;     %mininum amount of delay in cycles
maxcycles = 40;     %maximum amount of delay in cycles

%compute the values in samples
maxdelN = round(maxdel/1000*fs);
mindelN = round(mindel/1000*fs);
minmaxlocalN = round(minmaxlocal/1000*fs);
maxminlocalN = round(maxminlocal/1000*fs);
if maxdelN > len-(order+1)
    maxdelN = len-(order+1);
end
if minmaxlocalN > maxdelN
    minmaxlocalN = maxdelN;
end
% Compute frequency band
[fpart, npart] = makepart_constcut(200, 2, nOutChan);
cutoff_f = fpart;
cutoff = cutoff_f/fs*2;
cycleN = fs./cutoff_f;
%compute the bandpass filters
h = zeros(order+1,npart,nOutChan);
for j = 1:nOutChan
    h(:,1,j) = fir1(order, cutoff(1,j),'low');
    for i = 2:npart
        h(:,i,j) = fir1(order, [cutoff(i-1,j) cutoff(i,j)], 'bandpass');
    end
end
% Compute the maximum and minimum delays
curveon = ones(npart,1);
mindellocalN = zeros(npart,1);
maxdellocalN = zeros(npart,1);
for i = 1:npart
    maxdellocalN(i) = round(maxcycles*(1/cutoff_f(i))*fs);
    mindellocalN(i) = round(mincycles*(1/cutoff_f(i))*fs);
    if maxdellocalN(i) > maxdelN
        maxdellocalN(i) = maxdelN;
    end
    if maxdellocalN(i) < minmaxlocalN
        maxdellocalN(i) = minmaxlocalN;
        curveon(i) = 0;
    end
    if mindellocalN(i) < mindelN
        mindellocalN(i) = mindelN;
    end
    if mindellocalN(i) > maxminlocalN
        mindellocalN(i) = maxminlocalN;
    end
end
%convert to samples
maxdellocal = maxdellocalN/fs*1000;
mindellocal = mindellocalN/fs*1000;
delvariation = maxdellocal - mindellocal;
cycleT = cycleN/fs*1000;
%randomize the delays of the first band
decorFilt = zeros(len,nOutChan);
delayinit = (maxdelN-mindellocalN(1))*rand(1,nOutChan)+mindellocalN(1);
delay(1,:) = round(delayinit);
% Compute the frequency-dependent delay curve for each loudspeaker channel.
% A heuristic approach is used to form the curve, which limits how
% the delay varies between adjacent frequency channels.
for m = 1:nOutChan
    for i = 2:npart
        cycles = 0.5*i*i+1;
        if curveon(i) == 0
            delchange = cycleN(i-1,m)*(round(rand(1,1)*cycles*2-cycles));
        else
            delchange = cycleN(i-1,m)*(round(rand(1,1)*cycles*2-1.3*cycles));
        end
        delay(i,m) = delay(i-1,m) + delchange;
        if delay(i,m) < mindellocalN(i)
            k = 0;
            while delay(i,m) < mindellocalN(i)
                delay(i,m) = delay(i,m) + cycleN(i-1,m);
                k = k+1;
            end
            if curveon(i) == 0
                delay(i,m) = delay(i,m) + round(k/2)*cycleN(i-1,m);
            end
            while delay(i,m) > maxdellocalN(i)
                delay(i,m) = delay(i,m) - cycleN(i-1,m);
            end
        elseif delay(i,m) > maxdellocalN(i)
            k = 0;
            while delay(i,m) > maxdellocalN(i)
                delay(i,m) = delay(i,m) - cycleN(i-1,m);
                k = k+1;
            end
            if curveon(i) == 0
                delay(i,m) = delay(i,m) - round(k/2)*cycleN(i-1,m);
            end
            while delay(i,m) < mindellocalN(i)
                delay(i,m) = delay(i,m) + cycleN(i-1,m);
            end
        end
        delay(i,m) = round(delay(i,m));
    end
    
    % Summing up the response from band-pass impulse responses
    hdelayed = zeros(len,npart);
    for i = 1:npart
        hdelayed(delay(i,m)+1:delay(i,m)+order+1,i) = h(:,i,m);
    end
    for i = 1:npart
        decorFilt(:,m) = decorFilt(:,m) + hdelayed(:,i);
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fpart npart] = makepart_constcut(first_band, bandsize, channels)
%%%% Compute auditory frequency bands
erb_bands = zeros(100,1); erb_bands(1) = first_band; lastband = 100; i = 2;
freq_upper_band = erb_bands(1);
while freq_upper_band < 20000
    erb = 24.7 + 0.108 * freq_upper_band;  % Compute the width of the band.
    % Compute the new upper limit of the band.
    freq_upper_band = freq_upper_band + bandsize*erb;
    erb_bands(i) = freq_upper_band;
    i = i + 1;
end
lastband = min([lastband i-1]);
erb_bands = round(erb_bands);
erb_bands = erb_bands(1:lastband);
erb_bands(lastband) = 22000;
fpart = erb_bands*ones(1,channels);
npart = size(fpart,1);
end