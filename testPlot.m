function testPlot(imgSize, border, interactionParams)
    close all

    xp=[];yp=[];
    for x=0:10:imgSize(2)
        for y=0:10:imgSize(1)
            if interactionParams.fExclusionZone([x y])
                xp=[xp x];yp=[yp y];
            endif
        endfor
    endfor
    plot(xp,yp)
    hold on
    plot([border imgSize(2)-border imgSize(2)-border border border], ...
         [border border imgSize(1)-border imgSize(1)-border border])
    set(gca,"ydir","reverse");
    axis square
    axis([0 imgSize(2) 0 imgSize(1)]);

endfunction