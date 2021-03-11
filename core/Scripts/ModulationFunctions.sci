function SetTowCParametres(parameterName)
    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end
            scs_m.objs(i).graphics.exprs = [string(modulationTime / modulationStep); parameterName; "0"];
            scs_m.objs(i).model.ipar = int([modulationTime / modulationStep length(parameterName) ascii(parameterName)]);
        end
    end
endfunction

function SetClockCParametres(input)
    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end
            
        if scs_m.objs(i).gui == "CLOCK_c" then 
            scs_m.objs(i).model.rpar.objs(2).graphics.exprs = [string(modulationTime / modulationStep); "0"]);
        end
    end
endfunction