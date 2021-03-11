
function RefreshInputSignals()
    global Programm;

    Programm.Modules.InputSignals.List = findfiles(Programm.Modules.InputSignals.Path, "*.zcos");
    Programm.Modules.InputSignals.List = [Programm.Modules.InputSignals.List; findfiles(Programm.Modules.InputSignals.Path, "*.sce")];
    Programm.Modules.InputSignals.List = [Programm.Modules.InputSignals.List; "Добавить..."];
    
    set(Programm.MainWindow.Popmenus.SignalType, "String", Programm.Modules.InputSignals.List);
    
    if Programm.Modules.InputSignals.List == ["Добавить..."] then
        set(Programm.MainWindow.Popmenus.SignalType, "Value", 0);
    else
        set(Programm.MainWindow.Popmenus.SignalType, "Value", 1);
    end

    if Programm.MainWindow.Popmenus.SignalType.Value == 0 then 
        Programm.MainWindow.Buttons.RemoveInput.Enable = "off";
    else
        Programm.MainWindow.Buttons.RemoveInput.Enable = "on";
    end
endfunction     

function RefreshObjects()
    global Programm;

    Programm.Modules.Objects.List = findfiles(Programm.Modules.Objects.Path, "*.zcos");
    Programm.Modules.Objects.List = [Programm.Modules.Objects.List; findfiles(Programm.Modules.Objects.Path, "*.sce")];
    Programm.Modules.Objects.List = [Programm.Modules.Objects.List; "Добавить..."];
    
    set(Programm.MainWindow.Popmenus.ObjectModel, "String", Programm.Modules.Objects.List);
    
    if Programm.Modules.Objects.List == ["Добавить..."] then
        set(Programm.MainWindow.Popmenus.ObjectModel, "Value", 0);
    else
        set(Programm.MainWindow.Popmenus.ObjectModel, "Value", 1);
    end

    if Programm.MainWindow.Popmenus.ObjectModel.Value == 0 then 
        Programm.MainWindow.Buttons.RemoveObject.Enable = "off";
    else
        Programm.MainWindow.Buttons.RemoveObject.Enable = "on";
    end
endfunction

function AddModule(popupmenu, path, refreshFunc)
    if popupmenu.String(popupmenu.Value) <> "Добавить..." then return; end
    
    [newFileName, newFilePath] = uigetfile([
        "*.sci", "SciNotes Instruction Files (*.sci)"; 
        "*.sce", "SciNotes Executiable Files (*.sce)"; 
        "*.zcos", "XCos Files (*.zcos)"])
    
    if newFilePath <> "" then
        if find(newFileName == findfiles(path, "*.zcos")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        elseif find(newFileName == findfiles(path, "*.sci")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        elseif newFileName == "Добавить..." then
            messagebox("Это зарезервированное имя!", "Error", "error", ["Ок"], "modal");
        else        
             copyfile(newFilePath + "\" + newFileName, path + newFileName);
        end
    end
    
    refreshFunc();
endfunction

function RenameModule(path, name, refreshFunc)    
    newName = x_dialog('Новое имя файла:', name);

    // Отмена
    if newName == [] then return; end

    // Ок
    copyfile(path + name, path + newName);    
    deletefile(path + name);
    refreshFunc();
endfunction

function RemoveModule(popupmenu, path, name, refreshFunc)    
    ans = messagebox("Вы действительно хотите удалить модуль """ + name + """?", "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    deletefile(path + name);
endfunction

function OpenModule(path, name)
    if strrchr(name, '.') == ".sce" | strrchr(name, '.') == ".sci" then
        scinotes(path + name);
    else
        xcos(path + name);
    end
endfunction