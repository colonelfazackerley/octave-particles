function runFireFlat(variant)
    
    setPage
    setFireParams
    % override exclusionZone
    interactionParams.fExclusionZone = @(x,y) y > 200;

    pngPrefix = sprintf("fire_%s_",variant);
    datGlob = sprintf('fire_flat_particles_%s_*.dat', variant);
    fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
         particleParams, interactionParams, pngPrefix);
         

    cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
    printf("%s\n",cmd);
    system(cmd);
endfunction