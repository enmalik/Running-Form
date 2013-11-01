function [ rollMinimaIndexes, rollMinima, smoothData ] = StaticArmOrientationMinima( dataArray, smoothingSpan, smoothType )

	smoothData = smooth(dataArray, smoothingSpan, smoothType);

	rollMinima = [];

	[rollMinimaIgnore, rollMinimaIndexes] = findpeaks(-1*smoothData);

	for minimaIndex = 1 : size(rollMinimaIndexes,2)
		rollMinima = [rollMinima;smoothData(rollMinimaIndexes(1,minimaIndex))];
	end

	rollMinimaIndexes = rollMinimaIndexes';

end