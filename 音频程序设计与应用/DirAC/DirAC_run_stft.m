function [LSsig, DIRsig, DIFFsig, DirAC_struct] = DirAC_run_stft(insig, DirAC_struct)
%% Run-time processing of 2D or 3D virtual-microphone STFT DirAC 
%% for loudspeaker output
%% Archontis Politis and Ville Pulkki  2016

lInsig = size(insig,1); % signal length
nInChan = size(insig,2); % normally 4 for B-format
nOutChan = DirAC_struct.nOutChan;

% STFT frame count and initialization
winsize = DirAC_struct.winsize;
hopsize = winsize/2;
fftsize = 2*winsize; % double the window size to suppress aliasing
Nhop = ceil(lInsig/hopsize) + 2;
insig = [zeros(hopsize,nInChan); insig; zeros(Nhop*hopsize - lInsig - hopsize,nInChan)]; % zero padding at start and end
% arrays for non-diffuse (direct) and diffuse sound output
dirOutsig = zeros(size(insig,1)+fftsize, nOutChan);
diffOutsig = zeros(size(insig,1)+fftsize, nOutChan);
% hanning window for analysis synthesis
window = hanning(winsize);
% zero pad both window and input frame to 2*winsize to 
% suppress temporal aliasing from adaptive filters
window = [window; zeros(winsize,1)]; 
window = window*ones(1,nInChan);
% DirAC analysis initialization
DirAC_struct.Intensity_smooth = 0; % initial values for recursive smoothing
DirAC_struct.Intensity_short_smooth = 0; % initial values for recursive smoothing
DirAC_struct.energy_smooth = 0; % initial values for recursive smoothing
DirAC_struct.gains_smooth = 0;

% STFT runtime loop
for idx = 0:hopsize:(Nhop-2)*hopsize
    % zero pad both window and input frame to 2*winsize for aliasing suppression
    inFramesig = [insig(idx+(1:winsize),:); zeros(winsize,nInChan)]; 
    inFramesig = inFramesig .* window;
    % spectral processing
    inFramespec = fft(inFramesig);
    inFramespec = inFramespec(1:fftsize/2+1,:); 
    % save only positive frequency bins
    % Analysis and filter estimation
    % Estimate directional parameters from signal 
    %   using only non-interpolated spectrum
    [pars,DirAC_struct] = computeDirectionalParameters(inFramespec(1:2:end,:), DirAC_struct);   
    pos=size(DirAC_struct.parhistory,1)+1;
    DirAC_struct.parhistory(pos,:,:)=[pars];
    % Non-diffuse (direct) and diffuse sound filters
    directFilterspec = updateDirectFilters(pars, DirAC_struct); 
    diffuseFilterspec = updateDiffuseFilters(pars, DirAC_struct); 
    % Interpolate filters to fftsize
    directFilterspec = interpolateFilterSpec(directFilterspec); 
    diffuseFilterspec = interpolateFilterSpec(diffuseFilterspec); 
    %%% Synthesis of non-diffuse/diffuse streams
    % apply non-parametric decoding first (virtual microphones)
    linOutFramespec = inFramespec*DirAC_struct.decodingMtx;
    % adapt the linear decoding to the direct and diffuse streams
    dirOutFramespec = directFilterspec .* linOutFramespec;
    diffOutFramespec = diffuseFilterspec .* linOutFramespec;
    % overlap-add
    dirOutFramesig = real(ifft([dirOutFramespec; conj(dirOutFramespec(end-1:-1:2,:))]));
    dirOutsig(idx+(1:fftsize),:) = dirOutsig(idx+(1:fftsize),:) + dirOutFramesig;
    diffOutFramesig = real(ifft([diffOutFramespec; conj(diffOutFramespec(end-1:-1:2,:))]));
    diffOutsig(idx+(1:fftsize),:) = diffOutsig(idx+(1:fftsize),:) + diffOutFramesig;
end
% remove delay caused by the intepolation of gains and circular shift
dirOutsig = dirOutsig(hopsize+1:end,:);
diffOutsig = diffOutsig(hopsize+1:end,:);
% apply decorrelation to diffuse stream and remove decorrelation 
% delay if needed
if ~isempty(DirAC_struct.decorDelay) || DirAC_struct.decorDelay~=0
    tempsig = [diffOutsig; zeros(DirAC_struct.decorDelay, nOutChan)];
    tempsig = fftfilt(DirAC_struct.decorFilt, tempsig);
    diffOutsig = tempsig(DirAC_struct.decorDelay+1:end,:);
else
    diffOutsig = fftfilt(DirAC_struct.decorFilt, diffOutsig);
