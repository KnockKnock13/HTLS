% SDemonstration script for how to use SMOT code for user data.

% data
t = [1:20 25:35];
xy1 = [5*t+33;2*t+20]';
xy2 = [9*t+2;4*t-4]';

% add some noise
xy1 = xy1 + randn(size(xy1))*0.2;
xy2 = xy2 + randn(size(xy2))*0.2;


% idl structure
% note that idl will have a length of 35.
for i=min(t):max(t)
    
    if sum(t==i)==0
        % if there is not a detection leave that frame empty
        idl(i).xy = [];
    else
        % put the detections for frame t
        idl(i).xy = [xy1(t==i,:);xy2(t==i,:)];
    end
end

% parameters
param.similarity_method =  'ihtls';
param.min_s = 0.0100;
param.debug = 0;
param.hor = 20;
param.eta_max = 2;

% run the tracker
[itl etime] = smot_associate(idl,param);

% plot result
drawitl3D(itl); hold on;
plot3(t,xy1(:,1),xy1(:,2),'+');
plot3(t,xy2(:,1),xy2(:,2),'+');
hold off;