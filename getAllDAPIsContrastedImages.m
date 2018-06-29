function [ output_args ] = getAllDAPIsContrastedImages( my_struct, DAPIs20Threshold, DAPIs4Threshold )
    for i = 1:length(my_struct)
        if my_struct(i).isDAPI == 1 && my_struct(i).magnification == 4
            getContrastOfDAPIImage(my_struct(i).fullPath, DAPIs4Threshold);
        elseif my_struct(i).isDAPI == 1 && my_struct(i).magnification == 20
            getContrastOfDAPIImage(my_struct(i).fullPath, DAPIs20Threshold);
        end
        
    end
end

