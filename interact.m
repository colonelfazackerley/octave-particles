% change velocities modelling forces between particles
function particles = interact( particles, interactionParams )
    poss = vertcat(particles.pos);

    xsi = poss(:,1);
    xsj = xsi';
    [Xsi Xsj]=meshgrid(xsi, xsj);
    
    ysi = poss(:,2);
    ysj = ysi';
    [Ysi Ysj]=meshgrid(ysi, ysj);
    
    dX = Xsi - Xsj;
    dY = Ysi - Ysj;
    dSq= dX.^2 + dY.^2;
    
    fX = interactionParams.fForce( dSq, dX );
    fY = interactionParams.fForce( dSq, dY );
    
    diagMask = logical(diag(ones(1,length(particles))));
    
    fX(diagMask)=0; %particles dont interact with themselves
    fY(diagMask)=0;
    
    fX(dSq>interactionParams.distSqLimit) = 0;
    fY(dSq>interactionParams.distSqLimit) = 0;
    
    sumXf = sum(fX); % all forces on each particle
    sumYf = sum(fY);
    
    for i=1:length(particles)
        particles(i).vel += [sumXf(i) sumYf(i)];
    endfor

endfunction

%!demo
%!  for i=1:8
%!      p.pos=rand(1,2)*10;
%!      p.vel=[0 0];
%!      particles(i)=p;
%!  end
%!  #Inverse square law
%!  iParams.fForce = @(distSq, displacement) -0.01 * displacement ./ (distSq.^1.5);
%!  iParams.distSqLimit = 100;
%!  iParams.fExclusionZone = @(pos) 0;
%!  totTime=0;
%!  for i=1:1000
%!      coords = vertcat(particles.pos);
%!      plot(coords(:,1),coords(:,2),'x')
%!      axis([-3 3 -3 3],"equal")
%!      %print(sprintf("interact_demo_%03i.png",i))
%!      tic;
%!      particles=interact(particles, iParams);
%!      totTime += toc;
%!      for j=1:length(particles)
%!          particles(j).pos += particles(j).vel;
%!      endfor
%!  endfor
%!  totTime