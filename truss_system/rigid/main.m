% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

% --- Example 01 ---
n1 = [0,0; 0,1; 1,0];
e1 = [1,2; 2,3; 1,3];
f1 = [500,0,2];
s1 = [1,1,1; 0,1,3];
%n = n1; e = e1; f = f1; s = s1;

% --- Example 02 ---
n2 = [0,0; 2,0; 4,0; 1,1; 3,1; 2,2];
e2 = [1,2; 2,3; 1,4; 2,4; 2,5; 3,5; 4,5; 4,6; 5,6];
f2 = [0,-500,6];
s2 = [1,1,1; 0,1,3];
n = n2; e = e2; f = f2; s = s2;

% --- Example 03 ---
n3 = [0,0; 1,0; 2,0; 3,0; 4,0; 5,0; 0,1; 1,1; 2,1; 3,1; 4,1; 5,1];
e3 = [1,2; 2,3; 3,4; 4,5; 5,6;...
    1,7; 1,8; 2,8; 2,9; 3,9; 3,10; 4,10; 4,11; 5,11; 5,12; 6,12;...
    7,8; 8,9; 9,10; 10,11; 11,12];
f3 = [0,-500,9; 500,500,12];
s3 = [1,1,1; 0,1,6];
%n = n3; e = e3; f = f3; s = s3;




% Assemble siffnes matrix A and load vector b
[A b t] = Truss_System(n, e, f, s);

if t == 1
    % solve for truss forces and supports
    x = linsolve(A,b);

    % plot solution
    plot_ts(n, e, x);

    % print results
    print_ts(n, e, x);
end