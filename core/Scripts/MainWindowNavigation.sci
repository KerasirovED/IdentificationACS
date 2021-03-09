function mwn_b()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
    SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == 1) then
        Programm.MainWindow.Buttons.Backward.Enable = "off";
        Programm.MainWindow.Buttons.RemoveFolder.Enable = "off";
    end 

    Programm.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_f()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex + 1;
    SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == size(Programm.MainWindow.Navigation.List)) then
        Programm.MainWindow.Buttons.Forward.Enable = "off";
    end 

    Programm.MainWindow.Buttons.Backward.Enable = "on";
    Programm.MainWindow.Buttons.RemoveFolder.Enable = "on";
endfunction

function mwn_h()
    global Programm;

    if (Programm.MainWindow.Navigation.List($) <> Programm.MainWindow.Navigation.List(1)) then 
        Programm.MainWindow.Navigation.List($+1) = Programm.MainWindow.Navigation.List(1);        
        Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex + 1;
    end
    
    SetModulesList(Programm.MainWindow.Navigation.List($));
    Programm.MainWindow.Navigation.CurrentIndex = size(Programm.MainWindow.Navigation.List);

    Programm.MainWindow.Buttons.Previous.Enable = "on";
    Programm.MainWindow.Buttons.Forward.Enable = "on";
endfunction

function mwn_o(name)
    global Programm;

    Programm.MainWindow.Navigation.CurrentFolderName = name;    
    pathName = name + "\";

    navList = Programm.MainWindow.Navigation.List;
    currentIndex = Programm.MainWindow.Navigation.CurrentIndex;

    if isfile(navList(currentIndex) + name) then
        Programm.MainWindow.Texts.ModuleName.String = name;
        Programm.MainWindow.Buttons.ObjectModel.Enable = "on";
    else
        // Вставка нового пути в конец списка
        if currentIndex == size(navList) then
            Programm.MainWindow.Navigation.List($+1) = navList($) + pathName;
        else
            // Переход к каталогу, который отличается от следующего
            if navList(currentIndex) + pathName <> navList(currentIndex + 1) then
                DrElsFrNavLst(currentIndex);
                Programm.MainWindow.Navigation.List($+1) = Programm.MainWindow.Navigation.List($) + pathName;
            end
        end

        // Переход к каталогу, который НЕ отличается от следующего, то ничего не делаем

        Programm.MainWindow.Navigation.CurrentIndex = currentIndex + 1;
        SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

        Programm.MainWindow.Buttons.Forward.Enable = "off";
        Programm.MainWindow.Buttons.Backward.Enable = "on";
        Programm.MainWindow.Buttons.RemoveFolder.Enable = "on";
    end
endfunction

function mwn_crtFldr()
    try
        folderName = x_dialog('Имя новой папки:','');

        if folderName == [] then return; end

        mkdir(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex) + folderName);
        SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));    
    catch
        [error_message,error_number]=lasterror(%t);
        messagebox(error_message, "Error!", "error", "modal");
    end
endfunction

function mwn_rmvFldr()
    ans = messagebox( ..
        "Вы действительно хотите удалить папку """ + Programm.MainWindow.Navigation.CurrentFolderName + """ со всем её содержимым?", ..
        "", "question", ["Да" "Нет"], "modal");

    // Нет
    if ans == 2 then return; end

    // Да
    [status, msg] = rmdir(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex), 's');

    if status == 0 then messagebox(msg, "", "error", "modal"); end
    
        DrElsFrNavLst(Programm.MainWindow.Navigation.CurrentIndex - 1);
    SetModulesList(Programm.MainWindow.Navigation.List($));

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
endfunction

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
            if strrchr(dirInfo.name, '.') <> ".sci" & strrchr(dirInfo.name, '.') <> ".zcos" then continue; end

            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "text-x-generic", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end

    Programm.MainWindow.Texts.CurrentPath.String = "\" + ..
        strsubst(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex), ..
        Programm.Modules.Indetification.Path, "");
endfunction 

// DropElementsFromNavigationListToIndex
function DrElsFrNavLst(index)
    while size(Programm.MainWindow.Navigation.List) > index
        Programm.MainWindow.Navigation.List($) = null();
    end
endfunction