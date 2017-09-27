% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function [ b ] = load_vector( n, f )
% load_vector: fills the right side of a system

    nDim = size(n,1);
    fDim = size(f,1);
    b = zeros(2*nDim,1);
    
    for i = 1:fDim
        fx = f(i,1);
        fy = f(i,2);
        fn = f(i,3);
        
        b(2*fn - 1) = fx;
        b(2*fn) = fy;
    end
end

