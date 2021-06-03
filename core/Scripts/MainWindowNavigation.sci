function SetModulesList(path)
    global IdentificationACS;

    dirInfo = dir(path);

    IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String = [];
    for i = 1 : size(dirInfo.name, "r") // кол-во строк в векторе
        if (dirInfo.isdir(i) == %t) then
            IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String = [
                IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String;
                "folder", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end

    for i = 1 : size(dirInfo.name, "r") // кол-во строк в векторе
        if (dirInfo.isdir(i) == %f) then
            if strrchr(dirInfo.name, '.') <> ".sce" & strrchr(dirInfo.name, '.') <> ".zcos" then continue; end

            IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String = [
                IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String;
                "text-x-generic", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end

    IdentificationACS.MainWindow.Texts.CurrentPath.String = ..
        IdentificationACS.MainWindow.Navigation.RelativePaths(IdentificationACS.MainWindow.Navigation.CurrentIndex);
endfunction 

function mwn_b()
    global IdentificationACS;

    IdentificationACS.MainWindow.Navigation.CurrentIndex = IdentificationACS.MainWindow.Navigation.CurrentIndex - 1;
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));

    if (IdentificationACS.MainWindow.Navigation.CurrentIndex == 1) then
        IdentificationACS.MainWindow.Buttons.Backward.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RemoveFolder.Enable = "off";
        IdentificationACS.MainWindow.Buttons.RenameModule.Enable = "off";
    end 

    IdentificationACS.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_f()
    global IdentificationACS;

    IdentificationACS.MainWindow.Navigation.CurrentIndex = IdentificationACS.MainWindow.Navigation.CurrentIndex + 1;
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));

    if (IdentificationACS.MainWindow.Navigation.CurrentIndex == size(IdentificationACS.MainWindow.Navigation.FullPaths)) then
        IdentificationACS.MainWindow.Buttons.Forward.Enable = "off";
    end 

    IdentificationACS.MainWindow.Buttons.Backward.Enable = "on";
    IdentificationACS.MainWindow.Buttons.RemoveFolder.Enable = "on";
    IdentificationACS.MainWindow.Buttons.RenameModule.Enable = "on";
endfunction

function mwn_h()
    global IdentificationACS;

    if (IdentificationACS.MainWindow.Navigation.FullPaths($) <> IdentificationACS.MainWindow.Navigation.FullPaths(1)) then 
        IdentificationACS.MainWindow.Navigation.FullPaths($+1) = IdentificationACS.MainWindow.Navigation.FullPaths(1);        
        IdentificationACS.MainWindow.Navigation.CurrentIndex = IdentificationACS.MainWindow.Navigation.CurrentIndex + 1;
    end
    
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths($));
    IdentificationACS.MainWindow.Navigation.CurrentIndex = size(IdentificationACS.MainWindow.Navigation.FullPaths);

    IdentificationACS.MainWindow.Buttons.Previous.Enable = "on";
    IdentificationACS.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_o(name)
    global IdentificationACS;

    IdentificationACS.MainWindow.Navigation.CurrentFolderName = name;    
    pathName = name + "\";

    navList = IdentificationACS.MainWindow.Navigation.FullPaths;
    currentIndex = IdentificationACS.MainWindow.Navigation.CurrentIndex;

    if isfile(navList(currentIndex) + name) then
        IdentificationACS.MainWindow.Texts.ModuleName.String = name;
        IdentificationACS.MainWindow.SelectedModule.Name = name;
        IdentificationACS.MainWindow.SelectedModule.Path = ..
            IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex);

        IdentificationACS.MainWindow.Buttons.ObjectModel.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RemoveModule.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RenameModule.Enable = "on";
    else
        // Вставка нового пути в конец списка

        if currentIndex == size(navList) then
            IdentificationACS.MainWindow.Navigation.FullPaths($+1) = navList($) + pathName;
            IdentificationACS.MainWindow.Navigation.RelativePaths($+1) = IdentificationACS.MainWindow.Navigation.RelativePaths($) + pathName;
            IdentificationACS.MainWindow.Navigation.FolderNames($+1) = name;
        else
            // Переход к каталогу, который отличается от следующего
            if navList(currentIndex) + pathName <> navList(currentIndex + 1) then
                DrElsFrNavLst(currentIndex);

                IdentificationACS.MainWindow.Navigation.FullPaths($+1) = IdentificationACS.MainWindow.Navigation.FullPaths($) + pathName;
                IdentificationACS.MainWindow.Navigation.RelativePaths($+1) = IdentificationACS.MainWindow.Navigation.RelativePaths($) + pathName;
                IdentificationACS.MainWindow.Navigation.FolderNames($+1) = name;
            end
        end

        // Переход к каталогу, который НЕ отличается от следующего, то ничего не делаем

        IdentificationACS.MainWindow.Navigation.CurrentIndex = currentIndex + 1;
        SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));

        IdentificationACS.MainWindow.Buttons.Forward.Enable = "off";
        IdentificationACS.MainWindow.Buttons.Backward.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RemoveFolder.Enable = "on";
        IdentificationACS.MainWindow.Buttons.RenameModule.Enable = "on";
    end
