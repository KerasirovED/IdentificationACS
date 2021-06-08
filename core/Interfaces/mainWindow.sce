
global IdentificationACS;

// Основное окно программы
IdentificationACS.MainWindow.Window = figure(..
    "figure_id", 228, ..
    "figure_name", IdentificationACS.ProgramName + " (version: " + IdentificationACS.Version + ")", ..
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
m = uimenu(IdentificationACS.MainWindow.Window, "label", "Файл");
uimenu(m, "label", "Закрыть", "callback", "CloseProgramm", "icon", "close-tab");
m = uimenu(IdentificationACS.MainWindow.Window, "label", "График");
uimenu(m, "label", "Сохранить как изображение", "callback", "SavePlotIntoImage", "icon", "media-floppy");
m = uimenu(IdentificationACS.MainWindow.Window, "label", "Справка");
uimenu(m, "label", "Справка", "callback", "exec(IdentificationACS.Path + ""Interfaces\Help.sce"")", "icon", "help-browser");
uimenu(m, "label", "О программе", "callback", "AboutUs", "icon", "dialog-information");

clear m;

// -------------------------------------------------------------------------
// Left Frame 
// -------------------------------------------------------------------------

IdentificationACS.MainWindow.Frames.Left = [];
IdentificationACS.MainWindow.Frames.Left = uicontrol(IdentificationACS.MainWindow.Window, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "margin", [5 5 5 0], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [-1 1], "vertical", "center", [-1 -1], [343 1]));

// -------- Входной сигнал -------- //

IdentificationACS.MainWindow.Frames.Signal = uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper", [0 0], [0 75]));

uicontrol(IdentificationACS.MainWindow.Frames.Signal, ..
    "style", "text", ..
    "string", "Входной сигнал:", ..
    "margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"));
    
IdentificationACS.MainWindow.Frames.SignalParametres = uicontrol(IdentificationACS.MainWindow.Frames.Signal, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 45]));
    
IdentificationACS.MainWindow.Popmenus.InputSignals = [];
IdentificationACS.MainWindow.Popmenus.InputSignals = uicontrol(IdentificationACS.MainWindow.Frames.SignalParametres, ..
    "style", "popupmenu", ..
    "string", IdentificationACS.Modules.InputSignals.List, ..
    "callback", "AddModule(IdentificationACS.MainWindow.Popmenus.InputSignals, IdentificationACS.Modules.InputSignals.Path, RefreshInputSignals)", ..
    "position", [5 25 253 20]);
        
IdentificationACS.MainWindow.Buttons.OpenInput = [];
IdentificationACS.MainWindow.Buttons.OpenInput = uicontrol(IdentificationACS.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "OpenModule(IdentificationACS.Modules.InputSignals.Path, IdentificationACS.MainWindow.Popmenus.InputSignals.String(IdentificationACS.MainWindow.Popmenus.InputSignals.Value))", ..
    "icon", IdentificationACS.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 24 22 22]);

IdentificationACS.MainWindow.Buttons.RenameInput = uicontrol(IdentificationACS.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "RenameModule(IdentificationACS.Modules.InputSignals.Path, IdentificationACS.MainWindow.Popmenus.InputSignals.String(IdentificationACS.MainWindow.Popmenus.InputSignals.Value), RefreshInputSignals)", ..
    "icon", IdentificationACS.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 24 22 22]);

IdentificationACS.MainWindow.Buttons.RemoveInput = uicontrol(IdentificationACS.MainWindow.Frames.SignalParametres, ..
    "style", "pushbutton", ..
    "callback", "RemoveModule(IdentificationACS.Modules.InputSignals.Path, IdentificationACS.MainWindow.Popmenus.InputSignals.String(IdentificationACS.MainWindow.Popmenus.InputSignals.Value), RefreshInputSignals)", ..
    "icon", IdentificationACS.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 24 22 22]);

IdentificationACS.MainWindow.Checkboxes.ShowSource = [];
IdentificationACS.MainWindow.Checkboxes.ShowSource = uicontrol(IdentificationACS.MainWindow.Frames.SignalParametres, ..
    "style", "checkbox", ..
    "string", "Выводить на график", ..
    "position", [2 0 253 20]);
    
uicontrol(IdentificationACS.MainWindow.Frames.Signal, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"));

//-------- Модель объекта --------//

IdentificationACS.MainWindow.Frames.ObjectModel = uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "horizontal", "upper", [0 0], [0 75]));

uicontrol(IdentificationACS.MainWindow.Frames.ObjectModel, ..
    "style", "text", ..
    "string", "Модель объекта:", ..
    "margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper"));
    
IdentificationACS.MainWindow.Frames.ObjectModelParametres = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModel, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 45]));
    
