function GFcc=gfcc_fea(s,M,cf,ZsdD,fs,w,n,inc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<5 fs=16000; end
if nargin<6 w='M'; end
if nargin<7 n=pow2(floor(log2(0.03*fs))); end
if nargin<8
        inc=floor(n/2);
end
     
if isempty(w)
   w='M';
end
if any(w=='R')
   [z,tc]=enframe(s,n,inc);
elseif any (w=='N')
%    [z,tc]=enframe(s,hanning(n),inc);
   [z,tc]=enframe(s,0.5-0.5*cos(2*pi*(1:n)'/(n+1)),inc); % Hanning window
else
%    [z,tc]=enframe(s,hamming(n),inc);
   [z,tc]=enframe(s,0.54-0.46*cos(2*pi*(0:n-1)'/(n-1)),inc); % Hamming window
end

f=M*z'; %gft transformation

%%% LOG POWER SPECTRUM
LogP_absGFT = log(abs(f).^2 + eps);
% 
%%% DCT
GFcepstrum = dct(LogP_absGFT);

%% DYNAMIC COEFFICIENTS
if strfind(ZsdD, 'Z'); scoeff = 1; else scoeff = 2; end
GFcepstrum_temp = GFcepstrum(scoeff:cf+1,:);
f_d = 3; % delta window size
if strcmp(strrep(ZsdD,'Z',''), 'sdD')
    GFcc = [GFcepstrum_temp; Deltas(GFcepstrum_temp,f_d); ...
        Deltas(Deltas(GFcepstrum_temp,f_d),f_d)];
elseif strcmp(strrep(ZsdD,'Z',''), 'sd')
    GFcc = [GFcepstrum_temp; Deltas(GFcepstrum_temp,f_d)];
elseif strcmp(strrep(ZsdD,'Z',''), 'sD')
    GFcc = [GFcepstrum_temp; Deltas(Deltas(GFcepstrum_temp,f_d),f_d)];
elseif strcmp(strrep(ZsdD,'Z',''), 's')
    GFcc = GFcepstrum_temp;
elseif strcmp(strrep(ZsdD,'Z',''), 'd')
    GFcc = Deltas(GFcepstrum_temp,f_d);
elseif strcmp(strrep(ZsdD,'Z',''), 'D')
    GFcc = Deltas(Deltas(GFcepstrum_temp,f_d),f_d);
elseif strcmp(strrep(ZsdD,'Z',''), 'dD')
    GFcc = [Deltas(GFcepstrum_temp,f_d); Deltas(Deltas(GFcepstrum_temp,f_d),f_d)];
end
end

function D = Deltas(x,hlen)

% Delta and acceleration coefficients
%
% Reference:
%   Young S.J., Evermann G., Gales M.J.F., Kershaw D., Liu X., Moore G., Odell J., Ollason D.,
%   Povey D., Valtchev V. and Woodland P., The HTK Book (for HTK Version 3.4) December 2006.

win = hlen:-1:-hlen;
xx = [repmat(x(:,1),1,hlen),x,repmat(x(:,end),1,hlen)];
D = filter(win, 1, xx, [], 2);
% D = D(:,hlen+1:(end - hlen));
D = D(:,hlen*2+1:end);
D = D./(2*sum((1:hlen).^2));
end


