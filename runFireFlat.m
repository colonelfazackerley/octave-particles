function runFireFlat(variant)
    % config
    nTime = 10 ; % number of time steps
    nSteps = 52 %100; % streamer length steps
    cMap = tempScale();
    maxWidth = 10 ; % max half width of streamers
    setPage


    interactionParams.fExclusionZone = @(x,y) y > 200;
    interactionParams.distSqLimit = 3000;
    interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

    particleParams.fCooling = @(pos) @(pos) (80 - pos(2))/80 - rand(1)*2

    testPlot(imgSize, border, interactionParams, particleParams);
    
    pngPrefix = sprintf("fire_%s_",variant);
    datGlob = sprintf('fire_flat_particles_%s_*.dat', variant);
    fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
         particleParams, interactionParams, pngPrefix, whiteBg);
         

    cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
    printf("%s\n",cmd);
    system(cmd);
endfunction