IdentificationACS.MainWindow.Popmenus.ObjectModel = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModelParametres, ..
    "style", "popupmenu", ..
    "string", IdentificationACS.Modules.Objects.List, ..
    "tag", "IdentificationACS.MainWindow.Popmenus.ObjectModel_tag", ..
    "callback", "AddModule(IdentificationACS.MainWindow.Popmenus.ObjectModel, IdentificationACS.Modules.Objects.Path, RefreshObjects)", ..
    "position", [5 25 253 20]);
        
IdentificationACS.MainWindow.Buttons.OpenObject = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..
    "callback", "OpenModule(IdentificationACS.Modules.Objects.Path, IdentificationACS.MainWindow.Popmenus.ObjectModel.String(IdentificationACS.MainWindow.Popmenus.ObjectModel.Value))", ..
    "icon", IdentificationACS.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 24 22 22]);

IdentificationACS.MainWindow.Buttons.RenameObject = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..    
    "callback", "RenameModule(IdentificationACS.Modules.Objects.Path, IdentificationACS.MainWindow.Popmenus.ObjectModel.String(IdentificationACS.MainWindow.Popmenus.ObjectModel.Value), RefreshObjects)", ..
    "icon", IdentificationACS.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 24 22 22]);

IdentificationACS.MainWindow.Buttons.RemoveObject = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModelParametres, ..
    "style", "pushbutton", ..    
    "callback", "RemoveModule(IdentificationACS.Modules.Objects.Path, IdentificationACS.MainWindow.Popmenus.ObjectModel.String(IdentificationACS.MainWindow.Popmenus.ObjectModel.Value), RefreshObjects)", ..
    "icon", IdentificationACS.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 24 22 22]);

IdentificationACS.MainWindow.Checkboxes.ShowObj = uicontrol(IdentificationACS.MainWindow.Frames.ObjectModelParametres, ..
    "style", "checkbox", ..
    "string", "Выводить на график", ..
    "position", [2 0 253 20]);
    
uicontrol(IdentificationACS.MainWindow.Frames.ObjectModel, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both", "center"));
    
//-------- Система идентификации --------//

IdentificationACS.MainWindow.Frames.SelectModule = uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 4 1 1], [1 1], "both"));

IdentificationACS.MainWindow.Frames.SelectedModule = uicontrol(IdentificationACS.MainWindow.Frames.SelectModule, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "both", "center", [0 0], [0 25]));

uicontrol(IdentificationACS.MainWindow.Frames.SelectedModule, ..
    "style", "text", ..
    "string", "Выбран модуль:", ..
    "position", [5 0 85 20]);

IdentificationACS.MainWindow.Texts.ModuleName = [];
IdentificationACS.MainWindow.Texts.ModuleName = uicontrol(IdentificationACS.MainWindow.Frames.SelectedModule, ..
    "style", "text", ..
    "string", IdentificationACS.MainWindow.SelectedModule.Name, ..
    "position", [95 0 165 20]);

IdentificationACS.MainWindow.Buttons.ObjectModel = uicontrol(IdentificationACS.MainWindow.Frames.SelectedModule, ..
    "callback", "OpenModule(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex), IdentificationACS.MainWindow.SelectedModule.Name)", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\open-file.png", ..
    "TooltipString", "Открыть", ..
    "position", [260 -1 22 22]);

IdentificationACS.MainWindow.Buttons.RenameModule = uicontrol(IdentificationACS.MainWindow.Frames.SelectedModule, ..
    "callback", "mwn_renameModule", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\edit-file.png", ..
    "TooltipString", "Переименовать", ..
    "position", [283 -1 22 22]);

IdentificationACS.MainWindow.Buttons.RemoveModule = uicontrol(IdentificationACS.MainWindow.Frames.SelectedModule, ..
    "callback", "mwn_removeModule", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\remove-file.png", ..
    "TooltipString", "Удалить", ..
    "position", [306 -1 22 22]);

IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons = uicontrol(IdentificationACS.MainWindow.Frames.SelectModule, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "both", "center", [0 0], [0 60]));
    
IdentificationACS.MainWindow.Buttons.Backward = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_b", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\backward.png", ..
    "position", [5 25 30 30]);

IdentificationACS.MainWindow.Buttons.Forward = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_f", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\forward.png", ..
    "position", [38 25 30 30]);
    
IdentificationACS.MainWindow.Buttons.Home = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "callback", "mwn_h", ..
    "enable", "off", ..
    "icon", IdentificationACS.Path + "images\home-folder.png", ..
    "position", [71 25 30 30]);

IdentificationACS.MainWindow.Buttons.RemoveFolder = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", IdentificationACS.Path + "images\remove-folder.png", ..
    "callback", "mwn_rmvFldr", ..
    "TooltipString", "Удалить текущую папку", ..
    "enable", "off", ..
    "position", [232 25 30 30]);

