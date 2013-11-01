function [ rollMaximaIndexes, rollMaxima, rollMinimaIndexes, rollMinima, smoothData ] = RunOrientationMaximaMinima( dataArray, speedArray, speedThreshold, smoothingSpan, smoothType )

	smoothData = smooth(dataArray, smoothingSpan, smoothType);
	[rollMaximaPrimary, rollMaximaIndexesPrimary] = findpeaks(smoothData);
	rollMaximaIndexesPrimary = rollMaximaIndexesPrimary';
	rollMaximaPrimary = rollMaximaPrimary';

	rollMaximaIndexes = [];
	rollMaxima = [];

	% display(rollMaximaIndexesPrimary);
	% display(size(dataArray));
	% display(speedArray);

	for revisedMaximaIndex = 1 : size(rollMaximaIndexesPrimary,1)
		if (speedArray(rollMaximaIndexesPrimary(revisedMaximaIndex)) > 0)
			rollMaximaIndexes = [rollMaximaIndexes;rollMaximaIndexesPrimary(revisedMaximaIndex)];
			rollMaxima = [rollMaxima;rollMaximaIndexesPrimary(revisedMaximaIndex)];
		end
	end


	rollMinimaIndexes = [];
	rollMinima = [];
	[rollMinimaIgnore, rollMinimaIndexesPrimary] = findpeaks(-1*smoothData);

	for minimaIndex = 1 : size(rollMinimaIndexesPrimary,2)
		
		if (speedArray(rollMinimaIndexesPrimary(minimaIndex)) > 0)
			rollMinimaIndexes = [rollMinimaIndexes;rollMinimaIndexesPrimary(minimaIndex)];
			rollMinima = [rollMinima;smoothData(rollMinimaIndexesPrimary(minimaIndex))];
		end

	end
	% display(rollMinimaIndexesPrimary);
	% display(rollMinimaIndexes);

	display(rollMinima);
end