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


smoothingSpanRun = 0.02;
smoothingSpanCalibration = 0.06;
smoothType = 'loess';

[staticarmFlatRollMaximaIndexes, staticarmFlatRollMaxima, staticarmFlatRollMinimaIndexes, staticarmFlatRollMinima, staticarmFlatRollSmoothData] = staticArmOrientationMaximaMinima(dataStaticarmFlatRoll,smoothingSpanCalibration,smoothType);

display(staticarmFlatRollMinimaIndexes);
display(staticarmFlatRollMinima);
display(staticarmFlatRollMaximaIndexes);
display(staticarmFlatRollMaxima);

[staticarmToeRollMaximaIndexes, staticarmToeRollMaxima, staticarmToeRollMinimaIndexes, staticarmToeRollMinima, staticarmToeRollSmoothData] = staticArmOrientationMaximaMinima(dataStaticarmToeRoll,smoothingSpanCalibration,smoothType);

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

% plot(dataStaticarmFlatTime, dataStaticarmFlatRoll)
% hold on;
% plot(dataStaticarmFlatTime, dataStaticarmFlatYacc, '-r');

%%%%%%%%%%%%%%%%%%%%%5

% plot(dataStaticarmToeTime, dataStaticarmToeRoll);
% hold on;
% plot(dataStaticarmToeTime, dataStaticarmToeXacc, '-r');





% load in run orientation data

speedThreshold = 1.5; % 1.5 m/s. if greater than, considered jogging/running for now. will research more later.
rollAnglePlusMinus = 0; % 2 degrees of +/- error for now.

runFormMidfoot = 'midfoot';
runFormHeel = 'heel';

[rawMidfootRunTime, rawMidfootRunRoll, midfootRunRollMaximaIndexes, midfootRunRollMaxima, midfootRunRollMinimaIndexes, midfootRunRollMinima, midfootRunRollSmoothData, midfootRunTimeInt, midfootRunSpeedInt] = RunAllOrientationData( runNumber, runFormMidfoot, speedThreshold, smoothingSpanRun, smoothType );
midfootMinimaIndexEval = RunOrientationEval( rawMidfootRunTime, rollAnglePlusMinus, meanMinimaStaticarmToeRoll, speedThreshold, midfootRunRollMinimaIndexes, midfootRunSpeedInt, midfootRunRollSmoothData );

[midfootLinaccX, midfootLinaccY, midfootLinaccZ]  = RunLinacc(runNumber, 'midfoot', rawMidfootRunTime, midfootRunRollMaximaIndexes, midfootRunRollMaxima, midfootRunRollMinimaIndexes, midfootRunRollMinima);

% plot(rawMidfootRunTime, rawMidfootRunRoll, '-b');
% hold on;
% plot(rawMidfootRunTime, midfootRunRollSmoothData, '-g');
% hold on;

% plot(rawMidfootRunTime, heelLinaccY, '-r')
% for evalPlotIndex = 0 : size(heelRunRollMinimaIndexes,1)
% 	hold on;
% 	if(evalPlotIndex == 0)
% 		plot(rawMidfootRunTime(1:heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(1:heelRunRollMinimaIndexes(evalPlotIndex+1)), '-y');
% 	elseif (evalPlotIndex == size(heelRunRollMinimaIndexes,1) && rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex)) ~= rawMidfootRunTime(end))
% 		% display(rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex)));
% 		% display(rawMidfootRunTime(end));
% 		plot(rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex):end), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):end), '-y');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 1)
% 		% display('IN');
% 		plot(rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), '-g');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 0)
% 		% display('IN');
% 		plot(rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), '-r');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 2)
% 		% display('IN');
% 		plot(rawMidfootRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), '-b');
% 	end
% end


% plot(rawMidfootRunTime, heelRunRollSmoothData, '-b');

% plot(fft(heelRunRollSmoothData),'-b');

% fftTestMidfoot = fft(heelRunRollSmoothData(heelRunRollMinimaIndexes(1):heelRunRollMinimaIndexes(end)));
% fftTestMidfootSmall = fft(heelRunRollSmoothData(heelRunRollMinimaIndexes(1):heelRunRollMinimaIndexes(2)));

% plot(abs(fftTestMidfoot));
% hold on;
% % plot(abs(fftTestMidfootSmall),'-g');

% plot(heelRunRollSmoothData(heelRunRollMinimaIndexes(1):heelRunRollMinimaIndexes(2)));






[rawHeelRunTime, rawHeelRunRoll, heelRunRollMaximaIndexes, heelRunRollMaxima, heelRunRollMinimaIndexes, heelRunRollMinima, heelRunRollSmoothData, heelRunTimeInt, heelRunSpeedInt] = RunAllOrientationData( runNumber, runFormHeel, speedThreshold, smoothingSpanRun, smoothType );
heelMinimaIndexEval = RunOrientationEval( rawHeelRunTime, rollAnglePlusMinus, meanMinimaStaticarmToeRoll, speedThreshold, heelRunRollMinimaIndexes, heelRunSpeedInt, heelRunRollSmoothData );


[heelLinaccX, heelLinaccY, heelLinaccZ]  = RunLinacc(runNumber, 'heel', rawHeelRunTime, heelRunRollMaximaIndexes, heelRunRollMaxima, heelRunRollMinimaIndexes, heelRunRollMinima);

% THIS WAS UNCOMMENTED LAST GOOD TIME


% plot(rawMidfootRunTime, midfootLinaccZ, '-b');
% hold on;
% % plot(rawHeelRunTime, rawHeelRunRoll, '-g');
% hold on;
% plot(rawHeelRunTime, heelLinaccZ, '-r');




% hold on;
% plot(rawMidfootRunTime, heelLinaccY, '-r')

% fftTestHeel = fft(heelRunRollSmoothData(heelRunRollMinimaIndexes(1):heelRunRollMinimaIndexes(end)));
% fftTestHeelSmall = fft(heelRunRollSmoothData(heelRunRollMinimaIndexes(1):heelRunRollMinimaIndexes(2)));
% plot(abs(fftTestHeel),'-r');

% for evalPlotIndex = 0 : size(heelRunRollMinimaIndexes,1)
% 	hold on;
% 	if(evalPlotIndex == 0)
% 		plot(rawHeelRunTime(1:heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(1:heelRunRollMinimaIndexes(evalPlotIndex+1)), 'oy');
% 	elseif (evalPlotIndex == size(heelRunRollMinimaIndexes,1) && rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex)) ~= rawHeelRunTime(end))
% 		% display(rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex)));
% 		% display(rawHeelRunTime(end));
% 		plot(rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex):end), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):end), 'oy');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 1)
% 		% display('IN');
% 		plot(rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), 'og');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 0)
% 		% display('IN');
% 		plot(rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), 'or');
% 	elseif (heelMinimaIndexEval(evalPlotIndex) == 2)
% 		% display('IN');
% 		plot(rawHeelRunTime(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), heelRunRollSmoothData(heelRunRollMinimaIndexes(evalPlotIndex):heelRunRollMinimaIndexes(evalPlotIndex+1)), 'ob');
% 	end
% end

% plot(rawHeelRunTime, heelRunRollSmoothData, '-r');

% plot(fft(heelRunRollSmoothData),'-r');



% hold on;
% plot(rawMidfootRunTime, rawMidfootRunRoll, '-b');
% hold on;
% plot(rawMidfootRunTime, heelRunRollSmoothData, '-r');

% interpolating speeds




% deciding if right (1), wrong (0) or indecisive(if not moving/ <1.5m/s) (2)


% display(size(heelRunRollMinimaIndexes,1));

display(meanMinimaStaticarmToeRoll);