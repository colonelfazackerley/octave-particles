% TODO: this with makefile instead
function genAndRunAll( variant)
    genFireFlatParticles(variant);
    convertFireFlatParticlesToBall(variant);
    convertFireFlatParticlesToSlope(variant);
    convertFireParticlesSlopeTransition( variant )
    runFireFlat(variant);
    runFireFalling(variant);
    runFireRiseRight(variant);
    runFireRiseLeft(variant);
    runFireFallToRiseRight( variant );
endfunction