% colour in a trapezium in the supplied array
% [img alpha] = fillTrapezium( img, alpha, p1, p2,  colour, oldWid, wid)
% img:       (height, width, rgb)
% alpha:     (height, width) opacity
% avoidMask: does not colour pixels in the supplied mask.
% p1:        position [x y] of middle of one side of the trapezium
% p2         positin of opposite side of the trapezium
% colour:    vector with 4 elements, rgba
% width1:    the half length of the side centred on p1
% width2:    the half length of the side centred on p2
function [img alpha mask] = fillTrapezium( img, alpha, avoidMask, p1, p2,  colour, width1, width2)
    if 0 == width1
        mask = zeros (rows(alpha),columns(alpha));
        return;
    endif
    d = p2 -p1; % displacement vector: points from p1 to p2
    l = sqrt(sum(d.^2)); % length of displacement vector
    du = d / l ; % unit vector
    dun = [du(2)  -du(1)]; % normal to unit vector, for thickening line

    bv = dun*width1; % bottom vector
    tv = dun*width2; % top vector
    % move p1 edge back a pixel to avoid gaps
    vertices = [ p1' + bv' - du', p1' - bv' - du', p2' - tv' , p2' + tv' ];

    % check for the polygon having a zero dimension
    vertsi=floor(vertices)';
    if sum( max(vertsi) - min(vertsi) < 2 )
        mask = zeros (rows(alpha),columns(alpha));
        return
    endif

    mask = poly2mask(vertices(1,:), vertices(2,:), rows(alpha), columns(alpha));
    mask = mask & !avoidMask;
    inds = find (mask);
    numEl = rows(alpha) * columns(alpha);
    img(inds)=colour(1);
    img(inds+numEl)=colour(2);
    img(inds+2*numEl)=colour(3);
    

    alpha(:,:) += mask*colour(4);
  
endfunction

% causes an error m = poly2mask ([114.70   114.84   114.08   114.33],[293.49   293.34   293.04   292.76],320,320)

%!demo
%! w = 10; h = 12;
%! img = zeros(h,w,3);
%! alpha = zeros(h,w);
%! mask = zeros(h,w);
%! p1=[5, 2]; p2=[5,10];
%! w1=2; w2=4;
%! colour = [.5 .7 0.9 .8];
%! [img alpha]=fillTrapezium(img, alpha, mask, p1, p2, colour, w1, w2);




