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
        %fprintf('i=%d, last=%d, sp(%d)=%d, sp(%d)=%d\n', i, last, i, sp(i), last, sp(last));
        if sp(i) == 1
            %fprintf('sp(%d)=1\n',i);
            if sp(last) == 0
                %fprintf('found 0: i=%d, last=%d\n', i, last);
                p(i) = last;
                p(last) = i;
                %fprintf('   -> set new value %d <-> %d\n', i, last);
                last = last - 1;
            else
                %fprintf('found 1: i=%d, last=%d, searching ...\n', i, last);
                while sp(last) == 1
                    p(last) = last;
                    last = last - 1;
                    
                    %fprintf('   -> i=%d, last=%d\n', i, last);
                    if sp(last) == 0
                        p(i) = last;
                        p(last) = i;
                        %fprintf('   -> set new value %d <-> %d\n', i, last);
                        last = last - 1;
                    end  
                end
            end
        else
            %fprintf('sp(%d)=0\n',i);
            p(i) = i;
        end
        
        i = i + 1;
    end
end

