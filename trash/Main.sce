waitbarHandle = progressionbar(["Выполняется запуск программы."; "Ожидайте..."])
programmPath = get_absolute_file_path("Main.sce")

// Импорт XCos диграммы
importXcosDiagram(programmPath + "MainXcos.zcos")

// load the blocks library and the simulation engine
loadXcosLibs(); loadScicos();

// Импорт *.sci файлов
getd(programmPath + "help\")
getd(programmPath + "help\Programm\How to save open XCos\")
getd(programmPath + "help\Programm\How to save results\")
getd(programmPath + "help\Programm\How to use programm\")

// Переменная состояний программы
global Programm
Programm.Diagrams = [];
Programm.Diagrams.Main = [];
Programm.Diagrams.InputSignal = [];
Programm.Diagrams.Object = [];
Programm.Diagrams.Identification = [];

Programm.Help = [];
Programm.Model.Aperiodic1 = ["1" "0.1"];
Programm.Model.Aperiodic2 = ["1" "0.1" "0.01"];
Programm.Filter.First = ["1" "-1"];
Programm.Filter.Second = ["1" "-1" "-10"];
Programm.Version = "alpha 0";
Programm.LastModulation.SignalType.Name = [];
Programm.LastModulation.SignalType.Parametres = ["Время возникновения = 1"; "Начальное значение = 0"; "Итоговое значение = 1"];
Programm.LastModulation.ObjectModel.Name = [];
Programm.LastModulation.ObjectModel.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = 0.1"];
Programm.LastModulation.FilterOrder.Name = [];
Programm.LastModulation.FilterOrder.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = -1"];

Programm.Modules = []
Programm.Modules.InputSignals = []
Programm.Modules.InputSignals.Path = programmPath + "modules\InputSignals\";
Programm.Modules.InputSignals.List = ""

Programm.Modules.Objects = []
Programm.Modules.Objects.Path = programmPath + "modules\Objects\";
Programm.Modules.Objects.List = ""

Programm.Modules.Indetification = []
Programm.Modules.Indetification.Path = programmPath + "modules\Indetification\";
Programm.Modules.Indetification.List = ""

// Основное окно программы
main_figure = figure(...
    "figure_id", 228, ..
    "figure_name", "Программный комплекс идентификации САУ (version: " + Programm.Version + ")", ..
    "dockable"        , "off",...
    "infobar_visible" , "off",...
    "toolbar"         , "none",...
    "default_axes"    , "off",...
    "layout"          , "gridbag",...
    "visible"         , "off", ...
   "figure_position", [100 50], ...
    "menubar" , "none",...
    "axes_size", [1000, 600])
    
// Панель инструментов
m = uimenu(main_figure, "label", "Файл")
uimenu(m, "label", "Закрыть", "callback", "CloseProgramm", "icon", "close-tab")
m = uimenu(main_figure, "label", "График")
uimenu(m, "label", "Сохранить как изображение", "callback", "SavePlotIntoImage", "icon", "media-floppy")
m = uimenu(main_figure, "label", "Открыть диаграмму")
uimenu(m, "label", "Система идентификации с фильтром первого порядка", "callback", "OpenFirstOrderFilterDiagram", "icon", "utilities-system-monitor")
uimenu(m, "label", "Система идентификации с фильтром второго порядка", "callback", "OpenSecindOrderFilterDiagram", "icon", "utilities-system-monitor")
m = uimenu(main_figure, "label", "Справка")
uimenu(m, "label", "Справка", "callback", "exec(programmPath + ""help\Help.sce"")", "icon", "help-browser")
uimenu(m, "label", "О программе", "callback", "AboutUs", "icon", "dialog-information")

// Разделение рабочей области   
right_frame = uicontrol(main_figure, ...
    "layout", "gridbag", ...
    "style", "frame", ...
    "margin", [5 5 5 5], ...
    "constraints", createConstraints("gridbag", [2 1 1 1], [1 1], "both"))

left_frame = uicontrol(main_figure, ...
    "layout", "gridbag", ...
    "style", "frame", ...
    "margin", [5 5 5 0], ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [-1 1], "vertical", "center", [-1 -1], [300 1]))

//-------- Входной сигнал --------//

signalFrame = uicontrol(left_frame, ...
    "style", "frame", ...
    "layout", "gridbag", ...
    "Margins", [5 5 0 5], ...
    "border", createBorder("line", "gray", 1), ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper", [0 0], [0 50]))

uicontrol(signalFrame, ...
    "style", "text", ...
    "string", "Входной сигнал:", ...
    "margins", [5 5 5 5], ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"))
    
signalParametresFrame = uicontrol(signalFrame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 20]))
    
signalType = uicontrol(signalParametresFrame, ...
    "style", "popupmenu", ...
    "string", Programm.Modules.InputSignals.List, ...
    "tag", "signalType", ...
    "callback", "AddModule(signalType, Programm.Modules.InputSignals.Path, RefreshInputSignals)", ..
    "position", [5 0 223 20])
        
uicontrol(signalParametresFrame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "OpenModule(Programm.Modules.InputSignals.Path, signalType.String(signalType.Value))", ..
    "icon", programmPath + "images\gearWheel2.png", ..
    "position", [234 -1 22 22])
        
uicontrol(signalParametresFrame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "RefreshInputSignals", ..
    "icon", programmPath + "images\refresh.png", ..
    "position", [260 -1 22 22])
    
uicontrol(signalFrame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"))

//-------- Модель объекта --------//

link_type_frame = uicontrol(left_frame, ...
    "style", "frame", ...
    "layout", "gridbag", ...
    "Margins", [5 5 0 5], ...
    "border", createBorder("line", "gray", 1), ...
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "horizontal", "upper", [0 0], [0 50]))

uicontrol(link_type_frame, ...
    "style", "text", ...
    "string", "Модель объекта:", ...
    "margins", [5 5 5 5], ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"))
    
link_type_parametres_frame = uicontrol(link_type_frame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 20]))
    
link_type = uicontrol(link_type_parametres_frame, ...
    "style", "popupmenu", ...
    "string", Programm.Modules.Objects.List, ...
    "tag", "link_type_tag", ...
    "callback", "AddModule(link_type, Programm.Modules.Objects.Path, RefreshObjects)", ..
    "position", [5 0 223 20])
        
uicontrol(link_type_parametres_frame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "OpenModule(Programm.Modules.Objects.Path, link_type.String(link_type.Value))", ..
    "icon", programmPath + "images\gearWheel2.png", ..
    "position", [234 -1 22 22])
        
uicontrol(link_type_parametres_frame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "RefreshObjects", ..
    "icon", programmPath + "images\refresh.png", ..
    "position", [260 -1 22 22])
    
uicontrol(link_type_frame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"))
    
//-------- Порядок фильтра --------//

filterOrderFrame = uicontrol(left_frame, ...
    "style", "frame", ...
    "layout", "gridbag", ...
    "Margins", [5 5 0 5], ...
    "border", createBorder("line", "gray", 1), ...
    "constraints", createConstraints("gridbag", [1 4 1 1], [1 0], "horizontal", "upper", [0 0], [0 50]))

uicontrol(filterOrderFrame, ...
    "style", "text", ...
    "string", "Система идентификации:", ...
    "margins", [5 5 5 5], ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"))
    
filterOrderParametresFrame = uicontrol(filterOrderFrame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 20]))
    
uiFilterOrder = uicontrol(filterOrderParametresFrame, ...
    "style", "popupmenu", ...
    "string", Programm.Modules.Indetification.List, ...
    "tag", "filterOrder", ...
    "callback", "AddModule(uiFilterOrder, Programm.Modules.Indetification.Path, RefreshIndetification)", ..
    "position", [5 0 223 20])
        
uicontrol(filterOrderParametresFrame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "OpenModule(Programm.Modules.Indetification.Path, uiFilterOrder.String(uiFilterOrder.Value))", ..
    "icon", programmPath + "images\gearWheel2.png", ..
    "position", [234 -1 22 22])
        
uicontrol(filterOrderParametresFrame, ...
    "style", "pushbutton", ...
    "tag", "signalParametres", ...
    "callback", "RefreshIndetification", ..
    "icon", programmPath + "images\refresh.png", ..
    "position", [260 -1 22 22])
    
uicontrol(filterOrderFrame, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"))

//-------- Время моделирвоания --------//

simulationTime = uicontrol(left_frame, ...
    "style", "frame", ...
    "margins", [5 5 0 5], ...
    "border", createBorder("line", "gray", 1), ...
    "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 30]))
    
uicontrol(simulationTime, ..
    "style", "text", ..
    "string", "Время моделирования:", ..
    "position", [5 5 125 20])
    
uicontrol(simulationTime, ..
    "style", "edit", ..
    "tag", "Время моделирования", ..
    "string", "250", ..
    "position", [130 5 155 20])
    
//Растягивающийся frame
button_frame = uicontrol(left_frame, ...
    "style", "frame", ...
    "constraints", createConstraints("gridbag", [1 7 1 1], [1 1], "both"))
    
//-------- Пуск --------//

button_frame = uicontrol(left_frame, ...
    "style", "frame", ...
    "layout", "gridbag", ...
    "Margins", [5 5 5 5], ...
    "constraints", createConstraints("gridbag", [1 8 1 1], [1 0], "horizontal", "lower", [0 0], [0 25]))

start = uicontrol(button_frame, ...
    "style", "pushbutton", ...
    "string", "Пуск", ...
    "callback", "Set_Xcos_parametres(plot_frame)", ...
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"))

////////////////////////////////////////////////
///////////////// Right Frame //////////////////
////////////////////////////////////////////////
    
noDataFrame = uicontrol(right_frame, ...
    "style", "frame", ...
    "layout", "gridbag", ...
    "margins", [5 5 5 5], ...
    "tag", "noDataFrame", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"))

plot_frame = uicontrol(right_frame, ...
    "style", "frame", ...
    "margins", [5 5 5 5], ...
    "visible", "off", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 1], "both"))

uicontrol(noDataFrame, ..
    "style", "text", ..
    "string", "< Нет данных >", ..
    "ForeGroundColor", [.5 .5 .5])

close(waitbarHandle)
clear waitbarHandle
main_figure.visible = "on"

// ---------- Functions ---------- //

function Set_Xcos_parametres(plot_frame)
//try    
    global Programm
    
    set(plot_frame, "visible", "on")
    
    delete(plot_frame.Children)
    newaxes(plot_frame)
    
    set(start, "enable", "off")
    set(noDataFrame, "visible", "on")
    set(plot_frame, "visible", "off")
    
    waitbarHandle = progressionbar("Выполнение моделирования...")
    
    exec(programmPath + "LoadDiagrams.sce");
        
    inputSignal = Programm.Diagrams.InputSignal.objs
    object = Programm.Diagrams.Object.objs
    identification = Programm.Diagrams.Identification.objs
    
    Programm.Diagrams.Main.objs(2).model.rpar.objs  = identification // identification
    Programm.Diagrams.Main.objs(3).model.rpar.objs = inputSignal     // inputSignal
    Programm.Diagrams.Main.objs(4).model.rpar.objs = object          // object
    
    countOutputPorts = 0
    for i = 1 : length(identification)        
    try              
        if identification(i).gui <> "OUT_f" then continue end
    catch
        continue
    end    
        countOutputPorts = countOutputPorts + 1
    end
    
    out = []
    out2 = []
    outtyp = []
    for i = 1 : countOutputPorts
        out = [out -1]
        out2 = [out2 -2]
        outtyp = [outtyp -1]
    end   
    
    Programm.Diagrams.Main.objs(2).model.out = out
    Programm.Diagrams.Main.objs(2).model.out2 = out2
    Programm.Diagrams.Main.objs(2).model.outtyp = outtyp
    
     clkSplit = CLKSPLIT_f("define");
     clkSplit.model.evtin = -1;
     clkSplit.model.evtout = out;         
     clkSplit.model.firing = out;
     
    Programm.Diagrams.Main.objs($+1) = clkSplit
    splitNumber = length(Programm.Diagrams.Main.objs)
        
    linkFromClkToSplit = scicos_link("define");
    linkFromClkToSplit.from = [1 1 0]
    linkFromClkToSplit.to = [splitNumber 1 1]
    linkFromClkToSplit.ct = [5 -1]
    
    Programm.Diagrams.Main.objs($+1) = linkFromClkToSplit
        
    linkFromSplitToOut = scicos_link("define");
    linkFromSplitToOut.from = [splitNumber 0 0]
    linkFromSplitToOut.to = [0 1 1]
    linkFromSplitToOut.ct = [5 -1]
    
    out = TOWS_c("define");
    
    linkFromIndetificationToOut = scicos_link("define");
    linkFromIndetificationToOut.from = [2 0 0]
    linkFromIndetificationToOut.to = [0 1 1]
    
    for i = 1 : countOutputPorts
        Programm.Diagrams.Main.objs($+1) = out
        
        linkFromSplitToOut.from(2) = i // Порт из Split откуда выходит сигнал от CLK
        linkFromSplitToOut.to(1) = length(Programm.Diagrams.Main.objs) // Номер блока куда заходит сигнал от CLK
            
        linkFromIndetificationToOut.from(2) = i
        linkFromIndetificationToOut.to(1) = length(Programm.Diagrams.Main.objs)
        
        Programm.Diagrams.Main.objs($+1) = linkFromSplitToOut
        Programm.Diagrams.Main.objs($+1) = linkFromIndetificationToOut
    end
    
//     xcos(inputSignal)
    //scicos_simulate(scs_m, "nw")
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    
////    delete(plot_frame.Children)
//    
//    if filterOrder == 1 then
//        subplot(211)        
//        plot2d(k_out.time, k_out.values)
//        p = gca()
//        p.grid = [color(128, 128, 128) color(128, 128, 128)]
//        p.children(1).children(1).thickness = 2
//        p.y_label.text = "k"
//        p.y_label.font_size = 2
//        p.x_label.text = "t"
//        p.x_label.font_size = 2
//        subplot(212)
//        plot2d(T1_out.time, T1_out.values)
//        p = gca()
//        p.grid = [color(128, 128, 128) color(128, 128, 128)]
//        p.children(1).children(1).thickness = 2
//        p.y_label.text = "T"
//        p.y_label.font_size = 2
//        p.x_label.text = "t"
//        p.x_label.font_size = 2
//    end
//    
//    if filterOrder == 2 then
//        subplot(311)        
//        plot2d(k_out.time, k_out.values)
//        p = gca()
//        p.grid = [color(128, 128, 128) color(128, 128, 128)]
//        p.children(1).children(1).thickness = 2
//        p.y_label.text = "k"
//        p.y_label.font_size = 2
//        p.x_label.text = "t"
//        p.x_label.font_size = 2
//        subplot(312)
//        plot2d(T1_out.time, T1_out.values)
//        p = gca()
//        p.grid = [color(128, 128, 128) color(128, 128, 128)]
//        p.children(1).children(1).thickness = 2
//        p.y_label.text = "T1"
//        p.y_label.font_size = 2
//        p.x_label.text = "t"
//        p.x_label.font_size = 2
//        subplot(313)
//        plot2d(T2_out.time, T2_out.values)
//        p = gca()
//        p.grid = [color(128, 128, 128) color(128, 128, 128)]
//        p.children(1).children(1).thickness = 2
//        p.y_label.text = "T2"
//        p.y_label.font_size = 2
//        p.x_label.text = "t"
//        p.X_label.font_size = 2
//    end    
//    
//    Programm.LastModulation.SignalType.Name = signalType.String(signalType.Value)
//    
//    if signalType.Value == 1 then
//        Programm.LastModulation.SignalType.Parametres = [
//            "Время возникновения: " + string(Programm.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(1)); 
//            "Начальное значение: " + string(Programm.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(2)); 
//            "Итоговое значение: " + string(Programm.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(3))]
//    end
//    
//    if signalType.Value == 2 then
//        Programm.LastModulation.SignalType.Parametres = [
//            "Амплитуда: " + string(Programm.scs_m.objs(22).graphics.exprs(1)); 
//            "Частота (рад/с): " + string(Programm.scs_m.objs(22).graphics.exprs(2)); 
//            "Фаза (рад): " + string(Programm.scs_m.objs(22).graphics.exprs(3))]
//    end
//    
//    if signalType.Value == 3 then
//        Programm.LastModulation.SignalType.Parametres = [
//            "Задержка по фазе (с): " + string(Programm.scs_m.objs(23).graphics.exprs(1)); 
//            "Длительность импульса (%): " + string(Programm.scs_m.objs(23).graphics.exprs(2)); 
//            "Период (с): " + string(Programm.scs_m.objs(23).graphics.exprs(3)); 
//            "Амлитуда: " + string(Programm.scs_m.objs(23).graphics.exprs(4))]
//    end
//    
//    if signalType.Value == 4 then
//        
//        if Programm.scs_m.objs(2).graphics.exprs(2) == "0" then
//            kindOfDistribution = "Равномерное"
//        else
//            kindOfDistribution = "Нормальное"
//        end
//        
//        Programm.LastModulation.SignalType.Parametres = [
//            "Вид распределения: " + kindOfDistribution; 
//            "A: " + string(Programm.scs_m.objs(2).graphics.exprs(3)); 
//            "B: " + string(Programm.scs_m.objs(2).graphics.exprs(4))]
//    end
//    
//    Programm.LastModulation.ObjectModel.Name = link_type.String(link_type.Value)
//    
//    if link_type.Value == 1 then
//        Programm.LastModulation.ObjectModel.Parametres = [
//            "Коэффициент усиления: " + Programm.Model.Aperiodic1(1); 
//            "Постоянная времени: " + Programm.Model.Aperiodic1(2)]
//    end
//    
//    if signalType.Value == 2 then
//        Programm.LastModulation.ObjectModel.Parametres = [
//            "Коэффициент усиления: " + Programm.Model.Aperiodic2(1); 
//            "Постоянная времени T1: " + Programm.Model.Aperiodic2(2); 
//            "Постоянная времени T2: " + Programm.Model.Aperiodic2(3)]
//    end
//    
//    Programm.LastModulation.FilterOrder.Name = uiFilterOrder.String(uiFilterOrder.Value)
//    
//    if uiFilterOrder.Value == 1 then
//        Programm.LastModulation.FilterOrder.Parametres = [
//            "Коэффициент усиления: " + Programm.Filter.First(1); 
//            "Постоянная времени: " + Programm.Filter.First(2)]
//    end
//    
//    if uiFilterOrder.Value == 2 then
//        Programm.LastModulation.FilterOrder.Parametres = [
//            "Коэффициент усиления: " + Programm.Filter.Second(1); 
//            "Постоянная времени T1: " + Programm.Filter.Second(2); 
//            "Постоянная времени T2: " + Programm.Filter.Second(3)]
//    end
        
    set(start, "enable", "on")  
    set(noDataFrame, "visible", "off")
    set(plot_frame, "visible", "on")
      
    close(waitbarHandle)
//    
//catch
//    close(waitbarHandle)
//    set(start, "enable", "on")
//    messagebox(lasterror(), "Error", "error", ["Ок"], "modal")
//end
endfunction

function SavePlotIntoImage()
    global Programm
    
    if plot_frame.children == [] then
        messagebox("Результаты моделирования не обнаружены!", "Error", "error", ["Ок"], "modal")
        return;
    end
    
    f = figure(..
       "visible", "off", ..
       "figure_position", [100 100], ..
       "axes_size", [1500 700], ..
       "auto_resize", "on", ..
       "figure_name", "Экспорт результатов моделирования")
   
   newaxes(f)
   parametresAxes = gca()
   parametresAxes.Margins = [.03 0 .02 .02]
   parametresAxes.Axes_bounds = [0 0 .31 1]
   parametresAxes.box = "on"
   
   graphAxes = copy(plot_frame.Children)
   
   for i = 1:length(graphAxes)
       a = graphAxes(i)
       a.Parent = f
       a.Axes_bounds(1) = .315
       a.Axes_bounds(3) = 1
       a.Margins = [.04 .325 .05 .125]
   end
   
   sca(parametresAxes)
      
    xset("font", 12, 3)
    
    row = .95
    indent = .025
    indentLeft = .03
    
    xstring(.5, row, "Параметры моделирования")
    t = get("hdl")
    t.text_box_mode = 'centered'
    
    row = row - indent - indent - indent
    xstring(indentLeft, row, "Входной сигнал: " + Programm.LastModulation.SignalType.Name)
    
    for i = 1:length(length(Programm.LastModulation.SignalType.Parametres))
        row = row - indent
        xstring(indentLeft, row, Programm.LastModulation.SignalType.Parametres(i))
    end
    
    row = row - indent - indent
    xstring(indentLeft, row, "Модель объекта: " + Programm.LastModulation.ObjectModel.Name)
    
    for i = 1:length(length(Programm.LastModulation.ObjectModel.Parametres))
        row = row - indent
        xstring(indentLeft, row, Programm.LastModulation.ObjectModel.Parametres(i))
    end
    
    row = row - indent - indent
    
    xstring(indentLeft, row, "Порядок фильтра: " + Programm.LastModulation.FilterOrder.Name)
    
    for i = 1:length(length(Programm.LastModulation.FilterOrder.Parametres))
        row = row - indent
        xstring(indentLeft, row, Programm.LastModulation.FilterOrder.Parametres(i))
    end
    
    exportUI(f)
    close(f)
    
endfunction

function Help()
    exec(programmPath + "help.sce")
endfunction

function AboutUs()
    exec(programmPath + "AboutUs.sce")
endfunction

function OpenFirstOrderFilterDiagram()
    deletefile(programmPath + "filters/FirstOrderFilterDiagram.zcos")
    copyfile(programmPath + "filters/_FirstOrderFilterDiagram.zcos", programmPath + "filters/FirstOrderFilterDiagram.zcos")
    xcos(programmPath + "filters/FirstOrderFilterDiagram.zcos")
endfunction

function OpenSecindOrderFilterDiagram()
    deletefile(programmPath + "filters/SecondOrderFilterDiagram.zcos")
    copyfile(programmPath + "filters/_SecondOrderFilterDiagram.zcos", programmPath + "filters/SecondOrderFilterDiagram.zcos")
    xcos(programmPath + "filters/SecondOrderFilterDiagram.zcos")
endfunction

function CloseProgramm()
    close(main_figure)
endfunction

function RefreshInputSignals()
    Programm.Modules.InputSignals.List = strsubst(findfiles(Programm.Modules.InputSignals.Path, "*.zcos"), ".zcos", "");
    Programm.Modules.InputSignals.List = [Programm.Modules.InputSignals.List; "Добавить..."]   
    
    set(signalType, "String", Programm.Modules.InputSignals.List);
    
    if Programm.Modules.InputSignals.List == ["Добавить..."] then
        set(signalType, "Value", 0);
    else
        set(signalType, "Value", 1);
    end
endfunction     

function RefreshObjects()
    Programm.Modules.Objects.List = strsubst(findfiles(Programm.Modules.Objects.Path, "*.zcos"), ".zcos", "");    
    Programm.Modules.Objects.List = [Programm.Modules.Objects.List; "Добавить..."]   
    
    set(link_type, "String", Programm.Modules.Objects.List);
    
    if Programm.Modules.Objects.List == ["Добавить..."] then
        set(link_type, "Value", 0);
    else
        set(link_type, "Value", 1);
    end
endfunction     

function RefreshIndetification()
    Programm.Modules.Indetification.List = strsubst(findfiles(Programm.Modules.Indetification.Path, "*.zcos"), ".zcos", "");    
    Programm.Modules.Indetification.List = [Programm.Modules.Indetification.List; "Добавить..."]
        
    set(uiFilterOrder, "String", Programm.Modules.Indetification.List);
    
    if Programm.Modules.Indetification.List == ["Добавить..."] then
        set(uiFilterOrder, "Value", 0);
    else
        set(uiFilterOrder, "Value", 1);
    end
endfunction 

RefreshInputSignals()
RefreshObjects()
RefreshIndetification()

function AddModule(popupmenu, path, refreshFunc)
    if popupmenu.String(popupmenu.Value) <> "Добавить..." then return; end
    
    [newFileName, newFilePath] = uigetfile(["*.zcos", "XCos Files (*.zcos)"])
    
    if newFilePath <> "" then
        if find(newFileName == findfiles(path, "*.zcos")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        elseif newFileName == "Добавить..." then
            messagebox("Это зарезервированное имя!", "Error", "error", ["Ок"], "modal");
        else        
             copyfile(newFilePath + "\" + newFileName, path + newFileName);
        end
    end
    
    refreshFunc()
endfunction

function OpenModule(path, name)
    xcos(path + name + ".zcos");
endfunction
