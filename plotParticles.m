
% [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, length_i, time_i)
% img:       (height, width, rgb)
% alpha:     (height, width) opacity
% particles: array of structures. see initFireStreamers
% cMap:      (100,rgba) colour cMap
% maxWidth:  max width of modulated streamers
% length_i:  index of position of distance along the streamer
% time_i:    index of time step
function [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, length_i, time_i)
  for i=1:length(particles)
    p = particles(i);
    %particles(i).temp
    colour = cMap(ceil(particles(i).temp), : );
#     plot( [p.oldPos(1) p.pos(1)], [p.oldPos(2) p.pos(2)], 
#             'color', colour(1:3),
#             'linewidth', 5 );
    
    wid = maxWidth * widthMod( length_i, time_i, p.params ); 
    
    [img alpha] = fillTrapezium( img, alpha, ...
                           p.oldPos, p.pos,  ...
                           colour, p.oldWidth, wid );
    particles(i).oldWidth = wid;
   
  endfor
endfunction
