
waitbarHandle = progressionbar(["Выполняется запуск программы."; "Ожидайте..."]);

// Относительный путь
programmPath = get_absolute_file_path("Main.sce")

// Импорт XCos диграммы
importXcosDiagram(programmPath + "MainXcos.zcos")

// load the blocks library and the simulation engine
loadXcosLibs(); 
loadScicos();

// Импорт *.sci файлов
getd(programmPath + "help\")
getd(programmPath + "help\Programm\How to save open XCos\")
getd(programmPath + "help\Programm\How to save results\")
getd(programmPath + "help\Programm\How to use programm\")

// Переменная состояний программы
global Programm
Programm.Diagrams = [];
Programm.Diagrams.Main = [];
Programm.Diagrams.InputSignal = [];
Programm.Diagrams.Object = [];
Programm.Diagrams.Identification = [];

Programm.Help = [];
Programm.Model.Aperiodic1 = ["1" "0.1"];
Programm.Model.Aperiodic2 = ["1" "0.1" "0.01"];
Programm.Filter.First = ["1" "-1"];
Programm.Filter.Second = ["1" "-1" "-10"];
Programm.Version = "alpha 0";
Programm.LastModulation.SignalType.Name = [];
Programm.LastModulation.SignalType.Parametres = ["Время возникновения = 1"; "Начальное значение = 0"; "Итоговое значение = 1"];
Programm.LastModulation.ObjectModel.Name = [];
Programm.LastModulation.ObjectModel.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = 0.1"];
Programm.LastModulation.FilterOrder.Name = [];
Programm.LastModulation.FilterOrder.Parametres = ["Коэффициент усиления = 1"; "Постоянная времени = -1"];

Programm.Modules = []
Programm.Modules.InputSignals = []
Programm.Modules.InputSignals.Path = programmPath + "modules\InputSignals\";
Programm.Modules.InputSignals.List = ""

Programm.Modules.Objects = []
Programm.Modules.Objects.Path = programmPath + "modules\Objects\";
Programm.Modules.Objects.List = ""

Programm.Modules.Indetification = []
Programm.Modules.Indetification.Path = programmPath + "modules\Indetification\";
Programm.Modules.Indetification.List = ""

// Отрисовка интерфейса
exec(programmPath + "interface.sce");

close(waitbarHandle);
clear waitbarHandle;