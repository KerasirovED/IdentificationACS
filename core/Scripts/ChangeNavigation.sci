
global Programm

function ChangeNavigation()
    if Programm.Help.lb.user_data == "root" then
        if Programm.Help.lb.Value == 1 then
            set(Programm.Help.lb, "string", Programm.Help.programm)
            set(Programm.Help.lb, "user_data", "programm")
        end

        if Programm.Help.lb.Value == 2 then
            set(Programm.Help.lb, "string", Programm.Help.theory)
            set(Programm.Help.lb, "user_data", "theory")
        end
    else
        if Programm.Help.lb.value == 1 then 
            set(Programm.Help.lb, "string", Programm.Help.root)
            set(Programm.Help.lb, "user_data", "root")
        else
            child = Programm.Help.help_frame.Children
            close(child)
            
            if Programm.Help.lb.user_data == "programm"
                if Programm.Help.lb.value == 2 then
                    HowToUseProgramm(Programm.Help.help_frame)
                end
                
                if Programm.Help.lb.value == 3 then
                    HowToSaveResults(Programm.Help.help_frame)
                end
                
                if Programm.Help.lb.value == 4 then
                    HowToOpenXCos(Programm.Help.help_frame)
                end
            end
        end
    end
endfunction