end
% remove delay due to windowing and truncate output to original length
DIRsig = dirOutsig(hopsize+(1:lInsig),:);
DIFFsig = diffOutsig(hopsize+(1:lInsig),:);
LSsig = DIRsig + DIFFsig;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [pars, DirAC_struct] = computeDirectionalParameters(insigSpec, DirAC_struct)

    %%% B-format analysis
    w = insigSpec(:,1); % omni
    X = insigSpec(:,2:4)/sqrt(2); 
    % dipoles /cancel B-format dipole convention
    Intensity = real(conj(w)*ones(1,3) .* X); 
    % spatially reversed normalized active intensity
    energy = (abs(w).^2 + sum(abs(X).^2,2))/2; 
    % normalized energy density
    % direction-of-arrival parameters
    alpha_dir = DirAC_struct.alpha_dir;
    Alpha_dir = alpha_dir*ones(1,3);  
    Intensity_short_smooth = Alpha_dir.*DirAC_struct.Intensity_short_smooth + (1-Alpha_dir).*Intensity;
    azi = atan2(Intensity_short_smooth(:,2), Intensity_short_smooth(:,1))*180/pi;
    elev = atan2(Intensity_short_smooth(:,3), sqrt(sum(Intensity_short_smooth(:,1:2).^2,2)))*180/pi;
    % diffuseness parameter 
    alpha_diff = DirAC_struct.alpha_diff;
    Alpha_diff = alpha_diff*ones(1,3);  
    Intensity_smooth = Alpha_diff.*DirAC_struct.Intensity_smooth + (1-Alpha_diff).*Intensity;
    Intensity_smooth_norm = sqrt(sum(Intensity_smooth.^2,2));
    energy_smooth = alpha_diff.*DirAC_struct.energy_smooth + (1-alpha_diff).*energy;
    diffuseness = 1 - Intensity_smooth_norm./(energy_smooth + eps);
    diffuseness(diffuseness<eps) = eps;
    diffuseness(diffuseness>1-eps) = 1-eps;  
    % store parameters
    pars = [azi elev energy diffuseness];
    % update values for recursive smoothing
    DirAC_struct.Intensity_short_smooth = Intensity_short_smooth;
    DirAC_struct.Intensity_smooth = Intensity_smooth;
    DirAC_struct.energy_smooth = energy_smooth;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [directFilterspec, DirAC_struct] = updateDirectFilters(pars, DirAC_struct)
 
    nOutChan = DirAC_struct.nOutChan;
    azi = pars(:,1);
    elev = pars(:,2);
    energy = pars(:,3);
    diff = pars(:,4);
    ndiff_sqrt = sqrt(1-diff); % diffuse sound suppresion filter
    ndiff_energy = energy.*(1-diff); % non-diffuse energy amount    
    % Amplitude panning gain filters
    Alpha = DirAC_struct.alpha_gain;  
    if DirAC_struct.dimension == 3
        % look-up the corresponding VBAP gains from the table
        aziIndex = round(mod(azi+180,360)/2);
        elevIndex = round((elev+90)/5);
        idx3D = elevIndex*181+aziIndex+1;
        gains = DirAC_struct.VBAPtable(idx3D,:);
    else   
        % look-up the corresponding VBAP gains from the table
        idx2D = round(mod(azi+180,360))+1;
        gains = DirAC_struct.VBAPtable(idx2D,:);
    end
    % recursive smoothing of gains (energy-weighted)
    gains_smooth = Alpha.*DirAC_struct.gains_smooth + (1-Alpha).*(ndiff_energy * ones(1,nOutChan)).*gains;
    % store smoothed gains for next update (before re-normalization)
    DirAC_struct.gains_smooth = gains_smooth;
    % re-normalization of smoothed gains to unity power
    gains_smooth = gains_smooth .* (sqrt(1./(sum(gains_smooth.^2,2)+eps))*ones(1,nOutChan));
    % Combine separation filters with panning filters, including 
    % approximate correction for the effect of virtual microphones 
    % to the direct sound
    dirCorrection = (1./sqrt(1 + diff*(DirAC_struct.invQ-1)))*ones(1,nOutChan);
    directFilterspec = gains_smooth .* (ndiff_sqrt*ones(1,nOutChan)) .* dirCorrection;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [diffuseFilterspec, DirAC_struct] = updateDiffuseFilters(pars, DirAC_struct)
 
    diff = pars(:,4);
    % Combine separation filters with approximate correction for the
    % effect of virtual microphones to the diffuse sound energy, 
    % and energy weights per loudspeaker
    diffuseFilterspec = sqrt(diff) * (DirAC_struct.diffCorrection.*DirAC_struct.lsDiffCoeff);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function intFilterspec = interpolateFilterSpec(filterspec)

    nChan = size(filterspec,2);
    hopsize = size(filterspec,1)-1;
    winsize = hopsize*2;
    % IFFT to time domain
    filterimp = ifft([filterspec; conj(filterspec(end-1:-1:2,:))]); 
    % circular shift
    filterimp = [filterimp(hopsize+1:end, :); filterimp(1:hopsize, :)]; 
    % zero-pad to 2*winsize
    filterimp = [filterimp; zeros(winsize, nChan)]; 
    intFilterspec = fft(filterimp); % back to FFT
    % save only positive frequency bins
    intFilterspec = intFilterspec(1:winsize+1, :); 
end




