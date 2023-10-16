%% The main DirAC script 
%% Archontis Politis and Ville Pulkki 2016

clear; close all; fs=48000; 
siglen=12*fs; % length of signal

% Sawtooth signals with repeated exp-decaying temporal envelope
% sig1=(mod([1:siglen]',200)/200-0.5) .* (10.^((mod([siglen:-1:1]',fs/5)/(fs/10)))-1)/10;
% sig2=(mod([1:siglen]',321)/321-0.5) .* (10.^((mod([siglen:-1:1]',fs/2)/(fs/4)))-1)/10;
% % Simulate B-format signals for the sources 
% azi1=[1:siglen]'/siglen*3*360; % changing source azimuth for sig1
% ele1=[1:siglen]'*0; % constant elevation for sig1
% azi2=round([1:siglen]'/siglen)*180-90; % azi for sig2
% ele2=[1:siglen/2 siglen/2:-1:1]'/siglen*180; % changing elev for sig2
% bw=(sig1+sig2)/sqrt(2);
% bx=sig1.*cos(azi1/180*pi).*cos(ele1/180)+sig2.*cos(azi2/180*pi).*cos(ele2/180*pi); 
% by=sig1.*sin(azi1/180*pi).*cos(ele1/180)+sig2.*sin(azi2/180*pi).*cos(ele2/180*pi);
% bz=sig1.*sin(ele1/180*pi)+sig2.*sin(ele2/180*pi);
% 
% % Add fading in diffuse low-passed noise about evenly in 3D 
% [b,a]=butter(1,[500/fs/2]); 
% for azi=0:10:1430 % four azi rotations in 10deg steps, random elevation
%     ele=asin(rand*2-1)/pi*180;
%     noise=filter(b,a,5*(rand(siglen,1)-0.5)).*(10.^((([1:siglen]'/siglen)-1)*2));
%     bw=bw+noise/sqrt(2);
%     bx=bx+noise*cos(azi/180*pi)*cos(ele/180*pi);
%     by=by+noise*sin(azi/180*pi)*cos(ele/180*pi);
%     bz=bz+noise*sin(ele/180*pi);
% end
% Alternatively, B-format audio load with bw scaled down by sqrt(2). 
[xx,fs]=audioread('/Users/qiu/Downloads/1272-128104-0000_B_01.wav'); 
bw=xx(:,1); bx=xx(:,2); by=xx(:,3); bz=xx(:,4);

%% 2D PROCESSING %%%%
% Compose B-format and discard Z-component for 2D processing
bfsig_2D = [bw bx by bz*0]; 
bfsig_2D=bfsig_2D/max(max(abs(bfsig_2D)))/3;
bfsig_2D(end-500:end,:) = bfsig_2D(end-500:end,:) .* (linspace(1,0,501)'*[1 1 1 1]); 
% Define the directions of loudspeakers 
ls_dirs_2D = [-89 0 89]'; % 7.1 surround
%Initialize DirAC parameters
DirAC_struct = DirAC_init_stft(ls_dirs_2D, fs);
% Linear decoding + write loudspeaker signals to disk
LINsig_2D = bfsig_2D*DirAC_struct.decodingMtx/sqrt(7); 
audiowrite(['Output2D-LIN.wav'], LINsig_2D, fs); 

% DirAC processing + write loudspeaker signals to disk
[LSsig_2D, DIRsig_2D, DIFFsig_2D, DirAC_struct] = DirAC_run_stft(bfsig_2D, DirAC_struct);
audiowrite(['Output2D-DirAC.wav'], LSsig_2D, fs);
% Plot spatial metadata
figure; imagesc(DirAC_struct.parhistory(:,:,1)'); colorbar; title('Azimuth / 2D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');
figure; imagesc(DirAC_struct.parhistory(:,:,2)'); colorbar; title('Elevation / 2D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');
figure; imagesc(DirAC_struct.parhistory(:,:,4)'); colorbar; title('Diffuseness / 2D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');

% Simple simulation of LS listening with headphones
HPsig_LIN2D=Headphone_ITDILD_simulation(LINsig_2D, DirAC_struct);
HPsig_DirAC2D=Headphone_ITDILD_simulation(LSsig_2D, DirAC_struct);

%Listen to resulting headphone audio
%soundsc(bw,fs); disp('Mono reference'); pause(siglen/fs);
%soundsc(HPsig_DirAC2D,fs); disp('DirAC 2D'); pause(siglen/fs);
%soundsc(HPsig_LIN2D,fs); disp('Linear decoding 2D'); pause(siglen/fs)

%% 3D PROCESSING %%%%%%
ls_dirs_3D = [-30 0; 0 0; 30 0; -110 0; 110 0; -150 0;  150 0; -45 45; 45 45; -135 45; 135 45; 0 -90;]; 
% 7.1.4 surround + virtual channel below. 

%B-format signal
bfsig_3D = [bw bx by bz];bfsig_3D=bfsig_3D/max(max(abs(bfsig_3D)))/3;
bfsig_3D(end-500:end,:) = bfsig_3D(end-500:end,:) .* (linspace(1,0,501)'*[1 1 1 1]); 
DirAC_struct.parhistory = [];
DirAC_struct = DirAC_init_stft(ls_dirs_3D, fs);

% Linear decoding + store audio
LINsig_3D = bfsig_3D*DirAC_struct.decodingMtx/sqrt(12);
% Adding virtual channel to other loudspeakers
LINsig_3D=LINsig_3D(:,1:end-1) + LINsig_3D(:,end)*ones(1,DirAC_struct.nOutChan-1)/(DirAC_struct.nOutChan-1);
audiowrite('Output3D-LIN.wav',LINsig_3D,fs);

% DirAC processing + store audio
DirAC_struct.parhistory = [];
[LSsig_3D, DIRsig_3D, DIFFsig_3D, DirAC_struct] = DirAC_run_stft(bfsig_3D, DirAC_struct);
% Apply virtual loudspeaker to all other loudspeakers.
LSsig_3D=LSsig_3D(:,1:end-1) + LSsig_3D(:,end)*ones(1,DirAC_struct.nOutChan-1)/(DirAC_struct.nOutChan-1);
audiowrite(['Output3D-DirAC.wav'],LSsig_3D,fs)

% Plot directional parameters
figure; imagesc(DirAC_struct.parhistory(:,:,1)'); colorbar; title('Azimuth / 3D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');
figure; imagesc(DirAC_struct.parhistory(:,:,2)'); colorbar; title('Elevation / 3D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');
figure; imagesc(DirAC_struct.parhistory(:,:,4)'); colorbar; title('Diffuseness / 3D case'); xlabel('Time frame'); ylabel('Freq bin');set(gca,'YDir','normal');

%% Create headphone signals with simple ILD-ITD modeling
HPsig_LIN3D=Headphone_ITDILD_simulation(LINsig_3D, DirAC_struct);
HPsig_DirAC3D=Headphone_ITDILD_simulation(LSsig_3D, DirAC_struct);

%Listen the output
soundsc(bw,fs); disp('Mono reference'); pause(siglen/fs);
soundsc(HPsig_DirAC3D,fs); disp('DirAC 3D'); pause(siglen/fs)
soundsc(HPsig_LIN3D,fs); disp('Linear decoding 3D')


    
