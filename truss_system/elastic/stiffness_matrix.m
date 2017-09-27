% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function K = stiffness_matrix( n, e, SE )
% stiffness_matrix: fills the element in stiffness matrix
%
%  Fills and permuts stiffness matrix

    eDim = size(e,1);
    nDim = size(n,1);
    K = zeros(nDim*2); % space for siffness matrix
    
    % assemble step
    for ei = 1:eDim
        n1 = e(ei,1);
        n2 = e(ei,2);
        ee = n(n2,:)' - n(n1,:)'; % edge in affine vector space
        kk = SE/norm(ee)^3; % material scaling
        
        A = kk*( ee*ee' ); % element of local stiffness matrix 

        % fill global stiffness matrix
        K(2*n1-1:2*n1, 2*n1-1:2*n1) = K(2*n1-1:2*n1, 2*n1-1:2*n1) + A;
        K(2*n1-1:2*n1, 2*n2-1:2*n2) = K(2*n1-1:2*n1, 2*n2-1:2*n2) - A;
        K(2*n2-1:2*n2, 2*n1-1:2*n1) = K(2*n2-1:2*n2, 2*n1-1:2*n1) - A;
        K(2*n2-1:2*n2, 2*n2-1:2*n2) = K(2*n2-1:2*n2, 2*n2-1:2*n2) + A;
    end
     
    
    
end

