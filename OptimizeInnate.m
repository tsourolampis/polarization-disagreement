function [results, sols, equi] = OptimizeInnate(A,s,vals) 

% OptimizeInnate.m 

% Description 
% Given a graph represented by the adjacency matrix A, a budget alpha, 
% and a vector of innate opinions s, our goal is to find a correction
% vector x with total ell_1 norm at most alpha, that minimizes the sum of
% disagreement and controversy.  

% Objective:  minimize (x+s)'*inv(eye(n)+L)*(x+s)  s.t certain constraints
% For all details, read Section 3.3 in our paper "Minimizing Controversy 
% and Disagreement in Social Networks".

% Input 
% A:    adjacency matrix 
% s:    innate opinions (vector nx1)  
% vals: vector of budgets  (by default 0 to 20 with 0.5 step) 

% Output 
% results: [vals, objective] encoded as a matrix len(vals)x2 
% sols: optimal change vectors x per budget encoded as a matrix n x len(vals) 
% equi: opinion equilibria for each budget encoded as a matrix n x len(vals) 

% Author : C.E Tsourakakis 
% Email  : ctsourak@bu.edu
% Date   : OXI Day 2017 (28 Oct '17)

if nargin == 2 
    vals = 0:0.5:20;   
end 

L =   diag(sum(A))-A;      %<- Laplacian 
n =   length(A);           %<- number of vertices 

counter = 1; 

opt = zeros(length(vals),1);
sols = [];
equi = [];


for i = 1 : length(vals) 
    clc
    fprintf('Alpha = %f (%d more values to check) \n',vals(i), length(vals)-i);
    alpha = vals(i); 
    cvx_begin 
        variable x(n)
        minimize((x+s)'*inv(eye(n)+L)*(x+s))
        subject to 
           norm(x,1) <= alpha; 
           x<= zeros(n,1);
           s+x>=zeros(n,1);  %<- no innate opinion after intervention less than 0
    cvx_end 
    opt(counter) = cvx_optval; 
    counter = counter+1; 
    sols = [sols x];
    z = inv(eye(n)+L)*(x+s);
    equi = [equi z]; 
end


vals = vals'; 
results = [vals,  opt] ;
