
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = fireTempScale();
maxWidth = 10 ; % max half width of streamers
    
interactionParams.fExclusionZone = @(x,y) y > 200;
interactionParams.distSqLimit = 3000;
interactionParams.fForce = @(distSquared, displacement) 0.4 .* displacement ./ distSquared; 

particleParams.fCooling = @(pos) (80 - pos(2))/80 - 1