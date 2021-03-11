
global Programm;

// Основное окно программы
Programm.MainWindow.Window = figure(..
    "figure_id", 228, ..
    "figure_name", "Программный комплекс идентификации САУ (version: " + Programm.Version + ")", ..
    "dockable"        , "off",..
    "infobar_visible" , "off",..
    "toolbar"         , "none",..
    "default_axes"    , "off",..
    "layout"          , "gridbag",..
    "visible"         , "off", ..
   "figure_position", [100 50], ..
    "menubar" , "none",..
    "axes_size", [1000, 600]);
    
// Панель инструментов
m = uimenu(Programm.MainWindow.Window, "label", "Файл");
uimenu(m, "label", "Закрыть", "callback", "CloseProgramm", "icon", "close-tab");
m = uimenu(Programm.MainWindow.Window, "label", "График");
uimenu(m, "label", "Сохранить как изображение", "callback", "SavePlotIntoImage", "icon", "media-floppy");
m = uimenu(Programm.MainWindow.Window, "label", "Открыть диаграмму");
uimenu(m, "label", "Система идентификации с фильтром первого порядка", "callback", "OpenFirstOrderFilterDiagram", "icon", "utilities-system-monitor");
uimenu(m, "label", "Система идентификации с фильтром второго порядка", "callback", "OpenSecindOrderFilterDiagram", "icon", "utilities-system-monitor");
m = uimenu(Programm.MainWindow.Window, "label", "Справка");
uimenu(m, "label", "Справка", "callback", "exec(Programm.Path + ""help\Help.sce"")", "icon", "help-browser");
uimenu(m, "label", "О программе", "callback", "AboutUs", "icon", "dialog-information");

clear m;

// -------------------------------------------------------------------------
// Left Frame 
// -------------------------------------------------------------------------

Programm.MainWindow.Frames.Left = [];
Programm.MainWindow.Frames.Left = uicontrol(Programm.MainWindow.Window, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "margin", [5 5 5 0], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [-1 1], "vertical", "center", [-1 -1], [343 1]));

// -------- Входной сигнал -------- //

Programm.MainWindow.Frames.Signal = uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper", [0 0], [0 75]));

uicontrol(Programm.MainWindow.Frames.Signal, ..
    "style", "text", ..
    "string", "Входной сигнал:", ..
    "margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"));
    
Programm.MainWindow.Frames.SignalParametres = uicontrol(Programm.MainWindow.Frames.Signal, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 45]));
    
Programm.MainWindow.Popmenus.SignalType = [];
Programm.MainWindow.Popmenus.SignalType = uicontrol(Programm.MainWindow.Frames.SignalParametres, ..
    "style", "popupmenu", ..
    "string", Programm.Modules.InputSignals.List, ..
    "tag", "Programm.MainWindow.Frames.SignalType", ..
    "callback", "AddModule(Programm.MainWindow.Popmenus.SignalType, Programm.Modules.InputSignals.Path, RefreshInputSignals)", ..
    "position", [5 25 253 20]);
        
uicontrol(Programm.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "OpenModule(Programm.Modules.InputSignals.Path, Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value))", ..
    "icon", Programm.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 24 22 22]);

Programm.MainWindow.Buttons.RenameInput = [];
Programm.MainWindow.Buttons.RenameInput = uicontrol(Programm.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "RenameModule(Programm.Modules.InputSignals.Path, Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value), RefreshInputSignals)", ..
    "icon", Programm.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 24 22 22]);

Programm.MainWindow.Buttons.RemoveInput = uicontrol(Programm.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "RemoveModule(Programm.MainWindow.Popmenus.SignalType, Programm.Modules.InputSignals.Path, Programm.MainWindow.Popmenus.SignalType.String(Programm.MainWindow.Popmenus.SignalType.Value), RefreshInputSignals)", ..
    "icon", Programm.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 24 22 22]);

Programm.MainWindow.Checkboxes.ShowSource = [];
Programm.MainWindow.Checkboxes.ShowSource = uicontrol(Programm.MainWindow.Frames.SignalParametres, ..
    "style", "checkbox", ..
    "string", "Выводить на график", ..
    "position", [2 0 253 20]);
    
uicontrol(Programm.MainWindow.Frames.Signal, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"));

//-------- Модель объекта --------//

Programm.MainWindow.Frames.ObjectModel = uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "horizontal", "upper", [0 0], [0 75]));

