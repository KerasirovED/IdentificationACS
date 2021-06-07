function HowToUseProgramm(frame)
            
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
        "string", "Как запустить моделирование?", ..
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
        "string", "1. Выбрать тип фильтра", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 4 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\1.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 5 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "2. Ввести параметры фильтра", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 6 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\2.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 7 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "3. Выбрать передаточную функцию, эквивалентную объекту", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 8 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\3.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 9 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "4. Ввести коэффициенты передаточной функции", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 10 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\4.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 11 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "5. Указать время моделирования", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 12 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\5.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 13 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "6. Нажать кнопку ""Пуск!""", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 14 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\6.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "constraints", createConstraints("gridbag", [1 15 1 1], [1 0], "none", "center", [0 0], [500 300]))
    
    uicontrol(main, ..
        "style", "text", ..
        "string", "В результате вы получите графики идентификации коэффициентов", ..
        "margin", [10 10 10 10], ..
        "constraints", createConstraints("gridbag", [1 16 1 1], [1 0], "horizontal", "upper", [0 0], [0 20]))
    
    uicontrol(main, ..
        "style", "image", ..
        "string", programmPath + "help\Programm\How to use programm\Images\7.png", ..
        "margin", [0 10 10 10], ..
        "backgroundcolor", [1 0 0], ..
        "value", [0.5 0.5 0 0 0], ..
        "constraints", createConstraints("gridbag", [1 17 1 1], [1 0], "none", "center", [0 0], [500 300]))
     
    // Завершающий frame   
    uicontrol(main, ..
        "style", "frame", ..
        "constraints", createConstraints("gridbag", [1 20 1 1], [1 1], "horizontal", "center", [0 0], [0 40]))
        
endfunction
