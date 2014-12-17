function gameoflife(steps,ic)
%
%
% A simulation of Conway's Game of Life.
%
%
% steps: an integer number of generations for which to run the game
%
% ic: This function takes a double array as input. Import an image using
% imread(.), then use im2bw(.) and im2double(.) to convert to the 
% appropriate binary matrix. Note that if your image is anti-aliased
% or contains gradients, this will awkwardly binarize it and leave jagged
% edges
%
% example:
%
% I=imread('testgame2.png');
% I=im2bw(I);
% gameoflife(30, I)
%
%
%
% (c) William Gilpin 2012
% williamgilpin@gmail.com
%

boardt = ic;
imray = mat2gray(boardt); % initialize image array with IC

wid = size(ic, 2);
heg = size(ic, 1);


for t=1:steps
    
    %  the new board is the final configuration of the previous one
    board = boardt;
    
    for i=1:heg
        
        for j=1:wid
            
            
            % toroidal (wrap-around) boundary conditions. Remember that MATLAB
            % does not use zero indexing in arrays (unike Java)
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
            
            if board(i,j) == 1
                
                switch val
                    
                    case 2
                        boardt(i,j)=1;
                    case 3
                        boardt(i,j)=1;
                    otherwise
                        boardt(i,j)=0;
                        
                end
            end
            
            
            
            if board(i,j) == 0
                
                switch val
                    case 3
                        boardt(i,j)=1;
                    otherwise
                        boardt(i,j)=0;
                        
                end
            end
            
            
            
            
        end
    end
    
    imray = cat(3, imray,mat2gray(boardt));
    
end


% play simulation at (arg) frames per second
implay(imray,5)
