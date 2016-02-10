function testPlot(imgSize, border, interactionParams, particleParams)
    close all

    if nargin > 2
        xp=[];yp=[];
        for x=0:10:imgSize(2)
            for y=0:10:imgSize(1)
                if interactionParams.fExclusionZone(x,y)
                    xp=[xp x];yp=[yp y];
                endif
            endfor
        endfor
        plot(xp,yp)
        hold on
    endif
    
    if nargin > 3
        x=0:10:imgSize(2);
        y=0:10:imgSize(1);
        [X Y]=meshgrid(x,y);
        Z = zeros(size(X));
        for xc = 1:length(x)
            for yc = 1:length(y)
                Z(yc,xc) = particleParams.fCooling([x(xc) y(yc)]);
            endfor
        endfor
        contour(X,Y,Z);
        Z
    endif
    
    plot([border imgSize(2)-border imgSize(2)-border border border], ...
         [border border imgSize(1)-border imgSize(1)-border border])
    hold on
    set(gca,"ydir","reverse");
    axis square
    axis([0 imgSize(2) 0 imgSize(1)]);

endfunction
