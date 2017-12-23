function [L, objval] = LearnG(s,W)


% LearnG.m 

% Description 
% Given a vector of innate opinions s, and a budget W on the total weight of
% the edges, find the graph that minimizes the sum of controversy and
% disagreement.  

% Input 
% s: innate opinions (vector nx1) 
% W: budget on total weight  (real) 

% Output 
% L: Laplacian 
% objval: optimal objective value   

% Author : C.E Tsourakakis
% Email  : ctsourak@bu.edu
% Date   : OXI Day 2017 (28 Oct '17)

s = s - mean(s);
n = length(s);

cvx_begin
    cvx_precision low %<- when many variables
    variable t(1,1)
    variable L(n,n) symmetric semidefinite
    minimize(t)
    subject to:
    trace(L) == 2*W;
    L * ones(n,1) == zeros(n,1);
    [L+eye(n)  s   ;  s' t  ] == semidefinite(n+1);
    % interestingly, even when the next five lines are commented, the code still returns a laplacian 
    for i = 1 : n-1
       for j = i+1 : n
           L(i,j) <=0;
       end
    end
cvx_end

objval = cvx_optval;