
global Variables

function HomePage()    
    set(Variables.Help.next, "user_data", Variables.Help.lb.user_data)
    set(Variables.Help.lb, "string", Variables.Help.root)
    set(Variables.Help.lb, "user_data", "root")
endfunction
  
function NextPage()
    if Variables.Help.next.user_data == "programm" then
        set(Variables.Help.lb, "string", Variables.Help.programm)
        set(Variables.Help.lb, "user_data", "programm")
    end

    if Variables.Help.next.user_data == "theory" then
        set(Variables.Help.lb, "string", Variables.Help.theory)
        set(Variables.Help.lb, "user_data", "theory")
    end
endfunction

function changeNavigation()
    if Variables.Help.lb.user_data == "root" then
        if Variables.Help.lb.Value == 1 then
            set(Variables.Help.lb, "string", Variables.Help.programm)
            set(Variables.Help.lb, "user_data", "programm")
        end

        if Variables.Help.lb.Value == 2 then
            set(Variables.Help.lb, "string", Variables.Help.theory)
            set(Variables.Help.lb, "user_data", "theory")
        end
    else
        if Variables.Help.lb.value == 1 then 
            set(Variables.Help.lb, "string", Variables.Help.root)
            set(Variables.Help.lb, "user_data", "root")
        else
            child = Variables.Help.help_frame.Children
            close(child)
            
            if Variables.Help.lb.user_data == "programm"
                if Variables.Help.lb.value == 2 then
                    HowToUseProgramm(Variables.Help.help_frame)
                end
                
                if Variables.Help.lb.value == 3 then
                    HowToSaveResults(Variables.Help.help_frame)
                end
                
                if Variables.Help.lb.value == 4 then
                    HowToOpenXCos(Variables.Help.help_frame)
                end
            end
        end
    end
endfunction