endfunction

function mwn_crtFldr()
    global IdentificationACS;

    try
        folderName = x_dialog('Имя новой папки:','');

        if folderName == [] then return; end

        mkdir(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex) + folderName); // Создание новой пааки в той же директории
        SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex)); // Обновление 
    catch
        [error_message,error_number]=lasterror(%t);
        messagebox(error_message, "Error!", "error", "modal");
    end
endfunction

function mwn_rmvFldr()
    global IdentificationACS;

    ans = messagebox( ..
        "Вы действительно хотите удалить папку """ ..
        + IdentificationACS.MainWindow.Navigation.FolderNames(IdentificationACS.MainWindow.Navigation.CurrentIndex) ..
        + """ со всем её содержимым?", ..
        "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    [status, msg] = rmdir(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex), 's');

    if status == 0 then messagebox(msg, "", "error", "modal"); end

    IdentificationACS.MainWindow.Navigation.CurrentIndex = IdentificationACS.MainWindow.Navigation.CurrentIndex - 1;
    
    DrElsFrNavLst(IdentificationACS.MainWindow.Navigation.CurrentIndex);
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths($));
endfunction

function mwn_addModule()
    global IdentificationACS;

    path = IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex);

    [newFileName, newFilePath] = uigetfile(["*.sce", "SciNotes Execution Files (*.sce)"; "*.zcos", "XCos Files (*.zcos)"])

    if newFilePath <> "" then
        if find(newFileName == findfiles(path, "*.zcos")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        elseif find(newFileName == findfiles(path, "*.sci")) <> [] then
            messagebox("Модуль с таким именем уже обнаружен!", "Error", "error", ["Ок"], "modal");
        else        
            copyfile(newFilePath + "\" + newFileName, path + newFileName);
        end
    end
    
    SetModulesList(path);
endfunction

function mwn_renameModule()
    global IdentificationACS;

    newName = x_dialog('Новое имя файла:', IdentificationACS.MainWindow.SelectedModule.Name);

    // Отмена
    if newName == [] then return; end

    // Ок       
    copyfile(IdentificationACS.MainWindow.SelectedModule.Path + IdentificationACS.MainWindow.SelectedModule.Name, ..
        IdentificationACS.MainWindow.SelectedModule.Path + newName);
    deletefile(IdentificationACS.MainWindow.SelectedModule.Path + IdentificationACS.MainWindow.SelectedModule.Name);

    IdentificationACS.MainWindow.Texts.ModuleName.String = newName;
    IdentificationACS.MainWindow.SelectedModule.Name = newName;
    
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));
endfunction

function mwn_removeModule()
    global IdentificationACS;

    ans = messagebox( ..
        "Вы действительно хотите удалить модуль """ ..
        + IdentificationACS.MainWindow.SelectedModule.Name + """?", ..
        "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    deletefile(IdentificationACS.MainWindow.SelectedModule.Path + IdentificationACS.MainWindow.SelectedModule.Name);

    IdentificationACS.MainWindow.Texts.ModuleName.String = "<не выбранно>";
    IdentificationACS.MainWindow.SelectedModule.Name = "<не выбранно>";
    IdentificationACS.MainWindow.SelectedModule.Path = "";

    IdentificationACS.MainWindow.Buttons.ObjectModel.Enable = "off";
    IdentificationACS.MainWindow.Buttons.RemoveModule.Enable = "off";
    IdentificationACS.MainWindow.Buttons.RenameModule.Enable = "on";
    
    SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));
endfunction

// DropElementsFromNavigationListToIndex
function DrElsFrNavLst(index)
    global IdentificationACS;

    while size(IdentificationACS.MainWindow.Navigation.FullPaths) > index
        IdentificationACS.MainWindow.Navigation.FullPaths($) = null();
        IdentificationACS.MainWindow.Navigation.RelativePaths($) = null();
        IdentificationACS.MainWindow.Navigation.FolderNames($) = null();
    end
endfunction
