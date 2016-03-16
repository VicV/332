close all;
size = 100;
sandGrid = zeros(size,size);
maxIteration = 20000;
criticalHeight = 4;
q=zeros(maxIteration,1);

for i=1:maxIteration
    %Pick a random index. 
    location = randi(size*size,1);
    %Increase by one.
    sandGrid(location)=sandGrid(location)+1;
    %Find all indices >=4 now
    [rows,cols]=find(sandGrid>=criticalHeight);
    while (~isempty(rows))
        %Increase Q
        q(i)=q(i)+length(rows);
        for j=1:length(rows)
           row = rows(j);
           col = cols(j);
           sandGrid(row,col) = sandGrid(row,col)-4;
           if(col+1<=size)
            sandGrid(row,col+1)=sandGrid(row,col+1)+1;
           end
           if(col-1>=1)
           sandGrid(row,col-1)=sandGrid(row,col-1)+1;
           end
           if(row+1<=size)
           sandGrid(row+1,col)=sandGrid(row+1,col)+1;
           end
           if(row-1>=1)
           sandGrid(row-1,col)=sandGrid(row-1,col)+1;
           end
        end    
         %Find everything >= critical after this. 
         [rows,cols]=find(sandGrid>=criticalHeight);
    end
    
end

figure
plot(1:1:i,q)
xlabel('Iteration');
ylabel('Number of Pixels Reached Max Value');
title('Number of Pixels which Reached Max Value per Iteration');

%Calculations for log-log
tabulation = tabulate(q);
frequency = tabulation(:,1:2);

figure
loglog(frequency(:,1),frequency(:,2))
xlabel('log(q)');
ylabel('log(frequency(q))');
title('Log-Log Plot of Frequency of q Values ');
grid on