IdentificationACS.MainWindow.Buttons.AddFolder = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", IdentificationACS.Path + "images\add-folder.png", ..
    "callback", "mwn_crtFldr", ..
    "TooltipString", "Создать папку", ..
    "position", [265 25 30 30]);

IdentificationACS.MainWindow.Buttons.AddNewModule = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "icon", IdentificationACS.Path + "images\add-file.png", ..
    "callback", "mwn_addModule", ..
    "TooltipString", "Добавить модуль", ..
    "position", [298 25 30 30]);

IdentificationACS.MainWindow.Texts.CurrentPath = uicontrol(IdentificationACS.MainWindow.Frames.SelectModuleNavigationButtons, ..
    "style", "text", ..
    "position", [5 0 277 20]);

IdentificationACS.MainWindow.Listboxes.SelectModuleListbox = [];
IdentificationACS.MainWindow.Listboxes.SelectModuleListbox = uicontrol(IdentificationACS.MainWindow.Frames.SelectModule, ..
    "style", "listbox", ..
    "Margins", [0 5 5 5], ..
    "callback", "mwn_o(IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String(IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.Value + size(IdentificationACS.MainWindow.Listboxes.SelectModuleListbox.String, ""r"")))", ..
    "constraints", createConstraints("gridbag", [1 3 1 1], [1 1], "both"));

//-------- Время моделирования --------//
    
IdentificationACS.MainWindow.Frames.ModulationSettings = uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "margins", [5 5 0 5], ..
    "border", createBorder("line", "gray", 1), ..
    "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 55]));
    
uicontrol(IdentificationACS.MainWindow.Frames.ModulationSettings, ..
    "style", "text", ..
    "string", "Время моделирования:", ..
    "position", [5 5 125 20]);
    
IdentificationACS.MainWindow.Texts.ModulationTime = uicontrol(IdentificationACS.MainWindow.Frames.ModulationSettings, ..
    "style", "edit", ..
    "string", "10", ..
    "position", [130 5 196 20]);

//-------- Шаг моделирования --------//
    
uicontrol(IdentificationACS.MainWindow.Frames.ModulationSettings, ..
    "style", "text", ..
    "string", "Шаг моделирования:", ..
    "position", [5 30 125 20]);
    
IdentificationACS.MainWindow.Texts.ModulationStep = uicontrol(IdentificationACS.MainWindow.Frames.ModulationSettings, ..
    "style", "edit", ..
    "string", "0.1", ..
    "position", [130 30 196 20]);

//-------- Растягивающийся frame--------//

uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "constraints", createConstraints("gridbag", [1 7 1 1], [1 0], "both", "center", [-1 -1], [0 50]));
    
//-------- Пуск --------//

IdentificationACS.MainWindow.Frames.StartSimulation = uicontrol(IdentificationACS.MainWindow.Frames.Left, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "Margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 8 1 1], [1 0], "horizontal", "lower", [0 0], [0 25]));

IdentificationACS.MainWindow.Buttons.Start = uicontrol(IdentificationACS.MainWindow.Frames.StartSimulation, ..
    "style", "pushbutton", ..
    "string", "Запуск моделирования", ..
    "callback", "exec(IdentificationACS.Path + ""Scripts\StartSimulation.sce"")", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"));

// -------------------------------------------------------------------------
// Right Frame 
// -------------------------------------------------------------------------

// Разделение рабочей области   
IdentificationACS.MainWindow.Frames.RightFrame = uicontrol(IdentificationACS.MainWindow.Window, ..
"layout", "gridbag", ..
"style", "frame", ..
"margin", [5 5 5 5], ..
"constraints", createConstraints("gridbag", [2 1 1 1], [1 1], "both"));
    
IdentificationACS.MainWindow.Frames.NoDataFrame = uicontrol(IdentificationACS.MainWindow.Frames.RightFrame, ..
    "style", "frame", ..
    "layout", "gridbag", ..
    "margins", [5 5 5 5], ..
    "tag", "noDataFrame", ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"));

IdentificationACS.MainWindow.Frames.PlotFrame = uicontrol(IdentificationACS.MainWindow.Frames.RightFrame, ..
    "style", "frame", ..
    "margins", [5 5 5 5], ..
    "visible", "off", ..
    "constraints", createConstraints("gridbag", [1 2 1 1], [1 1], "both"));

uicontrol(IdentificationACS.MainWindow.Frames.NoDataFrame, ..
    "style", "text", ..
    "string", "< Нет данных >", ..
    "ForeGroundColor", [.5 .5 .5]);

SetModulesList(IdentificationACS.MainWindow.Navigation.FullPaths(IdentificationACS.MainWindow.Navigation.CurrentIndex));

RefreshInputSignals();
RefreshObjects();

IdentificationACS.MainWindow.Window.visible = "on";