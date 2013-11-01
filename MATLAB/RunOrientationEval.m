function [ runMinimaIndexEval ] = RunOrientationEval( dataRunTime, rollAnglePlusMinus, meanMinimaStaticarmToeRoll, speedThreshold, runRollMinimaIndexes, speedInt, runRollSmoothData )

% deciding if right (1), wrong (0) or indecisive(if not moving/ <1.5m/s) (2)

runMinimaIndexEval = [];

for evalIndex = 1 : size(runRollMinimaIndexes,1)
	flag = 0;
	display(speedInt(runRollMinimaIndexes(evalIndex)));
	display(runRollSmoothData(runRollMinimaIndexes(evalIndex)));
	if ((runRollSmoothData(runRollMinimaIndexes(evalIndex)) + rollAnglePlusMinus) > meanMinimaStaticarmToeRoll && speedInt(runRollMinimaIndexes(evalIndex)) > speedThreshold) % if angle is greate than stattic mean and speed is greater than threshold, right
		% display('IN EVAL');
		flag = 1;
	elseif (speedInt(runRollMinimaIndexes(evalIndex)) < speedThreshold) % if speed is less than speed threshold, indecisive
		% display('IN EVAL');
		flag = 2;
	elseif ((runRollSmoothData(runRollMinimaIndexes(evalIndex)) + rollAnglePlusMinus) < meanMinimaStaticarmToeRoll && speedInt(runRollMinimaIndexes(evalIndex)) > speedThreshold) % if angle is less than static mean and speed is greater than speed threshold, wrong
		% display('IN EVAL');
		flag = 0;
	else
		flag = 100;
	end
	display(flag);
	runMinimaIndexEval = [runMinimaIndexEval;flag];
end

display(runMinimaIndexEval);

display(size(dataRunTime));
display(size(runRollSmoothData));

% plot(dataRunTime, runRollSmoothData);

% for evalPlotIndex = 0 : size(runRollMinimaIndexes,1)
% 	hold on;
% 	if(evalPlotIndex == 0)
% 		plot(dataRunTime(1:runRollMinimaIndexes(evalPlotIndex+1)), runRollSmoothData(1:runRollMinimaIndexes(evalPlotIndex+1)), '-y');
% 	elseif (evalPlotIndex == size(runRollMinimaIndexes,1) && dataRunTime(runRollMinimaIndexes(evalPlotIndex)) ~= dataRunTime(end))
% 		% display(dataRunTime(runRollMinimaIndexes(evalPlotIndex)));
% 		% display(dataRunTime(end));
% 		plot(dataRunTime(runRollMinimaIndexes(evalPlotIndex):end), runRollSmoothData(runRollMinimaIndexes(evalPlotIndex):end), '-y');
% 	elseif (runMinimaIndexEval(evalPlotIndex) == 1)
% 		% display('IN');
% 		plot(dataRunTime(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), runRollSmoothData(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), '-g');
% 	elseif (runMinimaIndexEval(evalPlotIndex) == 0)
% 		% display('IN');
% 		plot(dataRunTime(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), runRollSmoothData(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), '-r');
% 	elseif (runMinimaIndexEval(evalPlotIndex) == 2)
% 		% display('IN');
% 		plot(dataRunTime(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), runRollSmoothData(runRollMinimaIndexes(evalPlotIndex):runRollMinimaIndexes(evalPlotIndex+1)), '-b');
% 	end
% end

end