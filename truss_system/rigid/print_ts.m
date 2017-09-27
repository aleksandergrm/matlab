% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function print_ts( n, e, x )
%print_ts pretty print of the results
%         
    fprintf('\n\n===== Truss Forces ======\n')
    for i = 1:length(e)
        fprintf('T(%d) = %-10.3g\n',i,x(i));
    end
    
    fprintf('\n\n===== Reactions ======\n')
    fprintf('S(1) = %-10.3g\n',x(end-2));
    fprintf('S(2) = %-10.3g\n',x(end-1));
    fprintf('S(3) = %-10.3g\n',x(end));
    
end

