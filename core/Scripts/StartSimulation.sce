modulationStep = strtod(Programm.MainWindow.Texts.ModulationStep.String);
modulationTime = strtod(Programm.MainWindow.Texts.ModulationTime.String);
time = (0 : modulationStep : modulationTime - modulationStep)' // Массив времени для построения графиков и т.п. (Scilab передает неверно). 
                                                                    // ' — транспонирование матрицы (массив времени — столбец)

// Симуляция входного сигнала

inputSignal = Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value);

if (strrchr(inputSignal, '.') == ".sce") then
    exec(Programm.Modules.InputSignals.Path + inputSignal); // Выполнение модуля
    outInputSignal = struct("values", out, "time", time); // Формирование структуры для XCos
else
    importXcosDiagram(Programm.Modules.InputSignals.Path + inputSignal); // Импорт scs_m
    scs_m.props.tf = modulationTime; // Установка времени моделирования
    
    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end
        
        // Установка имени переменной, в которую будет помещен результат
        if scs_m.objs(i).gui == "TOWS_c" then 
            scs_m.objs(i).graphics.exprs = [string(modulationTime / modulationStep); "outInputSignal"; "0"];
            scs_m.objs(i).model.ipar = int([modulationTime / modulationStep length("outInputSignal") ascii("outInputSignal")]);
        end
        
        // Установка времени и шага моделирования
        if scs_m.objs(i).gui == "CLOCK_c" then 
            scs_m.objs(i).model.rpar.objs(2).graphics.exprs = [string(modulationStep); "0"];
        end
    end

    scicos_simulate(scs_m, "nw"); // Моделирование
end

// Симуляция модели объекта

objectModel = Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value);


if (strrchr(objectModel, '.') == ".sce") then
    exec(Programm.Modules.InputSignals.Path + inputSignal); // Выполнение модуля
    outObjectSignal = struct("values", out, "time", time); // Формирование структуры для XCos
else
    importXcosDiagram(Programm.Modules.Objects.Path + objectModel); // Импорт scs_m
    scs_m.props.tf = modulationTime; // Установка времени моделирования

    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end

        // Установка имени переменной, в которую будет помещен результат
        if scs_m.objs(i).gui == "TOWS_c" then 
            scs_m.objs(i).graphics.exprs = [string(modulationTime / modulationStep); "outObjectModelSignal"; "0"];
            scs_m.objs(i).model.ipar = int([modulationTime / modulationStep length("outObjectModelSignal") ascii("outObjectModelSignal")]);
        end

        // Установка имени переменной, из которой будет взят входной сигнал
        if scs_m.objs(i).gui == "FROMWSB" then 
            scs_m.objs(i).model.rpar.objs(1).graphics.exprs = ["outInputSignal"; "0"; "1"; "0"];            
            scs_m.objs(i).model.rpar.objs(1).model.ipar = [14; 24; 30; 29; -18; 23; 25; 30; 29; -28; 18; 16; 23; 10; 21; 1; 1; 0];  // Имя переменной кодирется в стронной кодировке: "0123456789 abcdef ABCDEF" = [0;1;2;3;4;5;6;7;8;9; 10;11;12;13;14;15; -10;-11;-12;-13;-14;-15] (пробелы для читаемости)
        end
        
        // Установка времени и шага моделирования
        if scs_m.objs(i).gui == "CLOCK_c" then 
            scs_m.objs(i).model.rpar.objs(2).graphics.exprs = [string(modulationStep); "0"];
        end
    end

    scicos_simulate(scs_m, "nw");
end

// Идентификация

identification = Programm.MainWindow.Texts.ModuleName.String;

if (strrchr(identification, '.') == ".sce") then
    exec(Programm.Modules.InputSignals.Path + inputSignal); // Выполнение модуля
    outObjectSignal = struct("values", out, "time", time); // Формирование структуры для XCos
else
    importXcosDiagram(Programm.MainWindow.SelectedModule.Path); // Импорт scs_m
    scs_m.props.tf = modulationTime; // Установка времени моделирования

    scicos_simulate(scs_m, "nw");
end

// Вывод
try
    Programm.MainWindow.Frames.PlotFrame.Visible = "on";

    delete(Programm.MainWindow.Frames.PlotFrame.Children);
    newaxes(Programm.MainWindow.Frames.PlotFrame);

    Programm.MainWindow.Frames.StartSimulation.Enable  = "off";
    Programm.MainWindow.Frames.NoDataFrame.Visible = "on";
    Programm.MainWindow.Frames.PlotFrame.Visible = "off";

    waitbarHandle = progressionbar("Выполнение моделирования...");

    countParametres = 0;
    parametresNames = [];
    
    for i = 1 : size(scs_m.objs)
        if typeof(scs_m.objs(i)) <> "Block" then continue end
    
        // Установка имени переменной, в которую будет помещен результат
        if scs_m.objs(i).gui == "TOWS_c" then 
            countParametres = countParametres + 1;
            parametresNames = [parametresNames scs_m.objs(i).graphics.exprs(2)];
        end
    end
    
    [m, n] = GetSubplotMN(countParametres);
    
    for i = 1 : countParametres
        subplot(m, n, i);
        execstr("plot2d(time, " + parametresNames(i) + ".values);"); // Отображаем параметры
    
        p = gca();
        p.grid = [color(128, 128, 128) color(128, 128, 128)];
        p.children(1).children(1).thickness = 2;
        p.y_label.text = parametresNames(i);
        p.y_label.font_size = 2;
        p.x_label.text = "t";
        p.x_label.font_size = 2;
    end

    close(waitbarHandle);

    Programm.MainWindow.Frames.StartSimulation.Enable  = "on";
    Programm.MainWindow.Frames.NoDataFrame.Visible = "off";
    Programm.MainWindow.Frames.PlotFrame.Visible = "on";
catch    
    close(waitbarHandle);
    Programm.MainWindow.Frames.StartSimulation.Enable  = "on";
    messagebox(lasterror(), "Error", "error", ["Ок"], "modal");
end

// // plot2d(k.time, k.values);
// // plot2d(T.time, T.values);

// // Входной сигнал
// plot2d(time, outInputSignal.values);
// figure();
// newaxes();

// // Объект
// plot2d(time, outObjectModelSignal.values);
// figure();
// newaxes()

// // k
// plot2d(time, k.values);
// figure();
// newaxes()

// // T
// plot2d(time, T.values);

