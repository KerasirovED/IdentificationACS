

function RefreshInputSignals()
    global Programm;

    Programm.Modules.InputSignals.List = findfiles(Programm.Modules.InputSignals.Path);
    Programm.Modules.InputSignals.List = [Programm.Modules.InputSignals.List; "Добавить..."];
    
    set(Programm.MainWindow.Popmenus.SignalType, "String", Programm.Modules.InputSignals.List);
    
    if Programm.Modules.InputSignals.List == ["Добавить..."] then
        set(Programm.MainWindow.Popmenus.SignalType, "Value", 0);
    else
        set(Programm.MainWindow.Popmenus.SignalType, "Value", 1);
    end
endfunction     

function RefreshObjects()
    global Programm;

    Programm.Modules.Objects.List = strsubst(findfiles(Programm.Modules.Objects.Path, "*.zcos"), ".zcos", "");    
    Programm.Modules.Objects.List = [Programm.Modules.Objects.List; "Добавить..."];
    
    set(Programm.MainWindow.Popmenus.TransferType, "String", Programm.Modules.Objects.List);
    
    if Programm.Modules.Objects.List == ["Добавить..."] then
        set(Programm.MainWindow.Popmenus.TransferType, "Value", 0);
    else
        set(Programm.MainWindow.Popmenus.TransferType, "Value", 1);
    end
endfunction

function AddModule(popupmenu, path, refreshFunc)
    if popupmenu.String(popupmenu.Value) <> "Добавить..." then return; end
    
    [newFileName, newFilePath] = uigetfile(["*.sci", "SciNotes Files (*.sci)"; "*.zcos", "XCos Files (*.zcos)"])
    
    if newFilePath <> "" then
        if find(newFileName == findfiles(path, "*.zcos")) | find(newFileName == findfiles(path, "*.sci")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        elseif newFileName == "Добавить..." then
            messagebox("Это зарезервированное имя!", "Error", "error", ["Ок"], "modal");
        else        
             copyfile(newFilePath + "\" + newFileName, path + newFileName);
        end
    end
    
    refreshFunc();
endfunction

function OpenModule(path, name)
    if (strrchr(name, '.') == ".sce") then
        scinotes(path + name);
    else
        xcos(path + name);
    end
endfunction