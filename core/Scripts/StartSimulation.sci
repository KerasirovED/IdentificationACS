function [n, m] = GetSubplotMN(countGraphs)
    if countGraphs < 4                      then n = countGraphs; m = 1; return; end
    if countGraphs == 4                     then n = 2; m = 2; return; end
    if countGraphs == 5 | countGraphs == 6  then n = 2; m = 3; return; end
    if countGraphs > 6 | countGraphs < 10   then n = 3; m = 3; return; end
    if countGraphs >= 10                    then n = 3; m = 4; return; end
endfunction