%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GFCC-feature
% A novel feature to do speech anti-spoofing/playback speech detection
% ============================================================================================
% https://github.com/DHUspeech/GFCC-feature
% Please cite the following if our paper or code is helpful to your research.
% @inproceedings{GFCC_odyssey, title={A Novel Feature Based on Graph Signal Processing for Detection of Physical Access Attacks}, author={Longting Xu and Mianxin Tian and Xing Guo and Zhiyong Shan and Jie Jia and Yiyuan Peng and Jichen Yang and Rohan Kumar Das}, booktitle = {Proceedings of the Speaker Odyssey 2022}, pages = {XX-XX}, year={2022} }
% ============================================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc;
% add required libraries to the path
addpath(genpath('voicebox')); %Use function enframe. http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html


%% Parameters setting for Graph Frequency Transformation
M = 256;            % Frame length
k = 3;              % The graph k-shift operator in equation (2), k here is set to 3.
qz = 19;            % GFCC feature dimension, qz+1. Here qz=19 means feature dimension is 20.

% Construct the matrix Phi_k, here we set k=3
D = zeros(M,M);
D0 = [ones(1,k),zeros(1,M-k)]; % first row
D(1,:) = D0;
for i=2:M  
    D0 = circshift(D0,[0,1]);
    D(i,:) = D0;
end
% Phi_k done, here k=3, so D is Phi_3.
[U,S,V] = svd(D);
X = U'*D;    % For a speech frame s, two steps to obtain gft result. 1. y=D*s; 2. y'=inv(U)*y=U'*D*s=X*s;

%% Feature extraction 
% extract feature of the demo wav
namelist = dir('data/flac/*.flac');
disp('Extracting feature...');
for i=1:length(namelist)
    save_name = strrep(namelist(i).name,'.flac', '_gfcc.mat');
    save_path = strcat('./data/GFCC_s/', save_name);
    filePath = strcat(namelist(i).folder,'/',namelist(i).name);
    [x,fs] = audioread(filePath);
    fea = gfcc_fea(x,X,qz,'Zs',fs);
    save(save_path, 'fea')
end
disp('Done!');

