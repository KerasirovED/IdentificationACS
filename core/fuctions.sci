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
