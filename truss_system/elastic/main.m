% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

% --- Material Properties ---
S = 1e-4; % element cross section
E = 1e8;  % Young's modulus

%%
% --- Example 01 ---
n1 = [0,0; 0,1; 1,0];
e1 = [1 2; 1 3; 2 3];
s1 = [1,1,1; 0,1,3];
f1 = [500,0,2];
%n = n1; e =e1; s = s1; f = f1;

% --- Example 02 ---
n2 = [0,0; 2,0; 4,0; 1,1; 3,1; 2,2];
e2 = [1,2; 2,3; 1,4; 2,4; 2,5; 3,5; 4,5; 4,6; 5,6];
f2 = [0,-1000,6];
s2 = [1,1,1; 1,1,3];
n = n2; e =e2; s = s2; f = f2;

% --- Example 03 ---
n3 = [0,0; 1,0; 2,0; 3,0; 4,0; 5,0; 0,1; 1,1; 2,1; 3,1; 4,1; 5,1];
e3 = [1,2; 2,3; 3,4; 4,5; 5,6;...
    1,7; 1,8; 2,8; 2,9; 3,9; 3,10; 4,10; 4,11; 5,11; 5,12; 6,12;...
    7,8; 8,9; 9,10; 10,11; 11,12];
f3 = [0,-500,2; 0,-300,3; 0,-300,4; 0,-500,5];
s3 = [1,1,1; 0,1,6];
%n = n3; e =e3; s = s3; f = f3;
%%

% --- Start FEM analysis ---
K = stiffness_matrix( n, e, S*E);
b = load_vector(n, f);

% permute step: reorganize matrix to separate know and unknow variables
[pp, m] = find_permutations( n, s );
K = K(pp,:);
K = K(:,pp);
b = b(pp);

% solve reorganized system
[p, q] = size(K);
Kuu = K(1:p-m, 1:q-m);
Kup = K(1:p-m, q-m+1:q);
Kpu = Kup';
Kpp = K(p-m+1:p, q-m+1:q);

uu = linsolve(Kuu, b(1:p-m));
fp = Kpu*uu;
%%

% expose results to regular organized form
u = zeros(q,1);
f = zeros(p,1);

for i = 1:(q-m)
    id = pp(i);
    u(id) = uu(i);
end

for i=1:m
    id = pp(end-m+i);
    f(id) = fp(i);
end

% print results
fprintf('\n\n======== Node translations ========\n')
for i = 1:size(n,1)
    fprintf('u(%d): x = %-10.3g\t y = %-10.3g\n', i, u(2*i-1), u(2*i));
end

fprintf('\n======== Truss support forces ========\n')
for i = 1:size(n,1)
    fprintf('f(%d): x = %-10.3g\t y = %-10.3g\n', i, f(2*i-1), f(2*i));
end

% show results
plot_ts(n, e, u)



