
function RefreshInputSignals()
    global IdentificationACS;

    IdentificationACS.Modules.InputSignals.List = findfiles(IdentificationACS.Modules.InputSignals.Path, "*.zcos");
    IdentificationACS.Modules.InputSignals.List = [IdentificationACS.Modules.InputSignals.List; findfiles(IdentificationACS.Modules.InputSignals.Path, "*.sce")];
    IdentificationACS.Modules.InputSignals.List = [IdentificationACS.Modules.InputSignals.List; "Добавить..."];
    
    set(IdentificationACS.MainWindow.Popmenus.InputSignals, "String", IdentificationACS.Modules.InputSignals.List);

    if IdentificationACS.Modules.InputSignals.List == ["Добавить..."] then
        IdentificationACS.MainWindow.Popmenus.InputSignals.Value = 0;

        IdentificationACS.MainWindow.Buttons.OpenInput.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RenameInput.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RemoveInput.Enable = "off";
    else
        IdentificationACS.MainWindow.Popmenus.InputSignals.Value = 1;

        IdentificationACS.MainWindow.Buttons.OpenInput.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RenameInput.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RemoveInput.Enable = "on";
    end
endfunction     

function RefreshObjects()
    global IdentificationACS;

    IdentificationACS.Modules.Objects.List = findfiles(IdentificationACS.Modules.Objects.Path, "*.zcos");
    IdentificationACS.Modules.Objects.List = [IdentificationACS.Modules.Objects.List; findfiles(IdentificationACS.Modules.Objects.Path, "*.sce")];
    IdentificationACS.Modules.Objects.List = [IdentificationACS.Modules.Objects.List; "Добавить..."];
    
    set(IdentificationACS.MainWindow.Popmenus.ObjectModel, "String", IdentificationACS.Modules.Objects.List);
    
    if IdentificationACS.Modules.Objects.List == ["Добавить..."] then
        IdentificationACS.MainWindow.Popmenus.ObjectModel.Value = 0;

        IdentificationACS.MainWindow.Buttons.OpenObject.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RenameObject.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RemoveObject.Enable = "off";
    else
        IdentificationACS.MainWindow.Popmenus.ObjectModel.Value = 1;

        IdentificationACS.MainWindow.Buttons.OpenObject.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RenameObject.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RemoveObject.Enable = "on";
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

    // Нет изменений
    if newName == name then return; end

    // Уже существует
    if find(path + newName == findfiles(path)) <> [] then
        messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        return;
    end

    // Ок
    copyfile(path + name, path + newName);    
    deletefile(path + name);
    refreshFunc();
endfunction

function RemoveModule(path, name, refreshFunc)    
    ans = messagebox("Вы действительно хотите удалить модуль """ + name + """?", "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    deletefile(path + name);

    refreshFunc();
endfunction

function OpenModule(path, name)
    if strrchr(name, '.') == ".sce" | strrchr(name, '.') == ".sci" then
        scinotes(path + name);
    else
        xcos(path + name);
    end
endfunction