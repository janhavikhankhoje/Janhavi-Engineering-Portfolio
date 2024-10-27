function [SC,SA,minRB,maxRB] = resistanceBounds()
    [minRA,maxRA] = ambientBounds();
    R1 = 6100;
    [minSA] = SAfromR(minRA,R1);
    [maxSA] = SAfromR(maxRA,R1);
    maxRB = 6985; % TB is set to 35 C - 45 C for simplicity
    [minRB] = 4090; 
    [maxSC] = SCfromRB(minSA,maxRB);
    [minSC] = SCfromRB(maxSA,minRB);
    SA = minSA:1:maxSA;
    SC = minSC:1:maxSC;
    
    function [SA] = SAfromR(RA,R1)
        SA = floor( ((5*RA)/(R1+RA))*(1023/5) );
    end
    function [SC] = SCfromRB(SA,RB)
        SC = floor( 1023/ (((6100*SA)/ (RB*(1023-SA)) )+1) );
    end
end
%% function to input ambient temperature bounds
% Have to be a multiple of 5
function [minRA,maxRA] = ambientBounds()
    datasheet = readmatrix("datasheet.txt");
    minTA = input("minimum ambient temp: ");
    maxTA = input("maximum ambient temp: ");
    
    minRow = find(minTA == datasheet(:,1)); 
    maxRow = find(maxTA == datasheet(:,1));

    maxRA = datasheet(minRow,4);
    minRA = datasheet(maxRow,3);
end