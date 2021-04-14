function SetModulesList(path)
    global Programm;

    dirInfo = dir(path);

    Programm.MainWindow.Listboxes.SelectModuleListbox.String = [];
    for i = 1 : size(dirInfo.name, "r") // кол-во строк в векторе
        if (dirInfo.isdir(i) == %t) then
            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "folder", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end

    for i = 1 : size(dirInfo.name, "r") // кол-во строк в векторе
        if (dirInfo.isdir(i) == %f) then
            if strrchr(dirInfo.name, '.') <> ".sce" & strrchr(dirInfo.name, '.') <> ".zcos" then continue; end

            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "text-x-generic", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end

    Programm.MainWindow.Texts.CurrentPath.String = ..
        Programm.MainWindow.Navigation.RelativePaths(Programm.MainWindow.Navigation.CurrentIndex);
endfunction 

function mwn_b()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
    SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == 1) then
        Programm.MainWindow.Buttons.Backward.Enable = "off";
        Programm.MainWindow.Buttons.RemoveFolder.Enable = "off";
        Programm.MainWindow.Buttons.RenameModule.Enable = "off";
    end 

    Programm.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_f()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex + 1;
    SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == size(Programm.MainWindow.Navigation.FullPaths)) then
        Programm.MainWindow.Buttons.Forward.Enable = "off";
    end 

    Programm.MainWindow.Buttons.Backward.Enable = "on";
    Programm.MainWindow.Buttons.RemoveFolder.Enable = "on";
    Programm.MainWindow.Buttons.RenameModule.Enable = "on";
endfunction

function mwn_h()
    global Programm;

    if (Programm.MainWindow.Navigation.FullPaths($) <> Programm.MainWindow.Navigation.FullPaths(1)) then 
        Programm.MainWindow.Navigation.FullPaths($+1) = Programm.MainWindow.Navigation.FullPaths(1);        
        Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex + 1;
    end
    
    SetModulesList(Programm.MainWindow.Navigation.FullPaths($));
    Programm.MainWindow.Navigation.CurrentIndex = size(Programm.MainWindow.Navigation.FullPaths);

    Programm.MainWindow.Buttons.Previous.Enable = "on";
    Programm.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_o(name)
    global Programm;

    Programm.MainWindow.Navigation.CurrentFolderName = name;    
    pathName = name + "\";

    navList = Programm.MainWindow.Navigation.FullPaths;
    currentIndex = Programm.MainWindow.Navigation.CurrentIndex;

    if isfile(navList(currentIndex) + name) then
        Programm.MainWindow.Texts.ModuleName.String = name;
        Programm.MainWindow.SelectedModule.Name = name;
        Programm.MainWindow.SelectedModule.Path = ..
            Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex);

        Programm.MainWindow.Buttons.ObjectModel.Enable = "on";
        Programm.MainWindow.Buttons.RemoveModule.Enable = "on";
        Programm.MainWindow.Buttons.RenameModule.Enable = "on";
    else
        // Вставка нового пути в конец списка

        if currentIndex == size(navList) then
            Programm.MainWindow.Navigation.FullPaths($+1) = navList($) + pathName;
            Programm.MainWindow.Navigation.RelativePaths($+1) = Programm.MainWindow.Navigation.RelativePaths($) + pathName;
            Programm.MainWindow.Navigation.FolderNames($+1) = name;
        else
            // Переход к каталогу, который отличается от следующего
            if navList(currentIndex) + pathName <> navList(currentIndex + 1) then
                DrElsFrNavLst(currentIndex);

                Programm.MainWindow.Navigation.FullPaths($+1) = Programm.MainWindow.Navigation.FullPaths($) + pathName;
                Programm.MainWindow.Navigation.RelativePaths($+1) = Programm.MainWindow.Navigation.RelativePaths($) + pathName;
                Programm.MainWindow.Navigation.FolderNames($+1) = name;
            end
        end

        // Переход к каталогу, который НЕ отличается от следующего, то ничего не делаем

        Programm.MainWindow.Navigation.CurrentIndex = currentIndex + 1;
        SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));

        Programm.MainWindow.Buttons.Forward.Enable = "off";
        Programm.MainWindow.Buttons.Backward.Enable = "on";
        Programm.MainWindow.Buttons.RemoveFolder.Enable = "on";
        Programm.MainWindow.Buttons.RenameModule.Enable = "on";
    end
endfunction

function mwn_crtFldr()
    global Programm;

    try
        folderName = x_dialog('Имя новой папки:','');

        if folderName == [] then return; end

        mkdir(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex) + folderName); // Создание новой пааки в той же директории
        SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex)); // Обновление 
    catch
        [error_message,error_number]=lasterror(%t);
        messagebox(error_message, "Error!", "error", "modal");
    end
endfunction

function mwn_rmvFldr()
    global Programm;

    ans = messagebox( ..
        "Вы действительно хотите удалить папку """ ..
        + Programm.MainWindow.Navigation.FolderNames(Programm.MainWindow.Navigation.CurrentIndex) ..
        + """ со всем её содержимым?", ..
        "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    [status, msg] = rmdir(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex), 's');

    if status == 0 then messagebox(msg, "", "error", "modal"); end

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
    
    DrElsFrNavLst(Programm.MainWindow.Navigation.CurrentIndex);
    SetModulesList(Programm.MainWindow.Navigation.FullPaths($));
endfunction

function mwn_addModule()
    global Programm;

    path = Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex);

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
    global Programm;

    newName = x_dialog('Новое имя файла:', Programm.MainWindow.SelectedModule.Name);

    // Отмена
    if newName == [] then return; end

    // Ок       
    copyfile(Programm.MainWindow.SelectedModule.Path + Programm.MainWindow.SelectedModule.Name, ..
        Programm.MainWindow.SelectedModule.Path + newName);
    deletefile(Programm.MainWindow.SelectedModule.Path + Programm.MainWindow.SelectedModule.Name);

    Programm.MainWindow.Texts.ModuleName.String = newName;
    Programm.MainWindow.SelectedModule.Name = newName;
    
    SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));
endfunction

function mwn_removeModule()
    global Programm;

    ans = messagebox( ..
        "Вы действительно хотите удалить модуль """ ..
        + Programm.MainWindow.SelectedModule.Name + """?", ..
        "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    deletefile(Programm.MainWindow.SelectedModule.Path + Programm.MainWindow.SelectedModule.Name);

    Programm.MainWindow.Texts.ModuleName.String = "<не выбранно>";
    Programm.MainWindow.SelectedModule.Name = "<не выбранно>";
    Programm.MainWindow.SelectedModule.Path = "";

    Programm.MainWindow.Buttons.ObjectModel.Enable = "off";
    Programm.MainWindow.Buttons.RemoveModule.Enable = "off";
    Programm.MainWindow.Buttons.RenameModule.Enable = "on";
    
    SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));
endfunction

// DropElementsFromNavigationListToIndex
function DrElsFrNavLst(index)
    global Programm;

    while size(Programm.MainWindow.Navigation.FullPaths) > index
        Programm.MainWindow.Navigation.FullPaths($) = null();
        Programm.MainWindow.Navigation.RelativePaths($) = null();
        Programm.MainWindow.Navigation.FolderNames($) = null();
    end
endfunction
