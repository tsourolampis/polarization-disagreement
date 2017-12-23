function [results, val] = demo_LearnG(n,parameters)

% demo_LearnG.m 

% Description 
% Given the number of nodes n, and a set of parameters, this code samples
% repeatedly a vector of innate opinions s from a distribution specified by
% the argument parameters, and runs LearnG, and the sparsification
% procedure of Spielman-Srivastava.

% Input 
% n: number of nodes 
% parameters: structure containing the following fields 
%       distribution: a string specifying the distribution according to
%                     which we sample the vector of innate opinions
%                     Supported distributions 'gaussian', 'uniform', 'powerlaw'
%       mu and var: mean and variance, needed when distribution='gaussian' 
%       opinion_slope: slope, needed when distribution='powerlaw'  
%       experiments: number of times to sample a vector of innate opinions s 
%       total_W    : budget on the total weight of the graph 

% Output 
%   results: structure containing the following information
%      avg : a vector containing the average controversy-disagreement index. 
%            1st  coordinate : average optimal value 
%            2nd  coordinate : average value of sparsified  
%      std : a vector containing the corresponding standard deviations 
%      val : detailed values over all runs, matrix #experiments x 2 

% Dependencies: gsp_graph_sparsify from the GSP toolbox
% Instructions: Download the GSP toolbox, available at
% https://epfl-lts2.github.io/gspbox-html/, and add it to your path 

% Toy example 
% parameters.total_W=100;  parameters.experiments=5; parameters.distribution='uniform';
% [results, val] = demo_LearnG(1000,parameters);


% Author : C.E Tsourakakis
% Email  : ctsourak@bu.edu
% Date   : OXI Day 2017 (28 Oct '17)

total_W = parameters.total_W;
experiments = parameters.experiments; %<- number of times to generate the vector of innate opinions s 
val = zeros(experiments, 2); %<- first column corresponds 
I = eye(n); %<- identity matrix

for i = 1 : experiments 
    %% generate innate opinions according to the desired distribution 
    if( strcmp(lower(parameters.distribution), 'powerlaw')) 
    s = randht(n,'powerlaw',parameters.opinion_slope);
    s = s/max(s); %<- other normalizations are fine, as long as s(i) in [0,1] 
    elseif( strcmp(lower(parameters.distribution), 'gaussian') )
        s = normrnd(parameters.mu,parameters.var,n,1);
        s(s>1)=1; 
        s(s<0)=0; 
    elseif( strcmp(lower(parameters.distribution), 'uniform') )
        s = rand(n,1); 
    else 
       error('Not supported'); 
    end
    
    %% OPT
    [Lopt, objval] = LearnG(s,total_W);
    val(i,1) = s'*inv(I+Lopt)*s;
    fprintf('OPT, val=%f\n',val(i,1)); 
    
    %% Sparsified OPT, we use Spielman-Srivastava sparsification  
    % Requires https://epfl-lts2.github.io/gspbox-html/
    Gnew = gsp_graph_sparsify(Lopt,0.5); 
    val(i,2) = s'*inv(I+Gnew)*s;
    fprintf('OPT sparsified, val=%f\n',val(i,2));
end
results.avg = mean(val);
results.std = std(val);