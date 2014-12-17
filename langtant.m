function langtant
N = 1000;
steps = 50800;
% random initial board
board = ceil(sprand(N,N,.001));
% starting coordinates
i = 500;
j = 500;
c = 0; % N, E, S, W
for t=1:steps 
    if board(i,j) == 0 
        % flip color
        board(i, j) = 1;        
        switch c
            case 0
                j = j + 1;
            case 1
                i = i + 1;
            case 2
                j = j - 1;
            case 3
                i = i - 1;             
        end
        % cycle direction clockwise; mod() keeps in base 4
        c = mod(c + 1,4);       
    elseif board(i, j) == 1
        % flip color
        board(i, j) = 0;
        switch c
            case 0
                j = j - 1;
            case 1
                i = i - 1;
            case 2
                j = j + 1;
            case 3
                i = i+ 1;    
        end
        % cycle direction counterclockwise; mod() keeps in base 4
        c = mod(c - 1,4);  
    end
    %wrap-around boundary conditions
    if j >= N + 1
        j = 1;
    end
    if j <= 0
        j = N;
    end
    if i >= N + 1
        i = 1;
    end
    if i <= 0
        i = N;
    end
end
spy(board);

