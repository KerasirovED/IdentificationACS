function MainWindowNavigation_Backward()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
    SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == 1) then
        Programm.MainWindow.Buttons.Previous.Enable = "off";
    end 

    Programm.MainWindow.Buttons.Next.Enable = "on";
endfunction

function MainWindowNavigation_Forward()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex + 1;
    SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex = size(Programm.MainWindow.Navigation.List)) then
        Programm.MainWindow.Buttons.Next.Enable = "off";
    end 
    
    Programm.MainWindow.Buttons.Previous.Enable = "on";
endfunction

function MainWindowNavigation_Home)
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = 1;
    SetModulesList(1));
    
    Programm.MainWindow.Buttons.Previous.Enable = "off";
    Programm.MainWindow.Buttons.Next.Enable = "on";
endfunction

function MainWindowNavigation_Open(name)
    global Programm;

    pathName = "\" + name;

    list = Programm.MainWindow.Navigation.List;

    if (isfile(list(%) + pathName) then
        Programm.MainWindow.Texts.ModuleName.String = name;
    else
        currentIndex = Programm.MainWindow.Navigation.CurrentIndex;

        // Вставка нового пути в конец списка
        if currentIndex == size(list) then
            Programm.MainWindow.Navigation.List($+1) = list($) + pathName;
            return;
        end

        // Переход к каталогу, который отличается от следующего
        if list(currentIndex) + pathName != list(currentIndex + 1) then
            for i = currentIndex + 1 : size(list)
                Programm.MainWindow.Navigation.List(i) = null;
            end

            Programm.MainWindow.Navigation.List($+1) = list($) + pathName;

            return;
        end

        Programm.MainWindow.Navigation.CurrentIndex = currentIndex + 1;
        SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));
    end
endfunction

function SetModulesList(path)
    global Programm;

    dirInfo = dir(path);

    Programm.MainWindow.Listboxes.SelectModuleListbox.String = [];
    for i = 1 : size(dirInfo.pathName, "r") // кол-во строк в векторе
        if (dirInfo.isdir(i) == %t) then
            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "folder", dirInfo.pathName(i), "#FFFFFF", "#000000"];
        else
            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "text-x-generic", dirInfo.pathName(i), "#FFFFFF", "#000000"];
        end
    end
endfunction