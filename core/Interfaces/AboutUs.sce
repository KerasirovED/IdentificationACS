
f = figure( ...
    "dockable"        , "off",...
    "infobar_visible" , "off",...
    "toolbar"         , "none",...
    "default_axes"    , "off",...
    "visible"         , "off", ...
   "figure_position", [150 100], ...
    "menubar" ,         "none",...
    "resize", "off", ..
    "backgroundcolor", [0.94 0.94 0.94], ..
    "figure_size", [539, 225])

uicontrol(f, ..
    "style", "text", ..
    "string", "Программный комплекс идентификации", ..
    "fontSize", 15, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "HorizontalAlignment", "center", ..
    "position", [0 152 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "динамических систем управления", ..
    "fontSize", 15, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "HorizontalAlignment", "center", ..
    "position", [0 135 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "Руководитель: Шалобанов С. В.", ..
    "fontSize", 10, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "position", [10 90 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "Разработчики: Керасиров Е. Д.", ..
    "fontSize", 10, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "position", [10 75 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "Чаплыгина А. Д.", ..
    "fontSize", 10, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "position", [94 60 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "Pacific National University", ..
    "fontSize", 10, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "HorizontalAlignment", "center", ..
    "position", [5 15 400 20])

uicontrol(f, ..
    "style", "text", ..
    "string", "г. Хабаровск — 2020 г.", ..
    "fontSize", 10, ..
    "fontWeight", "light", ..
    "FontName", "Consolas", ..
    "margins", [5 5 5 5], ..
    "HorizontalAlignment", "center", ..
    "position", [5 0 400 20])

uicontrol(f, ..
    "style", "image", ..
    "string", programmPath + "images\grumpy-cat-mona-lisa-tony-rubino.jpg", ..
    "position", [391 3 160 210])

f.visible = "on"

