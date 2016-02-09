% TODO: this with makefile instead
function genAndRunAll( variant)
    genFireFlatParticles(variant);
    convertFireFlatParticlesToBall(variant);
    convertFireFlatParticlesToSlope(variant);
    runFireFlat(variant);
    runFireFalling(variant);
    runFireRiseRight(variant);
endfunction