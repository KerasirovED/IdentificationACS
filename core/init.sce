
warning("off");

waitbarHandle = progressionbar(["Выполняется запуск программы."; "Ожидайте..."]);

// if isdef("Programm") then
//     show_window(IdentificationACS.MainWindow.Window);
// else
    // try
        // Переменная состояний программы
        global IdentificationACS;
        IdentificationACS = [];

        // Абсолютный путь до папки с программным комплексом
        IdentificationACS.Path = get_absolute_file_path("init.sce");
        // Название программного комплекса
        IdentificationACS.ProgramName = "Программный комплекс идентификации САУ"; 
        // Версия программного комплекса
        IdentificationACS.Version = "alpha 0";

        // Информация основного окна программного комплекса
        IdentificationACS.MainWindow = [];

// Указатель на основное окно программного комплекса
IdentificationACS.MainWindow.Window = [];
// Указатели на uicontrol'ы типа frame
IdentificationACS.MainWindow.Frames = [];
// Указатели на uicontrol'ы типа popupmenu
IdentificationACS.MainWindow.Popmenus = [];
// Указатели на uicontrol'ы типа listbox
IdentificationACS.MainWindow.Listboxes = [];
// Указатели на uicontrol'ы типа button
IdentificationACS.MainWindow.Buttons = [];
// Указатели на uicontrol'ы типа text
IdentificationACS.MainWindow.Texts = [];
// Указатели на uicontrol'ы типа checkbox
IdentificationACS.MainWindow.Checkboxes = [];

// Переменные навигации по файловой структуре модулей идентификации САУ
IdentificationACS.MainWindow.Navigation = [];
// Имена папок, которые открывал пользователь
IdentificationACS.MainWindow.Navigation.FolderNames = list("");
// Абсолютные пути к папкам, которые открывал пользователь
IdentificationACS.MainWindow.Navigation.FullPaths = list(IdentificationACS.Path + "modules\Identification\");
// Отночительные пути к папкам, которые открывал пользователь
IdentificationACS.MainWindow.Navigation.RelativePaths = list("\");
// Текущий индекс в списках, на котором сейчас находится пользователь
IdentificationACS.MainWindow.Navigation.CurrentIndex = 1;

// Информация о текущем выбранном модуле идентификации САУ
IdentificationACS.MainWindow.SelectedModule = [];
// Имя модуля
IdentificationACS.MainWindow.SelectedModule.Name = "<не выбранно>";
// Абсолютный путь к модулю
IdentificationACS.MainWindow.SelectedModule.Path = "";

        IdentificationACS.Modules = [];
        IdentificationACS.Modules.InputSignals = [];
        IdentificationACS.Modules.InputSignals.Path = IdentificationACS.Path + "modules\InputSignals\";
        IdentificationACS.Modules.InputSignals.List = "";

        IdentificationACS.Modules.Objects = [];
        IdentificationACS.Modules.Objects.Path = IdentificationACS.Path + "modules\Objects\";
        IdentificationACS.Modules.Objects.List = "";

        IdentificationACS.Modules.Indetification = [];
        IdentificationACS.Modules.Indetification.Path = IdentificationACS.Path + "modules\Identification\";
        IdentificationACS.Modules.Indetification.List = "";

        IdentificationACS.Help = [];

        IdentificationACS.LastModulation = [];
        IdentificationACS.LastModulation.SourceName = [];
        IdentificationACS.LastModulation.ObjectName = [];
        IdentificationACS.LastModulation.IdentificationName = [];

        // load the blocks library and the simulation engine
        loadXcosLibs(); 
        loadScicos();

        // Импорт *.sci файлов
        getd(IdentificationACS.Path + "Scripts\");
        getd(IdentificationACS.Path + "help\");
        getd(IdentificationACS.Path + "help\Programm\How to save open XCos\");
        getd(IdentificationACS.Path + "help\Programm\How to save results\");
        getd(IdentificationACS.Path + "help\Programm\How to use programm\");

        // Отрисовка интерфейса
        exec(IdentificationACS.Path + "interfaces\mainWindow.sce");

        // Переменная графической области
        __graphics__ = [];
    // catch
    //     [error_message,error_number, line, func]=lasterror(%f);
    //     messagebox(["Error " + string(error_number); error_message;
    //         "at line " + string(line) + " of function " + func], "Error!", "error", "modal");
    // end
// end

close(waitbarHandle);
clear waitbarHandle;

warning("on");