uicontrol(Programm.MainWindow.Frames.ObjectModel, ..
    "style", "text", ..
    "string", "Модель объекта:", ..
    "margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"));
    
Programm.MainWindow.Frames.ObjectModelParametres = uicontrol(Programm.MainWindow.Frames.ObjectModel, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 45]));
    
Programm.MainWindow.Popmenus.ObjectModel = uicontrol(Programm.MainWindow.Frames.ObjectModelParametres, ..
    "style", "popupmenu", ..
    "string", Programm.Modules.Objects.List, ..
    "tag", "Programm.MainWindow.Popmenus.ObjectModel_tag", ..
    "callback", "AddModule(Programm.MainWindow.Popmenus.ObjectModel, Programm.Modules.Objects.Path, RefreshObjects)", ..
    "position", [5 25 253 20]);
        
uicontrol(Programm.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..
    "callback", "OpenModule(Programm.Modules.Objects.Path, Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value))", ..
    "icon", Programm.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 24 22 22]);

Programm.MainWindow.Buttons.RenameObject = uicontrol(Programm.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..    
    "callback", "RenameModule(Programm.Modules.Objects.Path, Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value), RefreshObjects)", ..
    "icon", Programm.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 24 22 22]);

Programm.MainWindow.Buttons.RemoveObject = uicontrol(Programm.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..    
    "callback", "RemoveModule(Programm.MainWindow.Popmenus.ObjectModel, Programm.Modules.Objects.Path, Programm.MainWindow.Popmenus.ObjectModel.String(Programm.MainWindow.Popmenus.ObjectModel.Value), RefreshObjects)", ..
    "icon", Programm.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 24 22 22]);

Programm.MainWindow.Checkboxes.ShowObj = uicontrol(Programm.MainWindow.Frames.ObjectModelParametres, ..
    "style", "checkbox", ..
    "string", "Выводить на график", ..
    "position", [2 0 253 20]);
    
uicontrol(Programm.MainWindow.Frames.ObjectModel, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"));
    
//-------- Система идентификации --------//

Programm.MainWindow.Frames.SelectModule = uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 4 1 1], [1 1], "both"));

Programm.MainWindow.Frames.SelectedModule = uicontrol(Programm.MainWindow.Frames.SelectModule, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "both", "center", [0 0], [0 25]));

uicontrol(Programm.MainWindow.Frames.SelectedModule, ..
    "style", "text", ..
    "string", "Выбран модуль:", ..
    "position", [5 0 85 20]);

Programm.MainWindow.Texts.ModuleName = [];
Programm.MainWindow.Texts.ModuleName = uicontrol(Programm.MainWindow.Frames.SelectedModule, ..
    "style", "text", ..
    "string", Programm.MainWindow.SelectedModule.Name, ..
    "position", [95 0 165 20]);

Programm.MainWindow.Buttons.ObjectModel = uicontrol(Programm.MainWindow.Frames.SelectedModule, ..
    "callback", "OpenModule(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex), Programm.MainWindow.Texts.ModuleName.String)", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 -1 22 22]);

Programm.MainWindow.Buttons.RenameModule = uicontrol(Programm.MainWindow.Frames.SelectedModule, ..
    "callback", "mwn_renameModule", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 -1 22 22]);

Programm.MainWindow.Buttons.RemoveModule = uicontrol(Programm.MainWindow.Frames.SelectedModule, ..
    "callback", "mwn_removeModule", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 -1 22 22]);

Programm.MainWindow.Frames.SelectModuleNavigationButtons = uicontrol(Programm.MainWindow.Frames.SelectModule, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 60]));
    
Programm.MainWindow.Buttons.Backward = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_b", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\backward.png", ..
    "position", [5 25 30 30]);

Programm.MainWindow.Buttons.Forward = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_f", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\forward.png", ..
    "position", [38 25 30 30]);
    
Programm.MainWindow.Buttons.Home = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_h", ..
    "enable", "off", ..
    "icon", Programm.Path + "images\home-folder.png", ..
    "position", [71 25 30 30]);

