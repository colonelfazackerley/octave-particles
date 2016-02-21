function runFireFallToRiseLeft(variant)

    setPage
    setFireParams
    
    % override exclusionZone
    interactionParams.fExclusionZone = @(x,y) y >= 200 + 32 + 128 - x;

    % override page size
    vertOffset = 128;
    imgSize(1) = imgSize(1)+vertOffset; %imgSize is height, width

    pngPrefix = sprintf("fire_fall_to_rise_left_%s_",variant);

    datGlob = sprintf('fire_fall_to_rise_left_particles_%s_*.dat',variant);
    fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
         particleParams, interactionParams, pngPrefix, whiteBg);

    cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
    printf("%s\n",cmd);
    system(cmd);
endfunction