
warning("off");

waitbarHandle = progressionbar(["Выполняется запуск программы."; "Ожидайте..."]);

// if isdef("Programm") then
//     show_window(Programm.MainWindow.Window);
// else
    // try
        // Переменная состояний программы
        global Programm;

        Programm = [];
        Programm.Path = get_absolute_file_path("init.sce"); // Относительный путь
        Programm.Version = "alpha 0";

        Programm.MainWindow = [];
        Programm.MainWindow.Window = [];
        Programm.MainWindow.Frames = [];
        Programm.MainWindow.Popmenus = [];
        Programm.MainWindow.Listboxes = [];
        Programm.MainWindow.Buttons = [];
        Programm.MainWindow.Texts = [];
        Programm.MainWindow.Checkboxes = [];

        Programm.MainWindow.Navigation = [];
        Programm.MainWindow.Navigation.FolderNames = list("");
        Programm.MainWindow.Navigation.FullPaths = list(Programm.Path + "modules\Identification\");
        Programm.MainWindow.Navigation.RelativePaths = list("\");
        Programm.MainWindow.Navigation.CurrentIndex = 1;

        Programm.MainWindow.SelectedModule = [];
        Programm.MainWindow.SelectedModule.Name = "<не выбранно>";
        Programm.MainWindow.SelectedModule.Path = "";

        Programm.Diagrams = [];
        Programm.Diagrams.Main = [];
        Programm.Diagrams.InputSignal = [];
        Programm.Diagrams.Object = [];
        Programm.Diagrams.Identification = [];

        Programm.Help = [];

        Programm.Model = [];
        Programm.Model.Aperiodic1 = ["1" "0.1"];
        Programm.Model.Aperiodic2 = ["1" "0.1" "0.01"];

        Programm.Filter = [];
        Programm.Filter.First = ["1" "-1"];
        Programm.Filter.Second = ["1" "-1" "-10"];

        Programm.LastModulation = [];

        Programm.LastModulation.SignalType = [];
        Programm.LastModulation.SignalType.Name = [];
        Programm.LastModulation.SignalType.Parametres = ["Время возникновения = 1"; "Начальное значение = 0"; "Итоговое значение = 1"];

        Programm.LastModulation.ObjectModel = [];
        Programm.LastModulation.ObjectModel.Name = [];
        Programm.LastModulation.ObjectModel.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = 0.1"];

        Programm.LastModulation.FilterOrder = [];
        Programm.LastModulation.FilterOrder.Name = [];
        Programm.LastModulation.FilterOrder.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = -1"];

        Programm.Modules = [];
        Programm.Modules.InputSignals = [];
        Programm.Modules.InputSignals.Path = Programm.Path + "modules\InputSignals\";
        Programm.Modules.InputSignals.List = "";

        Programm.Modules.Objects = [];
        Programm.Modules.Objects.Path = Programm.Path + "modules\Objects\";
        Programm.Modules.Objects.List = "";

        Programm.Modules.Indetification = [];
        Programm.Modules.Indetification.Path = Programm.Path + "modules\Identification\";
        Programm.Modules.Indetification.List = "";

        // load the blocks library and the simulation engine
        loadXcosLibs(); 
        loadScicos();

        // Импорт *.sci файлов
        getd(Programm.Path + "Scripts\");
        getd(Programm.Path + "help\");
        getd(Programm.Path + "help\Programm\How to save open XCos\");
        getd(Programm.Path + "help\Programm\How to save results\");
        getd(Programm.Path + "help\Programm\How to use programm\");

        // Отрисовка интерфейса
        exec(Programm.Path + "interfaces\mainWindow.sce");    
    // catch
    //     [error_message,error_number, line, func]=lasterror(%f);
    //     messagebox(["Error " + string(error_number); error_message;
    //         "at line " + string(line) + " of function " + func], "Error!", "error", "modal");
    // end
// end

close(waitbarHandle);
clear waitbarHandle;

warning("on");