Programm.MainWindow.Buttons.RemoveFolder = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", Programm.Path + "images\remove-folder.png", ..
    "callback", "mwn_rmvFldr", ..
    "TooltipString", "Удалить текущую папку", ..
    "enable", "off", ..
    "position", [232 25 30 30]);

Programm.MainWindow.Buttons.AddFolder = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", Programm.Path + "images\add-folder.png", ..
    "callback", "mwn_crtFldr", ..
    "TooltipString", "Создать папку", ..
    "position", [265 25 30 30]);

Programm.MainWindow.Buttons.AddNewModule = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", Programm.Path + "images\add-file.png", ..
    "callback", "mwn_addModule", ..
    "TooltipString", "Добавить модуль", ..
    "position", [298 25 30 30]);

Programm.MainWindow.Texts.CurrentPath = uicontrol(Programm.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "style", "text", ..
    "position", [5 0 277 20]);

Programm.MainWindow.Listboxes.SelectModuleListbox = [];
Programm.MainWindow.Listboxes.SelectModuleListbox = uicontrol(Programm.MainWindow.Frames.SelectModule, ..
    "style", "listbox", ..
    "Margins", [0 5 5 5], ..
    "callback", "mwn_o(Programm.MainWindow.Listboxes.SelectModuleListbox.String(Programm.MainWindow.Listboxes.SelectModuleListbox.Value + size(Programm.MainWindow.Listboxes.SelectModuleListbox.String, ""r"")))", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both"));

//-------- Время моделирования --------//
    
Programm.MainWindow.Frames.ModulationSettings = uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 55]));
    
uicontrol(Programm.MainWindow.Frames.ModulationSettings, ..
    "style", "text", ..
    "string", "Время моделирования:", ..
    "position", [5 5 125 20]);
    
Programm.MainWindow.Texts.ModulationTime = uicontrol(Programm.MainWindow.Frames.ModulationSettings, ..
    "style", "edit", ..
    "string", "10", ..
    "position", [130 5 155 20]);

//-------- Шаг моделирования --------//
    
uicontrol(Programm.MainWindow.Frames.ModulationSettings, ..
    "style", "text", ..
    "string", "Шаг моделирования:", ..
    "position", [5 30 125 20]);
    
Programm.MainWindow.Texts.ModulationStep = uicontrol(Programm.MainWindow.Frames.ModulationSettings, ..
    "style", "edit", ..
    "string", "0.1", ..
    "position", [130 30 155 20]);

//-------- Растягивающийся frame--------//

uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 7 1 1], [1 0], "both", "center", [-1 -1], [0 50]));
    
//-------- Пуск --------//

Programm.MainWindow.Frames.StartSimulation = uicontrol(Programm.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 8 1 1], [1 0], "horizontal", "lower", [0 0], [0 25]));

Programm.MainWindow.Buttons.Start = uicontrol(Programm.MainWindow.Frames.StartSimulation, ..
    "style", "pushbutton", ..
    "string", "Пуск", ..
    ..//"callback", "StartSimulation", ..
    "callback", "exec(Programm.Path + ""Scripts\StartSimulation.sce"")", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"));

// -------------------------------------------------------------------------
// Right Frame 
// -------------------------------------------------------------------------

// Разделение рабочей области   
Programm.MainWindow.Frames.RightFrame = uicontrol(Programm.MainWindow.Window, ..
"layout", "gridbag", ..
"style", "frame", ..
"margin", [5 5 5 5], ..
"constraints", createConstraints("gridbag", [2 1 1 1], [1 1], "both"));
    
Programm.MainWindow.Frames.NoDataFrame = uicontrol(Programm.MainWindow.Frames.RightFrame, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "margins", [5 5 5 5], ..
    "tag", "noDataFrame", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"));

Programm.MainWindow.Frames.PlotFrame = uicontrol(Programm.MainWindow.Frames.RightFrame, ..
    "style", "frame", ..
    "margins", [5 5 5 5], ..
    "visible", "off", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 1], "both"));

uicontrol(Programm.MainWindow.Frames.NoDataFrame, ..
    "style", "text", ..
    "string", "< Нет данных >", ..
    "ForeGroundColor", [.5 .5 .5]);

SetModulesList(Programm.MainWindow.Navigation.FullPaths(Programm.MainWindow.Navigation.CurrentIndex));

RefreshInputSignals();
RefreshObjects();

Programm.MainWindow.Window.visible = "on";