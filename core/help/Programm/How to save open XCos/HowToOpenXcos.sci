function HowToOpenXCos(frame)
            
    main = uicontrol(frame, ..
        "style", "frame", ..
        "layout", "gridbag", ..
        "Scrollable", "on", ..
        "constraints", createConstraints("gridbag", [1 1 1 1], [1 1], "both"))
    
   uicontrol(main, ..
        "style", "frame", ..
        "backgroundcolor", [0.5 0.5 0.5], ..
        "margin", [40 10 0 10], ..
        "constraints", createConstraints("gridbag", [1 1 1 1], [1 0], "horizontal", "upper", [0 0], [0 2]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "Как посмотреть блок-схему фильтра?", ..
        "fontSize", 15, ..
        "fontWeight", "bold", ..
        "margin", [0 10 0 10], ..
        "constraints", createConstraints("gridbag", [1 2 1 1], [1 0], "horizontal", "upper", [0 0], [0 50]))
    
   uicontrol(main, ..
        "style", "frame", ..
        "backgroundcolor", [0.5 0.5 0.5], ..
        "margin", [0 10 40 10], ..
        "constraints", createConstraints("gridbag", [1 3 1 1], [1 0], "horizontal", "upper", [0 0], [0 2]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "1. В верхнем выпадающем меню необходимо выбрать ""Блок-схема"" и выбрать необходимый порядок фильтра.", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 4 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to save open XCos\Images\1.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 5 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "После этого будет открыт графический редактор XCos c блок-схемой нужного фильтра.", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to save open XCos\Images\2.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 7 1 1], [1 0], "none", "center", [0 0], [500 255]))
     
    // Завершающий frame   
    uicontrol(main, ..
        "style", "frame", ..
        "constraints", createConstraints("gridbag", [1 20 1 1], [1 1], "horizontal", "center", [0 0], [0 40]))
        
endfunction
