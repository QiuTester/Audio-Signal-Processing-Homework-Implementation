function [HPsig] = Headphone_ITDILD_simulation(LSsig, DirAC_struct)
%% simulation of headphone listening with assumption of cardioid shadowing and ITD
ls_dirs=DirAC_struct.ls_dirs;

HPsig = zeros(size(LSsig,1),2);
LSsig = [LSsig; zeros(100,size(LSsig,2))]; 
initdelay = 0.00035*DirAC_struct.fs; % half of highest value for ITD
for i=1:size(LSsig,2) % delay each signal to get correct ITD, apply side-facing cardioid
    delayL=round((sin(-ls_dirs(i,1)/180*pi)+1)*initdelay); 
    delayR=round((sin(ls_dirs(i,1)/180*pi)+1)*initdelay);
    HPsig(:,1)=HPsig(:,1) + LSsig(1+delayL:end-100+delayL,i)*(1+sin(ls_dirs(i,1)))/2;
    HPsig(:,2)=HPsig(:,2) + LSsig(1+delayR:end-100+delayR,i)*(1+sin(-ls_dirs(i,1)))/2;
end
