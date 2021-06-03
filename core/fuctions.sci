function Set_Xcos_parametres(plot_frame)
//try    
    global IdentificationACS
    
    set(plot_frame, "visible", "on")
    
    delete(plot_frame.Children)
    newaxes(plot_frame)
    
    set(start, "enable", "off")
    set(noDataFrame, "visible", "on")
    set(plot_frame, "visible", "off")
    
    waitbarHandle = progressionbar("Выполнение моделирования...")
    
    exec(programmPath + "LoadDiagrams.sce");
        
    inputSignal = IdentificationACS.Diagrams.InputSignal.objs
    object = IdentificationACS.Diagrams.Object.objs
    identification = IdentificationACS.Diagrams.Identification.objs
    
    IdentificationACS.Diagrams.Main.objs(2).model.rpar.objs  = identification // identification
    IdentificationACS.Diagrams.Main.objs(3).model.rpar.objs = inputSignal     // inputSignal
    IdentificationACS.Diagrams.Main.objs(4).model.rpar.objs = object          // object
    
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
    
    IdentificationACS.Diagrams.Main.objs(2).model.out = out
    IdentificationACS.Diagrams.Main.objs(2).model.out2 = out2
    IdentificationACS.Diagrams.Main.objs(2).model.outtyp = outtyp
    
     clkSplit = CLKSPLIT_f("define");
     clkSplit.model.evtin = -1;
     clkSplit.model.evtout = out;         
     clkSplit.model.firing = out;
     
    IdentificationACS.Diagrams.Main.objs($+1) = clkSplit
    splitNumber = length(IdentificationACS.Diagrams.Main.objs)
        
    linkFromClkToSplit = scicos_link("define");
    linkFromClkToSplit.from = [1 1 0]
    linkFromClkToSplit.to = [splitNumber 1 1]
    linkFromClkToSplit.ct = [5 -1]
    
    IdentificationACS.Diagrams.Main.objs($+1) = linkFromClkToSplit
        
    linkFromSplitToOut = scicos_link("define");
    linkFromSplitToOut.from = [splitNumber 0 0]
    linkFromSplitToOut.to = [0 1 1]
    linkFromSplitToOut.ct = [5 -1]
    
    out = TOWS_c("define");
    
    linkFromIndetificationToOut = scicos_link("define");
    linkFromIndetificationToOut.from = [2 0 0]
    linkFromIndetificationToOut.to = [0 1 1]
    
    for i = 1 : countOutputPorts
        IdentificationACS.Diagrams.Main.objs($+1) = out
        
        linkFromSplitToOut.from(2) = i // Порт из Split откуда выходит сигнал от CLK
        linkFromSplitToOut.to(1) = length(IdentificationACS.Diagrams.Main.objs) // Номер блока куда заходит сигнал от CLK
            
        linkFromIndetificationToOut.from(2) = i
        linkFromIndetificationToOut.to(1) = length(IdentificationACS.Diagrams.Main.objs)
        
        IdentificationACS.Diagrams.Main.objs($+1) = linkFromSplitToOut
        IdentificationACS.Diagrams.Main.objs($+1) = linkFromIndetificationToOut
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
//    IdentificationACS.LastModulation.SignalType.Name = signalType.String(signalType.Value)
//    
//    if signalType.Value == 1 then
//        IdentificationACS.LastModulation.SignalType.Parametres = [
//            "Время возникновения: " + string(IdentificationACS.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(1)); 
//            "Начальное значение: " + string(IdentificationACS.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(2)); 
//            "Итоговое значение: " + string(IdentificationACS.scs_m.objs(21).model.rpar.objs(1).graphics.exprs(3))]
//    end
//    
//    if signalType.Value == 2 then
//        IdentificationACS.LastModulation.SignalType.Parametres = [
//            "Амплитуда: " + string(IdentificationACS.scs_m.objs(22).graphics.exprs(1)); 
//            "Частота (рад/с): " + string(IdentificationACS.scs_m.objs(22).graphics.exprs(2)); 
//            "Фаза (рад): " + string(IdentificationACS.scs_m.objs(22).graphics.exprs(3))]
//    end
//    
//    if signalType.Value == 3 then
//        IdentificationACS.LastModulation.SignalType.Parametres = [
//            "Задержка по фазе (с): " + string(IdentificationACS.scs_m.objs(23).graphics.exprs(1)); 
//            "Длительность импульса (%): " + string(IdentificationACS.scs_m.objs(23).graphics.exprs(2)); 
//            "Период (с): " + string(IdentificationACS.scs_m.objs(23).graphics.exprs(3)); 
//            "Амлитуда: " + string(IdentificationACS.scs_m.objs(23).graphics.exprs(4))]
//    end
//    
//    if signalType.Value == 4 then
//        
//        if IdentificationACS.scs_m.objs(2).graphics.exprs(2) == "0" then
//            kindOfDistribution = "Равномерное"
//        else
//            kindOfDistribution = "Нормальное"
//        end
//        
//        IdentificationACS.LastModulation.SignalType.Parametres = [
//            "Вид распределения: " + kindOfDistribution; 
//            "A: " + string(IdentificationACS.scs_m.objs(2).graphics.exprs(3)); 
//            "B: " + string(IdentificationACS.scs_m.objs(2).graphics.exprs(4))]
//    end
//    
//    IdentificationACS.LastModulation.ObjectModel.Name = link_type.String(link_type.Value)
//    
//    if link_type.Value == 1 then
//        IdentificationACS.LastModulation.ObjectModel.Parametres = [
//            "Коэффициент усиления: " + IdentificationACS.Model.Aperiodic1(1); 
//            "Постоянная времени: " + IdentificationACS.Model.Aperiodic1(2)]
//    end
//    
//    if signalType.Value == 2 then
//        IdentificationACS.LastModulation.ObjectModel.Parametres = [
//            "Коэффициент усиления: " + IdentificationACS.Model.Aperiodic2(1); 
//            "Постоянная времени T1: " + IdentificationACS.Model.Aperiodic2(2); 
//            "Постоянная времени T2: " + IdentificationACS.Model.Aperiodic2(3)]
//    end
//    
//    IdentificationACS.LastModulation.FilterOrder.Name = uiFilterOrder.String(uiFilterOrder.Value)
//    
//    if uiFilterOrder.Value == 1 then
//        IdentificationACS.LastModulation.FilterOrder.Parametres = [
//            "Коэффициент усиления: " + IdentificationACS.Filter.First(1); 
//            "Постоянная времени: " + IdentificationACS.Filter.First(2)]
//    end
//    
//    if uiFilterOrder.Value == 2 then
//        IdentificationACS.LastModulation.FilterOrder.Parametres = [
//            "Коэффициент усиления: " + IdentificationACS.Filter.Second(1); 
//            "Постоянная времени T1: " + IdentificationACS.Filter.Second(2); 
//            "Постоянная времени T2: " + IdentificationACS.Filter.Second(3)]
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
    global IdentificationACS
    
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
    xstring(indentLeft, row, "Входной сигнал: " + IdentificationACS.LastModulation.SignalType.Name)
    
    for i = 1:length(length(IdentificationACS.LastModulation.SignalType.Parametres))
        row = row - indent
        xstring(indentLeft, row, IdentificationACS.LastModulation.SignalType.Parametres(i))
    end
    
    row = row - indent - indent
    xstring(indentLeft, row, "Модель объекта: " + IdentificationACS.LastModulation.ObjectModel.Name)
    
    for i = 1:length(length(IdentificationACS.LastModulation.ObjectModel.Parametres))
        row = row - indent
        xstring(indentLeft, row, IdentificationACS.LastModulation.ObjectModel.Parametres(i))
    end
    
    row = row - indent - indent
    
    xstring(indentLeft, row, "Порядок фильтра: " + IdentificationACS.LastModulation.FilterOrder.Name)
    
    for i = 1:length(length(IdentificationACS.LastModulation.FilterOrder.Parametres))
        row = row - indent
        xstring(indentLeft, row, IdentificationACS.LastModulation.FilterOrder.Parametres(i))
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
