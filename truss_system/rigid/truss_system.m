% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function [ A b t ] = truss_system( n, e, f, s )
% Truss_System fills the matrix A and vector b based on 
%
%  n - nodes
%  e - elements (connectivity)
%  f - external forces
%  s - supports
%  
%  A - stiffnes matrix
%  b - load vector

    nDim = length(n);
    eDim = length(e);
    
    A = zeros(2*nDim);
    b = zeros(2*nDim,1);
    
    if 2*nDim ~= 3 + eDim
        str = sprintf('Statically Indeterminate System:\n\n2*Dim(nodes) not equal to 3 + Dim(edges)\n\n 2*%d ~= 3 + %d', nDim, eDim);
        msgbox(str, 'Error','error');
        t = 0;
    else
    
        A = zeros(2*nDim);
        b = zeros(2*nDim,1);

        % fill matrix A with element items
        for i = 1:eDim
            n1 = e(i,1); % first element node
            n2 = e(i,2); % second element node
            h = norm(n(n1,:) - n(n2,:)); % edge length

            % first node components
            eC = n(n2,:) - n(n1,:);
            A(n1*2-1, i) =  eC(1)/h;% x component of node n1
            A(n1*2, i) =    eC(2)/h;% y component of node n1

            % second node node components
            eC = n(n1,:) - n(n2,:);
            A(n2*2-1, i) =  eC(1)/h;% x component of node n2
            A(n2*2, i) =    eC(2)/h;% y component of node n2
        end

        % fill supports to matrix A
        sp = 1;
        for i = 1:size(s,1)
            if s(i,1) ~= 0
                A(s(i,3)*2-1,eDim + sp) = s(i,1);
                sp = sp +1;
            end
            if s(i,2) ~= 0
                A(s(i,3)*2,eDim + sp) = s(i,2);
                sp = sp + 1;
            end
        end

        % fill forces to load vector b
        for i = 1:size(f,1)
            if (f(i,1) ~= 0)
                b(f(i,3)*2-1) = -f(i,1);
            end
            if f(i,2) ~= 0
                b(f(i,3)*2) = -f(i,2);
            end
        end
        
        t = 1;
    end
    
end

