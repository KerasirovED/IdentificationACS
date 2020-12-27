function mwn_b()
    global Programm;

    Programm.MainWindow.Navigation.CurrentIndex = Programm.MainWindow.Navigation.CurrentIndex - 1;
    SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

    if (Programm.MainWindow.Navigation.CurrentIndex == 1) then
        Programm.MainWindow.Buttons.Backward.Enable = "off";
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
    Programm.MainWindow.Buttons.Forward.Enable = "off";
endfunction

function mwn_o(name)
    global Programm;

    pathName = name + "\";

    disp(pathName)

    navList = Programm.MainWindow.Navigation.List;

    currentIndex = Programm.MainWindow.Navigation.CurrentIndex;

    if isfile(navList(currentIndex) + name) then
        Programm.MainWindow.Texts.ModuleName.String = name;
    else

        // Вставка нового пути в конец списка
        if currentIndex == size(navList) then
            Programm.MainWindow.Navigation.List($+1) = navList($) + pathName;
        else
        // Переход к каталогу, который отличается от следующего
        //if navList(currentIndex) + pathName <> navList(currentIndex + 1) then
            for i = currentIndex + 1 : size(navList)
                Programm.MainWindow.Navigation.List(i) = null();
            end

            Programm.MainWindow.Navigation.List($+1) = Programm.MainWindow.Navigation.List($) + pathName;
        end

        Programm.MainWindow.Navigation.CurrentIndex = currentIndex + 1;
        SetModulesList(Programm.MainWindow.Navigation.List(Programm.MainWindow.Navigation.CurrentIndex));

        Programm.MainWindow.Buttons.Forward.Enable = "off";
        Programm.MainWindow.Buttons.Backward.Enable = "on";
    end
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
        else
            if strrchr(dirInfo.name, '.') <> ".sci" & strrchr(dirInfo.name, '.') <> ".zcos" then continue; end

            Programm.MainWindow.Listboxes.SelectModuleListbox.String = [
                Programm.MainWindow.Listboxes.SelectModuleListbox.String;
                "text-x-generic", dirInfo.name(i), "#FFFFFF", "#000000"];
        end
    end
endfunction 