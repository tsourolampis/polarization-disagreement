budgets = 0:0.5:20; %<- budgets we will try out, for fewer budgets 
n=1000; %<- number of nodes 
s = rand(n,1);  %<- uniform innate opinions 

% generate random binomial graph 
a = rand(n) <=0.5; 
a = triu(a,1);
a = a+a';


% run OptimizeInnate 
[results, sols, equi] = OptimizeInnate(a,s,budgets);  
Exp.edges = nnz(a)/2;
Exp.results = results; 
Exp.x = sols; 
Exp.equilibrium = equi; 
Exp.s=s;
Exp.a=a; 
Exp.deg= sum(a); 

% if you want to save the results, uncomment the following line 
% save('Exp1_Innate.mat','Exp')


deg = sum(Exp.a); 
vals = Exp.results(:,1); 
ind5 = find(vals==5);

% innate vs degree sequence
figure
ph = plot(Exp.s,deg,'bo');
set(ph, 'MarkerSize', 10);
set(gca,  'XLim', [ 0.0 1 ], 'XTick', [ 0:0.2:1.0 ],  'Fontsize',20);
xlabel('Innate opinion s','Fontsize',20);
ylabel('Degree','Fontsize',24);
title({'Random binomial graph','Uniform innate opinions'},'Fontsize',24);
set(gca, 'Fontsize',24);
print('-djpeg', 'G-ER-s-uniform-innate-vs-degree.jpg');


% equilibrium vs degree sequence 
figure
ph = plot(Exp.equilibrium(:,1),deg,'b*');
set(ph, 'MarkerSize', 10);
set(gca,  'XLim', [ 0.0 1 ], 'XTick', [ 0:0.2:1.0 ],  'Fontsize',20);
xlabel('Equilibrium opinion','Fontsize',20);
ylabel('Degree','Fontsize',24);
title({'Random binomial graph','Uniform innate opinions'},'Fontsize',24);
set(gca, 'Fontsize',24);
print('-djpeg', 'G-ER-s-uniform-Equilibrium-vs-degree.jpg');




% innate opinions vs change ds (budget 20)
figure
ph = plot(Exp.s, Exp.x(:,end),'bs'); 
set(ph, 'MarkerSize', 10);
set(gca,  'XLim', [ 0.0 1 ], 'XTick', [ 0:0.2:1.0 ],  'Fontsize',20);
xlabel('Innate opinion s','Fontsize',20);
ylabel('Intervention ds','Fontsize',24);
title({'Random binomial graph','Uniform innate opinions',strcat('Budget=',int2str(vals(end)))},'Fontsize',24);
set(gca, 'Fontsize',24);
print('-djpeg', 'G-ER-s-uniform-innate-vs-Intervention-budget-20.jpg');


% innate opinions vs change ds (budget 5)
figure
ph = plot(Exp.s, Exp.x(:,ind5),'bs'); 
set(ph, 'MarkerSize', 10);
set(gca,  'XLim', [ 0.0 1 ], 'XTick', [ 0:0.2:1.0 ],  'Fontsize',20);
xlabel('Innate opinion s','Fontsize',20);
ylabel('Intervention ds','Fontsize',24);
title({'Random binomial graph','Uniform innate opinions',strcat('Budget=',int2str(vals(ind5)))},'Fontsize',24);
set(gca, 'Fontsize',24);
print('-djpeg', 'G-ER-s-uniform-innate-vs-Intervention-budget-5.jpg');

 
% budget vs objective of disagreement pls controversy 
figure
ph = plot( Exp.results(:,1), Exp.results(:,2), '-bd');
set(ph, 'MarkerSize', 10);
set(gca,  'XLim', [ 0.0 max(Exp.results(:,1))+1 ],    'Fontsize',20);
xlabel('Budget \alpha','Fontsize',20);
ylabel('Objective (s+ds)^T(I+L)^{-1}(s+ds)','Fontsize',24);
title({'Random binomial graph','Uniform innate opinions'},'Fontsize',24);
set(gca, 'Fontsize',24);
print('-djpeg', 'G-ER-s-uniform-budget-vs-Objective.jpg');