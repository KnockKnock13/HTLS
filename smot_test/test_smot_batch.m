% This is the batch testing script for smot code.
clear,clc,close all;
% add path
addpath(genpath('../'));

% set random generator
rng(1233245);

% Datasets to be tested
dataSets = {'slalom','juggling','crowd','acrobats','seagulls',...
    'balls','tud-crossing','tud-campus'};

datasetPath = '~/research/data/smot_data_revised';
% resultsDir = './results';

% Method to be tested
methods = {'admm','ip','ihtls'};
method = methods{3};

% Noise type to be tested
noiseType = {'fn','fp'};
noise_tag = noiseType{1};

% Noise levels
fp = [0.0:0.1:0.5];
fn = [0.0:0.06:0.3];


% Number of trials
TRIALS = 2;













%%
% noise base
noisebase.fn = 0.0;
noisebase.fp = 0.0;
noisebase.gn = 0;
% mota base
motbase.fn = 0;
motbase.fp = 0;
motbase.mme = 0;
motbase.g = 0;
motbase.mota = 0;
motbase.mmerat = 0;

for i = 4
% for i = 1:size(dataSets,2)
%     etime = zeros(TRIALS,length(fp));
%     itlf  = cell(TRIALS,length(fp));
%     noise = repmat(noisebase,[1 length(fp)]);
%     mot = repmat(motbase,[TRIALS length(fp)]);
    
    seqName = dataSets{i};
%     fprintf('---------------------------------------\n')
%     fprintf('Processing\nDATASET: %s\nMETHOD: %s\n\n',seqName,method);
    
    % the following script will load a lot of variables. See the file for
    % more details. 
    initialize_smot;
    
    for n=1:length(fp)
%     for n=6
    
        
        
        for t = 1:TRIALS
%         for t=1:3
            fprintf('Processing Dataset:%s  Method:%s  Noise:%0.2f|%0.2f  Trial:%d\n',...
                seqName,method,fp(n),fn(n),t);
            fprintf('---------------------------------------\n');
            if  n==1 && t>1
                % noiseless case is same for all trials. copy.
                itlf{t,n} = itlf{1,n};
                etime(t,n) = etime(1,n);
                mot(t,n) = mot(1,n);
            else                
                noise(n).fp = fp(n);
                noise(n).fn = fn(n);
                noise(n).gn = 0;
                
                [idlp fp_idl{t,n} fn_idl{t,n}] = idladdnoise(idl0,noise(n));
                
%                 if FIX_FLAG
                % do the stitching
                if isequal(method, 'ksp')
                    % initialize ksp parameters
                    %         initialize_ksp;
                    [itlf{t,n} etime(t,n)] = ksp_associate(idlp,param);
                else
                    [itlf{t,n} etime(t,n)] = smot_associate(idlp,param);
                end
                
                
                
                
                fprintf('Process time: %g \n\n',etime(t,n));
                
                
                % compute mota
                fprintf('Computing MOT metrics \n');
%                 mot(t,n) = smot_clear_mot(itl0,itlf{t,n},param);
%                 mota = smot_clear_mot_fp(itl0,itlf,fp_idl,param.mota_th);
%                 mot(t,n) = smot_clear_mot(itl0,itlf{t,n},param.mota_th);
                mot(t,n) = smot_clear_mot_fp(itl0,itlf{t,n},fp_idl{t,n},param.mota_th);
                fprintf('\n');
                
%                 end
                
            end
            
            % save output for noiseless case
            if fp(n)==0 && t==1
                showitl(itlf{t,n},seqPath,'tail',5);
%                 showitl(itlf{t,n},seqPath,'tail',5,'saveoutput',savePath);
            end
        
        end
        
       
        
    end
    
    % save variables     
    saveResultName = sprintf('%s/%s_%s_%s.mat',savePath,seqName,method,noise_tag);    
%     if FIX_FLAG
%         save(saveResultName,'fp_idl','-append');
%     else
    save(saveResultName,'param','seqName','method','noise','mot','itlf','etime','fp_idl','fn_idl');
%     end
%     save(saveResultName,'param','seqName','method','noise','mot','itlf','etime'); 
%     save(saveResultName,'fp_idl','-append');
    
end



