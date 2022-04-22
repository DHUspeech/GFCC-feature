
%% construct graph
M = 1000;% frame length
k = 3;% 
D = zeros(M,M);

D0 = [ones(1,k),zeros(1,M-k)]; % first row
D(1,:) = D0;
for i=2:M  
    D0 = circshift(D0,[0,1]);
    D(i,:) = D0;
end
[U,S,V] = svd(D); 


%% gft
function y=gft(U,x)
  y=U'*x;
  y=y';
end

