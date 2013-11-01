function [ dataLinaccX, dataLinaccY, dataLinaccZ ] = RunLinacc( number, form, runTime, runRollMaximaIndexes, runRollMaxima, runRollMinimaIndexes, runRollMinima )

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',number,'\normal-',form,'\full\',number,'-normal-',form,'-linacc.txt'));
fileDataRunOrientation = textscan(fid, '%f;%f;%f;%f;');
display(fileDataRunOrientation);
fclose(fid);

dataLinaccX = cat(1,fileDataRunOrientation{2});
dataLinaccY = cat(1,fileDataRunOrientation{3});
dataLinaccZ = cat(1,fileDataRunOrientation{4});

end
