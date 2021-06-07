global IdentificationACS;

IdentificationACS.Help.MainWindow = [];
IdentificationACS.Help.MainWindow = = figure( ...
    "dockable"        , "off",...
    "infobar_visible" , "off",...
    "toolbar"         , "none",...
    "default_axes"    , "off",...
    "visible"         , "off", ...
   "figure_position", [150 100], ...
    "menubar" ,         "none",...
    "resize", "off", ..
    "figure_name", "Справка", ..
    "figure_size", [918, 514]);

IdentificationACS.Help.Frames.LeftFrame = [];
IdentificationACS.Help.Frames.LeftFrame = uicontrol(IdentificationACS.Help.MainWindow, ...
    "layout", "gridbag", ...
    "style", "frame", ...
    "margin", [5 5 5 0], ...
    "position", [5 5 275 470]);

// Разделение рабочей области   
IdentificationACS.Help.HelpFrame = []    
IdentificationACS.Help.Frames.HelpFrame = uicontrol(IdentificationACS.Help.MainWindow, ...
    "layout", "gridbag", ...
    "style", "frame", ...
    "margin", [5 5 5 5], ...
    "position", [286 5 620 470]);
  
IdentificationACS.Help.root = [
    'folder', "Справка по программе", '#FFFFFF', "#000000";
    'folder', "Справка по теории", '#FFFFFF', "#000000";
];

IdentificationACS.Help.IdentificationACS = [
    'dynamic-blue-up', "Справка по программе", '#FFFFFF', "#000000";
    'text-x-generic', "Как запустить моделирование?", '#FFFFFF', "#000000";
    'text-x-generic', "Как сохранить результат моделирования?", '#FFFFFF', "#000000";
    'text-x-generic', "Как посмотреть блок-схему фильтра?", '#FFFFFF', "#000000";
];

IdentificationACS.Help.theory = [
    'dynamic-blue-up', "Справка по теории", '#FFFFFF', "#000000";
    'text-x-generic', "Метод вспомогательного оператора", '#FFFFFF', "#000000";
    'text-x-generic', "...", '#FFFFFF', "#000000";
    'text-x-generic', "...", '#FFFFFF', "#000000";
];
    
IdentificationACS.Help.lb = []
IdentificationACS.Help.lb = uicontrol(IdentificationACS.Help.Frames.LeftFrame, ..
    "style", "listbox", ..
    "string", IdentificationACS.Help.root, ..
    "callback", "ChangeNavigation", ..
    "margins", [5 5 5 5], ..
    "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"), ..
    "user_data", "root");

IdentificationACS.Help.MainWindow =.visible = "on";
    
//////////////////////////////////////////////////
/////////////////// Right Frame //////////////////
//////////////////////////////////////////////////


//root = struct("Name", "Root", "Parent", [], "Children", [], "Value", [])
//
//leaf1 = struct("Name", "leaf1", "Parent", [], "Children", [], "Value", [])
//leaf11 = struct("Name", "leaf11", "Parent", [], "Children", [], "Value", [])
//leaf12 = struct("Name", "leaf12", "Parent", [], "Children", [], "Value", [])
//leaf13 = struct("Name", "leaf13", "Parent", [], "Children", [], "Value", [])
//leaf1.Children = list(leaf11, leaf12, leaf13)
//
//for x = leaf1.Children()
//    x.Parent = leaf1
//end
//
//leaf2 = struct("Name", "leaf2", "Parent", root, "Children", [], "Value", [])
//leaf21 = struct("Name", "leaf21", "Parent", leaf2, "Children", [], "Value", [])
//leaf22 = struct("Name", "leaf22", "Parent", leaf2, "Children", [], "Value", [])
//leaf2.Children = list(leaf21, leaf22)
//
//for x = leaf2.Children()
//    x.Parent = leaf1
//end
//
//root.Children = list(leaf1, leaf2)
//
//for x = root.Children()
//    x.Parent = leaf1
//end
//
//Navigation = []
//Navigation.Tree = root
//Navigation.History = list(Navigation.Tree(1))
//Navigation.CurrentPage = 1
//
//
