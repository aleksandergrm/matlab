% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function [ p, m ] = find_permutations( n, s)
% find_permutations: finds the reorganization of stiffness matrix to 
%                    separate known and unknown variables 

    sDim = size(s,1);
    nDim = size(n,1);
    pDim = 2*nDim;
    
    sp = zeros(pDim, 1);
    p = zeros(pDim, 1);
    
    for i=1:sDim
        x = s(i,1);
        y = s(i,2);
        n = s(i,3);
        
        if x == 1
            sp(2*n-1, 1) = 1;
        end
        if y == 1
            sp(2*n, 1) = 1;
        end        
    end
    
    m = nnz(sp);
    i = 1;
    last = pDim;
    
    while i <= last
        if sp(i) == 1
            if sp(last) == 0
                p(i) = last;
                p(last) = i;
                last = last - 1;
            else
                while sp(last) == 1
                    p(last) = last;
                    last = last - 1;
                    
                    if sp(last) == 0
                        p(i) = last;
                        p(last) = i;
                        last = last - 1;
                    end  
                end
            end
        else
            p(i) = i;
        end
        
        i = i + 1;
    end
end

