% TODO: this with makefile instead
function runAll( variant)
    runFireFlat(variant);
    runFireFalling(variant);
    runFireRiseRight(variant);
    runFireRiseLeft(variant);
    runFireFallToRiseRight( variant );
    runFireFallToRiseLeft( variant );
endfunction

% b and c have runFireFallToRiseLeft outstanding. d needs all.