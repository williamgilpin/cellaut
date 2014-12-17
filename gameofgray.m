function gameofgray(steps,ic)
%
% (c) William Gilpin 2012
%
% take a double matrix with values between 0 and 1 as input
% (rgb2gray, im2double on standard imread)
%
% the game of life shell works as a generica iterative image processing 
% framework, with the timestep controlling the number of iterations

boardt = ic;
imray = mat2gray(boardt); % initialize image array with IC

wid = size(ic, 2);
heg = size(ic, 1);


for t=1:steps
    
    %  the new board is the final configuration of the previous one
    board = boardt;
    
    for i=1:heg
        
        for j=1:wid
            
            
            % toroidal (wrap-around) boundary conditions. Remember that
            % MATLAB does not use zero indexing in arrays (unlike Java)
            %{
            if j == 1
                jown = wid;
            else
                jown = j - 1;
            end
            if j == wid
                jup = 1;
            else
                jup = j + 1;
            end
            
            
            
            if i == 1
                iown = heg;
            else
                iown = i - 1;
            end
            if i == heg
                iup = 1;
            else
                iup = i + 1;
            end
            %}
            
            
            % reflection boundary conditions.
            
            if j == 1
                jown = j;
            else
                jown = j - 1;
            end
            if j == wid
                jup = j;
            else
                jup = j + 1;
            end
            
            
            
            if i == 1
                iown = i;
            else
                iown = i - 1;
            end
            if i == heg
                iup = i;
            else
                iup = i + 1;
            end
            
            
            
            % compute total number of neighbors
            val = board(i,jup) + board(i,jown) + board(iup,j) ;
            val = val + board(iown,j) + board(iown,jup) + board(iown,jown);
            val = val + board(iup,jown) + board(iup,jup);
            
            
            boardt(i,j) = val/8;
            %{
            % life threshold parameter
            if board(i,j) > .25
                
                if val >= 2 && val <= 3
                    
                    % new cell becomes average
                    % brightness of those around it
                    boardt(i,j)= val/8;
                    
                elseif val < 2
                    boardt(i,j)=.1;
                    
                else
                    % otherwise cell dies
                    boardt(i,j)=val/8;
                    
                end
                
                
                
                
            else
                
                if val >= 3 && val < 4
                    
                    % new cell becomes average
                    % brightness of those around it
                    boardt(i,j)=val/8;
                else
                    % otherwise cell stays as it is
                    boardt(i,j)= board(i,j);
                end
            end
            %}
            
            
        end
    end
    
    % build an array of images concatenated along third dimension
    imray = cat(3, imray,mat2gray(boardt));
    
end


% play simulation at (arg) frames per second
implay(imray,2)
