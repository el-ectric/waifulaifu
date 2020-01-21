%{
% Create image
image = 0.5*ones(100,100);
imshow(image)
%}

% load image
image = imread("damaged.png");
image = mean(image,3);
image = image./max(image);

% Loop Forever
randomMatrix = image;
while true
    %create random
    for row = 1:100
        for column = 1:100
            randomMatrix(row,column) = normrnd(0,1);
        end
    end
    
    % normalize vector 
    size = sum(randomMatrix.^2,'all').^0.5;
    randomMatrix = 10*randomMatrix./size;
    
    
    % Plot old vs new
    subplot(1,2,1);
    imshow(image);
    subplot(1,2,2);
    imshow(image+randomMatrix)
    
    in = input("1 or 2");
    
    if in == 1
        image = image;
    end
    if in == 2
        image = image + randomMatrix;
    end
    
    image(image>1) = 1;
    image(image<0) = 0;
end