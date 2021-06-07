function HowToSaveResults(frame)
            
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
        "string", "Как сохранить результаты моделирования?", ..
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
        "string", "1. В верхнем выпадающем меню необходимо выбрать ""График"" -> ""Сохранить результаты как изображение"".", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 4 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to save results\Images\1.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 5 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "2. Выбрать каталог, куда необходимо сохранить результаты моделирования.", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to save results\Images\2.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 7 1 1], [1 0], "none", "center", [0 0], [500 255]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "3. Не забыть указать желаемый формат изображения", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 8 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to save results\Images\3.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 9 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "В результате файл будет сохранен в указанную вами директорию с указанным расширением.", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 10 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
     
    // Завершающий frame   
    uicontrol(main, ..
        "style", "frame", ..
        "constraints", createConstraints("gridbag", [1 20 1 1], [1 1], "horizontal", "center", [0 0], [0 40]))
        
endfunction
