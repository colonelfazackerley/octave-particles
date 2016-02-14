% colour in a trapezium in the supplied array
% [img alpha] = fillTrapezium( img, alpha, p1, p2,  colour, oldWid, wid)
% img:       (height, width, rgb)
% alpha:     (height, width) opacity
% p1:        position [x y] of middle of one side of the trapezium
% p2         positin of opposite side of the trapezium
% colour:    vector with 4 elements, rgba
% width1:    the length of the side centred on p1
% width2:    the length of the side centred on p2
function [img alpha] = fillTrapezium( img, alpha, p1, p2,  colour, width1, width2)
  if 0 == width1
    return;
  endif
  d = p2 -p1; % displacement vector
  l = sqrt(sum(d.^2)); % length of displacement vector
  du = d / l ; % unit vector
  dun = [du(2)  -du(1)]; % normal to unit vector, for thickening line

  s = 0.5; % a little bit less than 1 to avoid holes in the line
  for i = 0:s:l
    p = p1 + du * i ;
    iWid = interp1([0 l], [width1 width2], i); % interpolated width
    for j = -iWid:s:iWid  % thicken line by drawing row of points
      pa = p + dun * j;
      [img alpha] = setPixelSingle ( img, alpha, pa(1), pa(2), colour);
    end
  endfor
endfunction

function [img alpha] = setPixelSingle(img, alpha, x,y, colour)
  px = ceil(x);
  py = ceil(y); 
  if px > 0 && px < columns(alpha) && py > 0 && py < rows(alpha)
    img( py , px , : ) = colour(1:3);
    alpha( py, px ) += colour(4);
  endif
endfunction


