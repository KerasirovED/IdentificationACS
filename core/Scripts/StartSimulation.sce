Programm.MainWindow.Frames.PlotFrame.Visible = "on";

delete(Programm.MainWindow.Frames.PlotFrame.Children);
newaxes(Programm.MainWindow.Frames.PlotFrame);

Programm.MainWindow.Frames.StartSimulation.Enable  = "off";
Programm.MainWindow.Frames.NoDataFrame.Visible = "on";
Programm.MainWindow.Frames.PlotFrame.Visible = "off";

__waitbarHandle__ = progressionbar("Выполнение моделирования...");

__modulationStep__ = strtod(Programm.MainWindow.Texts.ModulationStep.String);
__modulationTime__ = strtod(Programm.MainWindow.Texts.ModulationTime.String);
__time__ = (0 : __modulationStep__ : __modulationTime__ - __modulationStep__)'; // Массив времени для построения графиков и т.п. (Scilab передает неверно). 
                                                                                // ' — транспонирование матрицы (массив времени — столбец)

// Симуляция входного сигнала
try
    __inputSignal__ = Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value);

    if (strrchr(__inputSignal__, '.') == ".sce") then
        exec(Programm.Modules.InputSignals.Path + __inputSignal__); // Выполнение модуля
        __source__ = struct("values", __out__, "time", __time__); // Формирование структуры для XCos
    else
        importXcosDiagram(Programm.Modules.InputSignals.Path + __inputSignal__); // Импорт scs_m
        scs_m.props.tf = __modulationTime__; // Установка времени моделирования
        
        for __i__ = 1 : size(scs_m.objs)
            if typeof(scs_m.objs(__i__)) <> "Block" then continue end
            
            // Установка имени переменной, в которую будет помещен результат
            if scs_m.objs(__i__).gui == "TOWS_c" then 
                scs_m.objs(__i__).graphics.exprs = [string(__modulationTime__ / __modulationStep__); "__source__"; "0"];
                scs_m.objs(__i__).model.ipar = int([__modulationTime__ / __modulationStep__ length("__source__") ascii("__source__")]);
            end
            
            // Установка времени и шага моделирования
            if scs_m.objs(__i__).gui == "CLOCK_c" then 
                scs_m.objs(__i__).model.rpar.objs(2).graphics.exprs = [string(__modulationStep__); "0"];
            end
        end

        scicos_simulate(scs_m, "nw"); // Моделирование
    end

    // Симуляция модели объекта

    __objectModel__ = Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value);

    if (strrchr(__objectModel__, '.') == ".sce") then
        exec(Programm.Modules.InputSignals.Path + __inputSignal__); // Выполнение модуля
        outObjectSignal = struct("values", out, "__time__", __time__); // Формирование структуры для XCos
    else
        importXcosDiagram(Programm.Modules.Objects.Path + __objectModel__); // Импорт scs_m
        scs_m.props.tf = __modulationTime__; // Установка времени моделирования

        for __i__ = 1 : size(scs_m.objs)
            if typeof(scs_m.objs(__i__)) <> "Block" then continue end

            // Установка имени переменной, в которую будет помещен результат
            if scs_m.objs(__i__).gui == "TOWS_c" then 
                scs_m.objs(__i__).graphics.exprs = [string(__modulationTime__ / __modulationStep__); "__obj__"; "0"];
                scs_m.objs(__i__).model.ipar = int([__modulationTime__ / __modulationStep__ length("__obj__") ascii("__obj__")]);
            end

            // Установка имени переменной, из которой будет взят входной сигнал
            if scs_m.objs(__i__).gui == "FROMWSB" then 
                scs_m.objs(__i__).model.rpar.objs(1).graphics.exprs = ["__source__"; "0"; "1"; "0"];            
                scs_m.objs(__i__).model.rpar.objs(1).model.ipar = [14; 24; 30; 29; -18; 23; 25; 30; 29; -28; 18; 16; 23; 10; 21; 1; 1; 0];  // Имя переменной кодирется в стронной кодировке: "0123456789 abcdef ABCDEF" = [0;1;2;3;4;5;6;7;8;9; 10;11;12;13;14;15; -10;-11;-12;-13;-14;-15] (пробелы для читаемости)
            end
            
            // Установка времени и шага моделирования
            if scs_m.objs(__i__).gui == "CLOCK_c" then 
                scs_m.objs(__i__).model.rpar.objs(2).graphics.exprs = [string(__modulationStep__); "0"];
            end
        end

        scicos_simulate(scs_m, "nw");
    end

    // Идентификация

    __identification__ = Programm.MainWindow.Texts.ModuleName.String;

    if __identification__ == "<не выбранно>" then
        messagebox("Необходимо выбрать модуль!", "Error!", "error", "modal");
    else 
        if (strrchr(__identification__, '.') == ".sce") then
            exec(Programm.Modules.InputSignals.Path + __inputSignal__); // Выполнение модуля
            outObjectSignal = struct("values", out, "time", __time__); // Формирование структуры для XCos
        else
            importXcosDiagram(Programm.MainWindow.SelectedModule.Path + Programm.MainWindow.SelectedModule.Name); // Импорт scs_m
            scs_m.props.tf = __modulationTime__; // Установка времени моделирования
            
            for __i__ = 1 : size(scs_m.objs)
                if typeof(scs_m.objs(__i__)) <> "Block" then continue end
            
                // Установка имени переменной, в которую будет помещен результат
                if scs_m.objs(__i__).gui == "TOWS_c" then 
                    scs_m.objs(__i__).graphics.exprs(1) = string(__modulationTime__ / __modulationStep__);
                    scs_m.objs(__i__).model.ipar(1) = int(__modulationTime__ / __modulationStep__);
                end
                
                // Установка времени и шага моделирования
                if scs_m.objs(__i__).gui == "CLOCK_c" then 
                    scs_m.objs(__i__).model.rpar.objs(2).graphics.exprs = [string(__modulationStep__); "0"];
                end
            end

            scicos_simulate(scs_m, "nw");
        end

        // Вывод

        __countParametres__ = 0;
        __parametresNames__ = [];

        if Programm.MainWindow.Checkboxes.ShowSource.Value == 1 then
            __countParametres__ = __countParametres__ + 1;
            __parametresNames__ = [__parametresNames__ "__source__"];
        end

        if Programm.MainWindow.Checkboxes.ShowObj.Value == 1 then
            __countParametres__ = __countParametres__ + 1;
            __parametresNames__ = [__parametresNames__ "__obj__"];
        end
        
        for __i__ = 1 : size(scs_m.objs)
            if typeof(scs_m.objs(__i__)) <> "Block" then continue end
        
            // Установка имени переменной, в которую будет помещен результат
            if scs_m.objs(__i__).gui == "TOWS_c" then 
                __countParametres__ = __countParametres__ + 1;
                __parametresNames__ = [__parametresNames__ scs_m.objs(__i__).graphics.exprs(2)];
            end
        end
        
        [__m__, __n__] = GetSubplotMN(__countParametres__);
        
        for __i__ = 1 : __countParametres__
            subplot(__m__, __n__, __i__);
            execstr("plot2d(__time__, " + __parametresNames__(__i__) + ".values);"); // Отображаем параметры
        
            __p__ = gca();
            __p__.grid = [color(128, 128, 128) color(128, 128, 128)];
            __p__.children(1).children(1).thickness = 2;
            __p__.y_label.text = __parametresNames__(__i__);
            __p__.y_label.font_size = 2;
            __p__.x_label.text = "t";
            __p__.x_label.font_size = 2;
        end

        Programm.MainWindow.Frames.NoDataFrame.Visible = "off";
        Programm.MainWindow.Frames.PlotFrame.Visible = "on";
    end

        close(__waitbarHandle__);

        Programm.MainWindow.Frames.StartSimulation.Enable  = "on";
catch    
     if isdef("__waitbarHandle__") then close(__waitbarHandle__); end
     Programm.MainWindow.Frames.StartSimulation.Enable  = "on";
     ShowLastError();
end

// Подчищаем за собой
clear __modulationTime__;
clear __modulationStep__;
clear __time__;
clear __parametresNames__;
clear __p__;
clear __n__;
clear __m__;
clear __countParametres__;
clear __waitbarHandle__;
clear __identification__;
clear __objectModel__;
clear __i__;
clear __inputSignal__;
clear __source__;
clear __obj__;
clear __out__;
clear scs_m;
