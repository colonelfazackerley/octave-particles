function runFireFalling(variant)
    % config
    nTime = 10 ; % number of time steps
    nSteps = 52 %100; % streamer length steps
    cMap = tempScale();
    maxWidth = 10 ; % max half width of streamers
    setPage

    pngPrefix = "fire_falling_a_";

    interactionParams.fExclusionZone = @(pos) pos(2) > 200;
    interactionParams.distSqLimit = 3000;
    interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

    particleParams.fCooling = @(pos) (265 - pos(2))/80 + rand(1)*0.5

    datGlob = sprintf('fire_falling_particles_%s_*.dat',variant)
    fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
         particleParams, interactionParams, pngPrefix, whiteBg);
         

    cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
    printf("%s\n",cmd);
    system(cmd);
endfunction