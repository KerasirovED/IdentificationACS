function ShowLastError(input)
    [error_message,error_number, line, func]=lasterror(%f);
    
    messagebox(["Error " + string(error_number); error_message;
        "at line " + string(line) + " of function " + func], "Error!", "error", "modal");
endfunction