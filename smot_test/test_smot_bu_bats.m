
addpath(genpath('../'));
%% load data
clear;
load('~/research/data/bu_bats/BU_TrackCleaning_Sample.mat');

% cleanSample 262x1 cell array with clean trajectories
% dirtySample 447x1 cell array with dirty trajectories

%% convert them to itl structure
itl_clean = cell2itl(cleanSample);
itl_dirty = cell2itl(dirtySample);

drawitl3D(itl_clean);
%% apply smot stitching 

% set the parameters for stitching
param.similarity_method = 'ihtls';
param.hor     = 40;     % horizon window that will be used for stitching
param.eta_max = 1;      % noise level (maximum overall tolerance for noise)
param.min_s   = 1e-2;   % minimum similarity for tracklets
param.debug   = false;

itl_clean_final = smot_associate_itl(itl_clean(50:100),param);