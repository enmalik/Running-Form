% dataFileDirectory = 'data';
runNumber = 'nahiyan2';
% dataFileRunDirectory = strcat(dataFileDirectory,runNumber);

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\static-arm-movement\filter\',runNumber,'-staticarm-flat-linacc.txt'));
fileDataStaticarmFlatAcc = textscan(fid, '%f;%f;%f;%f;');
fclose(fid);

dataStaticarmFlatTime = cat(1,fileDataStaticarmFlatAcc{1});

dataStaticarmFlatXacc =  cat(1,fileDataStaticarmFlatAcc{2});
dataStaticarmFlatYacc = cat(1,fileDataStaticarmFlatAcc{3});
dataStaticarmFlatZacc = cat(1,fileDataStaticarmFlatAcc{4});

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\static-arm-movement\filter\',runNumber,'-staticarm-flat-orientation.txt'));
% fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\nahiyan1\static-arm-movement\filter\nahiyan1-staticarm-flat-orientation.txt'));
fileDataStaticarmFlatOrientation = textscan(fid, '%f;%f;%f;%f;');
fclose(fid);

dataStaticarmFlatAzimuth = cat(1,fileDataStaticarmFlatOrientation{2});
dataStaticarmFlatPitch = cat(1,fileDataStaticarmFlatOrientation{3});
dataStaticarmFlatRoll = cat(1,fileDataStaticarmFlatOrientation{4});

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\static-arm-movement\filter\',runNumber,'-staticarm-toe-linacc.txt'));
% fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\nahiyan1\static-arm-movement\filter\nahiyan1-staticarm-toe-linacc.txt'));
fileDataStaticarmToeAcc = textscan(fid, '%f;%f;%f;%f;');
fclose(fid);

dataStaticarmToeTime = cat(1,fileDataStaticarmToeAcc{1});

dataStaticarmToeXacc = cat(1,fileDataStaticarmToeAcc{2});
dataStaticarmToeYacc = cat(1,fileDataStaticarmToeAcc{3});
dataStaticarmToeYacc = cat(1,fileDataStaticarmToeAcc{4});

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\static-arm-movement\filter\',runNumber,'-staticarm-toe-orientation.txt'));
% fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\nahiyan1\static-arm-movement\filter\nahiyan1-staticarm-toe-orientation.txt'));
fileDataStaticarmToeOrientation = textscan(fid, '%f;%f;%f;%f;');
fclose(fid);

dataStaticarmToeAzimuth = cat(1,fileDataStaticarmToeOrientation{2});
dataStaticarmToePitch = cat(1,fileDataStaticarmToeOrientation{3});
dataStaticarmToeRoll = cat(1,fileDataStaticarmToeOrientation{4});


smoothingSpan = 0.06;
smoothType = 'loess';

[staticarmFlatRollMaximaIndexes, staticarmFlatRollMaxima, staticarmFlatRollMinimaIndexes, staticarmFlatRollMinima, staticarmFlatRollSmoothData] = staticArmOrientationMaximaMinima(dataStaticarmFlatRoll,smoothingSpan,smoothType);

display(staticarmFlatRollMinimaIndexes);
display(staticarmFlatRollMinima);
display(staticarmFlatRollMaximaIndexes);
display(staticarmFlatRollMaxima);

[staticarmToeRollMaximaIndexes, staticarmToeRollMaxima, staticarmToeRollMinimaIndexes, staticarmToeRollMinima, staticarmToeRollSmoothData] = staticArmOrientationMaximaMinima(dataStaticarmToeRoll,smoothingSpan,smoothType);

display(staticarmToeRollMinimaIndexes);
display(staticarmToeRollMinima);
display(staticarmToeRollMaximaIndexes);
display(staticarmToeRollMaxima);

% plot(dataStaticarmToeTime, dataStaticarmToeRoll, '-b');
% hold on;
% plot(dataStaticarmToeTime, staticarmToeRollSmoothData, '-b');
% hold on;
% plot(dataStaticarmFlatTime, dataStaticarmFlatRoll, '-b');
% hold on;
% plot(dataStaticarmFlatTime, staticarmFlatRollSmoothData, '-r');

meanMinimaStaticarmToeRoll = mean(staticarmToeRollMinima);
meanMaximaStaticarmToeRoll = mean(staticarmToeRollMaxima);
meanMinimaStaticarmFlatRoll = mean(staticarmFlatRollMinima);
meanMaximaStaticarmFlatRoll = mean(staticarmFlatRollMaxima);

