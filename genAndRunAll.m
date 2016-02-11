% TODO: this with makefile instead
function genAndRunAll( variant)
    genFireFlatParticles(variant);
    convertFireFlatParticlesToBall(variant);
    convertFireFlatParticlesToSlope(variant);
    convertFireParticlesSlopeTransition( variant ); %left and right rise
    runFireFlat(variant);
    runFireFalling(variant);
    runFireRiseRight(variant);
    runFireRiseLeft(variant);
    runFireFallToRiseRight( variant );
    runFireFallToRiseLeft( variant );
endfunction