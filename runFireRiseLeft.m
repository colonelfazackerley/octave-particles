function runFireRiseLeft(variant)
    % config
    nTime = 10 ; % number of time steps
    nSteps = 52 %100; % streamer length steps
    cMap = tempScale();
    maxWidth = 10 ; % max half width of streamers
    setPage

    vertOffset = 128;
    
    imgSize(1) = imgSize(1)+vertOffset; %imgSize is height, width

    pngPrefix = "fire_rise_left_a_";

    interactionParams.fExclusionZone = @(pos) pos(2) >= 200 -256 + 32 + 128 + pos(1);
    interactionParams.distSqLimit = 3000;
    interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

    particleParams.fCooling = @(pos) (265 - 256 + 32 + 128 +pos(1) - pos(2))/70 

    testPlot(imgSize, border, interactionParams, particleParams);
    datGlob = sprintf('fire_rise_left_particles_%s_*.dat',variant);
    fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
         particleParams, interactionParams, pngPrefix, whiteBg);

    cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
    printf("%s\n",cmd);
    system(cmd);
endfunction