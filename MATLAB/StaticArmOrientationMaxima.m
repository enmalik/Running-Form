function [ rollMaximaIndexes, rollMaxima, smoothData ] = StaticArmOrientationMaxima( dataArray, smoothingSpan, smoothType )

	smoothData = smooth(dataArray, smoothingSpan, smoothType);
	[rollMaxima, rollMaximaIndexes] = findpeaks(smoothData);
	rollMaximaIndexes = rollMaximaIndexes';
	rollMaxima = rollMaxima';

end



