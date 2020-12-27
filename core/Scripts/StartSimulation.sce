//function StartSimulation()

    inputSignal = Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value);

    if (strrchr(inputSignal, '.') == ".sci") then
        exec(Programm.Modules.InputSignals.Path + inputSignal);

        outInputSignal = struct("value", out, "time", 0:MODULATION_STEP:MODULATION_TIME);
    else
        importXcosDiagram(Programm.Modules.InputSignals.Path + inputSignal);

        for i = 1 : size(scs_m.objs)
            if typeof(scs_m.objs(i)) <> "Block" then continue end

            if scs_m.objs(i).gui == "TOWS_c" then 
                scs_m.objs(i).graphics.exprs = [string(MODULATION_TIME / MODULATION_STEP); "outInputSignal"; "0"];
                scs_m.objs(i).model.ipar = int([MODULATION_TIME / MODULATION_STEP length("outInputSignal") ascii("outInputSignal")]);
            end

            // if scs_m.objs(i).gui == "CLOCK_c" then 
            //     scs_m.objs(i).graphics.exprs(1) = MODULATION_TIME / MODULATION_STEP;
            //     scs_m.objs(i).model.ipar(1) = MODULATION_TIME / MODULATION_STEP;
            // end
        end
        
        disp(scicos_simulate(scs_m, "nw"));
        //disp(outInputSignal);

        plot2d(outInputSignal.time, outInputSignal.values);

        //tree_show(scs_m);
    end
//endfunction