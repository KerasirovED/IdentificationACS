inputSignal = Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value);

if (strrchr(inputSignal, '.') == ".sce") then
    exec(Programm.Modules.InputSignals.Path + inputSignal);

    outInputSignal = struct("values", out, "time", 0 : MODULATION_STEP : MODULATION_TIME);
else
    importXcosDiagram(Programm.Modules.InputSignals.Path + inputSignal);

    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end

        if scs_m.objs(i).gui == "TOWS_c" then 
            scs_m.objs(i).graphics.exprs = [string(MODULATION_TIME / MODULATION_STEP); "outInputSignal"; "0"];
            scs_m.objs(i).model.ipar = int([MODULATION_TIME / MODULATION_STEP length("outInputSignal") ascii("outInputSignal")]);
        end
    end

    scicos_simulate(scs_m, "nw");
end

objectModel = Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value);

if (strrchr(objectModel, '.') == ".sce") then
    exec(Programm.Modules.InputSignals.Path + inputSignal);

    outObjectSignal = struct("values", out, "time", 0 : MODULATION_STEP : MODULATION_TIME);
else
    importXcosDiagram(Programm.Modules.Objects.Path + objectModel);

    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end

        if scs_m.objs(i).gui == "TOWS_c" then 
            scs_m.objs(i).graphics.exprs = [string(MODULATION_TIME / MODULATION_STEP); "outObjectModelSignal"; "0"];
            scs_m.objs(i).model.ipar = int([MODULATION_TIME / MODULATION_STEP length("outObjectModelSignal") ascii("outObjectModelSignal")]);
        end

        if scs_m.objs(i).gui == "FROMWSB" then 
            scs_m.objs(i).model.rpar.objs(1).graphics.exprs = ["outInputSignal"; "1"; "1"; "0"];            
            scs_m.objs(i).model.rpar.objs(1).model.ipar = [14; 24; 30; 29; -18; 23; 25; 30; 29; -28; 18; 16; 23; 10; 21; 1; 1; 0];  // Имя переменной кодирется в стронной кодировке: "0123456789 abcdef ABCDEF" = [0;1;2;3;4;5;6;7;8;9; 10;11;12;13;14;15; -10;-11;-12;-13;-14;-15] (пробелы для читаемости)
        end
    end

    scicos_simulate(scs_m, "nw");
end

// identification = Programm.MainWindow.Texts.ModuleName.String;

// if (strrchr(identification, '.') == ".sce") then
//     exec(Programm.Modules.InputSignals.Path + inputSignal);

//     outObjectSignal = struct("values", out, "time", 0 : MODULATION_STEP : MODULATION_TIME);
// else
//     importXcosDiagram(Programm.Modules.Indetification.Path + identification);

//     // for i = 1 : size(scs_m.objs)
//     //     if typeof(scs_m.objs(i)) <> "Block" then continue end

//     //     if scs_m.objs(i).gui == "TOWS_c" then 
//     //         scs_m.objs(i).graphics.exprs = [string(MODULATION_TIME / MODULATION_STEP); "outObjectModelSignal"; "0"];
//     //         scs_m.objs(i).model.ipar = int([MODULATION_TIME / MODULATION_STEP length("outObjectModelSignal") ascii("outObjectModelSignal")]);
//     //     end

//     //     if scs_m.objs(i).gui == "FROMWSB" then 
//     //         scs_m.objs(i).model.rpar.objs(1).graphics.exprs = ["outInputSignal"; "1"; "1"; "0"];            
//     //         scs_m.objs(i).model.rpar.objs(1).model.ipar = [14; 24; 30; 29; -18; 23; 25; 30; 29; -28; 18; 16; 23; 10; 21; 1; 1; 0];  // Имя переменной кодирется в стронной кодировке: "0123456789 abcdef ABCDEF" = [0;1;2;3;4;5;6;7;8;9; 10;11;12;13;14;15; -10;-11;-12;-13;-14;-15] (пробелы для читаемости)
//     //     end
//     // end

//     scicos_simulate(scs_m, "nw");
// end

// plot2d(k.time, k.values);
// plot2d(T.time, T.values);

plot2d(outInputSignal.time, outInputSignal.values);
figure();
newaxes();
plot2d(outObjectModelSignal.time, outObjectModelSignal.values);