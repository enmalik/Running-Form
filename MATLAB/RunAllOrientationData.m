function [ dataRunTime, dataRunRoll, runRollMaximaIndexes, runRollMaxima, runRollMinimaIndexes, runRollMinima, runRollSmoothData, timeInt, speedInt ] = RunAllOrientationData( number, form, speedThreshold, smoothingSpanRun, smoothType )

% display(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',number,'\normal-',form,'\full\',number,'-normal-',form,'-orientation.txt'));
fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',number,'\normal-',form,'\full\',number,'-normal-',form,'-orientation.txt'));
fileDataRunOrientation = textscan(fid, '%f;%f;%f;%f;');
display(fileDataRunOrientation);
fclose(fid);

display(fileDataRunOrientation);

dataRunTime = cat(1,fileDataRunOrientation{1});
dataRunAzimuth = cat(1,fileDataRunOrientation{2});
dataRunPitch = cat(1,fileDataRunOrientation{3});
dataRunRoll = cat(1,fileDataRunOrientation{4});

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',number,'\normal-',form,'\full\',number,'-normal-',form,'-gps.txt'));
display(fid);
fileDataRunGps = textscan(fid, '%f;%f;%f;%f;%f;%f;%f;%f;%f;');
fclose(fid);

% display(fileDataMidfootRunGps);

dataRunGpsTime = cat(1,fileDataRunGps{1});
dataRunGpsLon = cat(1,fileDataRunGps{2});
dataRunGpsLat = cat(1,fileDataRunGps{3});
dataRunGpsAltitude = cat(1,fileDataRunGps{4});
dataRunGpsAccuracy = cat(1,fileDataRunGps{5});
dataRunGpsSpeed = cat(1,fileDataRunGps{6}); % m/s

timeInt = dataRunTime;

% display(dataMidfootRunGpsTime);
% display(dataMidfootRunGpsSpeed);

speedInt = interp1(dataRunGpsTime,dataRunGpsSpeed,timeInt);
speedInt(isnan(speedInt)) = 0;

timeSpeedInt = cat(2,timeInt,speedInt);


display(timeSpeedInt(1:700,:));

[runRollMaximaIndexes, runRollMaxima, runRollMinimaIndexes, runRollMinima, runRollSmoothData] = RunOrientationMaximaMinima(dataRunRoll,speedInt,speedThreshold,smoothingSpanRun,smoothType);

end