display(meanMinimaStaticarmToeRoll);
display(meanMinimaStaticarmFlatRoll);
display(meanMaximaStaticarmToeRoll);
display(meanMaximaStaticarmFlatRoll);


% load in run orientation data

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\normal-midfoot\filter\',runNumber,'-normal-midfoot-orientation.txt'));
fileDataMidfootRunOrientation = textscan(fid, '%f;%f;%f;%f;');
fclose(fid);

display(fileDataMidfootRunOrientation);

dataMidfootRunTime = cat(1,fileDataMidfootRunOrientation{1});
dataMidfootRunAzimuth = cat(1,fileDataMidfootRunOrientation{2});
dataMidfootRunPitch = cat(1,fileDataMidfootRunOrientation{3});
dataMidfootRunRoll = cat(1,fileDataMidfootRunOrientation{4});

fid = fopen(strcat('C:\Users\NM\Documents\GitHub\Running-Form\data\',runNumber,'\normal-midfoot\filter\',runNumber,'-normal-midfoot-gps2.txt'));
display(fid);
fileDataMidfootRunGps = textscan(fid, '%f;%f;%f;%f;%f;%f;%f;%f;%f;');
fclose(fid);

% display(fileDataMidfootRunGps);

dataMidfootRunGpsTime = cat(1,fileDataMidfootRunGps{1});
dataMidfootRunGpsLon = cat(1,fileDataMidfootRunGps{2});
dataMidfootRunGpsLat = cat(1,fileDataMidfootRunGps{3});
dataMidfootRunGpsAltitude = cat(1,fileDataMidfootRunGps{4});
dataMidfootRunGpsAccuracy = cat(1,fileDataMidfootRunGps{5});
dataMidfootRunGpsSpeed = cat(1,fileDataMidfootRunGps{6}); % m/s


[midfootRunRollMaximaIndexes, midfootRunRollMaxima, midfootRunRollMinimaIndexes, midfootRunRollMinima, midfootRunRollSmoothData] = RunOrientationMaximaMinima(dataMidfootRunTimeRoll,smoothingSpan,smoothType);

% display(mean(midfootRunRollMinima));
% display(mean(midfootRunRollMaxima));

% plot(dataMidfootRunTime, dataMidfootRunRoll, '-b');
% hold on;
% plot(dataMidfootRunTime, midfootRunRollSmoothData, '-r');

% display(midfootRunSmoothData);
% display(staticarmToeRollMinima);
% display(dataMidfootRunTime(midfootRunRollMinimaIndexes));
% display(midfootRunRollMinima);

% interpolating speeds

display(dataMidfootRunGpsTime);
display(dataMidfootRunGpsSpeed);

timeInt = dataMidfootRunTime;
speedInt = interp1(dataMidfootRunGpsTime,dataMidfootRunGpsSpeed,timeInt);

timeSpeedInt = cat(2,timeInt,speedInt);

display(timeSpeedInt);

% deciding if right (1), wrong (0) or indecisive(if not moving/ <1.5m/s) (2)

midfootMinimaIndexEval = [];

% display(size(midfootRunRollMinimaIndexes,1));

speedThreshold = 1.5; % 1.5 m/s. if greater than, considered jogging/running for now. will research more later.
rollAnglePlusMinus = 0; % 2 degrees of +/- error for now.

for evalIndex = 1 : size(midfootRunRollMinimaIndexes,1)
	flag = 0;
	display(speedInt(midfootRunRollMinimaIndexes(evalIndex)));
	if ((midfootRunRollSmoothData(midfootRunRollMinimaIndexes(evalIndex)) + rollAnglePlusMinus) > meanMinimaStaticarmToeRoll && speedInt(midfootRunRollMinimaIndexes(evalIndex)) > speedThreshold) % if angle is greate than stattic mean and speed is greater than threshold, right
		flag = 1;
	elseif (speedInt(midfootRunRollMinimaIndexes(evalIndex)) < speedThreshold) % if speed is less than speed threshold, indecisive
		flag = 2;
	elseif ((midfootRunRollSmoothData(midfootRunRollMinimaIndexes(evalIndex)) + rollAnglePlusMinus) < meanMinimaStaticarmToeRoll && speedInt(midfootRunRollMinimaIndexes(evalIndex)) > speedThreshold) % if angle is less than static mean and speed is greater than speed threshold, wrong
		flag = 0;
	else
		flag = 100;
	end
	midfootMinimaIndexEval = [midfootMinimaIndexEval;flag];
end

display(midfootMinimaIndexEval);

for evalPlotIndex = 1 : size(midfootRunRollMinimaIndexes,1)-1
	hold on;
	if (midfootMinimaIndexEval(evalPlotIndex) == 1)
		% display('IN');
		plot(dataMidfootRunTime(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), midfootRunRollSmoothData(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), '-g');
	elseif (midfootMinimaIndexEval(evalPlotIndex) == 0)
		% display('IN');
		plot(dataMidfootRunTime(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), midfootRunRollSmoothData(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), '-r');
	elseif (midfootMinimaIndexEval(evalPlotIndex) == 2)
		% display('IN');
		plot(dataMidfootRunTime(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), midfootRunRollSmoothData(midfootRunRollMinimaIndexes(evalPlotIndex):midfootRunRollMinimaIndexes(evalPlotIndex+1)), '-b');
	end
end










%------------------------

% display(size(dataStaticarmFlatRoll));

% smoothRloessDataStaticarmFlatRoll = smooth(dataStaticarmFlatRoll,0.05,'rloess');
% using loess smoothing
% smoothDataStaticarmFlatRoll = smooth(dataStaticarmFlatRoll, smoothingSpan,'loess');
% % display(size(smoothRloessDataStaticarmFlatRoll));
% display(size(smoothDataStaticarmFlatRoll));

% plot(dataStaticarmFlatTime, dataStaticarmFlatRoll, '-b');
% hold on;
% % plot(dataStaticarmFlatTime, smoothDataStaticarmFlatRoll, 'g');
% % hold on;
% plot(dataStaticarmFlatTime, smoothDataStaticarmFlatRoll, '-r');
% hold on;

% % finding the local maxima and indexes
% [FlatRollMaxima, FlatRollMaximaIndexes] = findpeaks(smoothDataStaticarmFlatRoll);
% display(FlatRollMaximaIndexes);
% display(FlatRollMaxima);

% finding the local maxima and indexes
% [FlatRollMinimaIgnore, FlatRollMinimaIndexes] = findpeaks(-1*smoothDataStaticarmFlatRoll);
% display(FlatRollMinimaIndexes);
% flatRollMinima = [];

% display(size(FlatRollMinimaIndexes,2));

% display(FlatRollMinimaIndexes);

% for minimaIndex = 1 : size(FlatRollMinimaIndexes,2)
% 	flatRollMinima = [flatRollMinima;smoothDataStaticarmFlatRoll(FlatRollMinimaIndexes(1,minimaIndex))];
% end

% display(flatRollMinima);

% display(transpose(FlatRollMinimaIndexes));

% fullMinimaData = cat(2,FlatRollMinimaIndexes',flatRollMinima);
% display(fullMinimaData);

% display(class(fullMinimaData));

%-----------------

% display(size(dataStaticarmToeRoll));

% % smoothRloessDataStaticarmToeRoll = smooth(dataStaticarmToeRoll,0.05,'rloess');
% % using loess smoothing
% smoothDataStaticarmToeRoll = smooth(dataStaticarmToeRoll, smoothingSpan,'loess');
% % display(size(smoothRloessDataStaticarmToeRoll));
% display(size(smoothDataStaticarmToeRoll));

% plot(dataStaticarmToeTime, dataStaticarmToeRoll, '-b');
% hold on;
% % plot(dataStaticarmToeTime, smoothDataStaticarmToeRoll, 'g');
% % hold on;
% plot(dataStaticarmToeTime, smoothDataStaticarmToeRoll, '-r');





% % finding the local minima and indexes
% [toeRollMinima, toeRollMinimaIndexes] = findpeaks(dataStaticarmToeRoll);
% display(toeRollMinimaIndexes);

% % finding the local maxima and indexes
% [toeRollMaximaIgnore, toeRollMaximaIndexes] = findpeaks(-1*dataStaticarmToeRoll);
% display(toeRollMaximaIndexes);
% toeRollMaxima = [];

% display(size(toeRollMaximaIndexes,2));

% display(toeRollMaximaIndexes);

% for maximaIndex = 1 : size(toeRollMaximaIndexes,2)
% 	toeRollMaxima = [toeRollMaxima;dataStaticarmToeRoll(toeRollMaximaIndexes(1,maximaIndex))];
% end

% display(toeRollMaxima);

% scatter(toeRollMaximaIndexes,toeRollMaxima);

% % plot(dataStaticarmTime, dataStaticarmToeXorientation);