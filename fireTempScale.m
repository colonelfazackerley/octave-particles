% create a fiery colour map
function cMap = fireTempScale()

  %    grey black red red    orange whitish yellow red
  r = [0.5  0     1   1      1      1       1      1   ];
  g = [0.5  0     0   0      0.5    .9      1      0   ];
  b = [0.5  0     0   0      0      .8      0      0   ];
  a = [0    1     1   1      1      1       1      1  ]*.3;
  i = [1    15    20  30     50     80      95     100 ];
  
  cMap = zeros( 100, 4); % RGBA
  cMap( : , 1 ) = interp1( i, r, 1:100 );
  cMap( : , 2 ) = interp1( i, g, 1:100 );
  cMap( : , 3 ) = interp1( i, b, 1:100 );
  cMap( : , 4 ) = interp1( i, a, 1:100 ); % alpha
endfunction

function showColourMap( cMap )
  figure
  hold on
  for i=1:rows(cMap)
    plot( [0 1], [-i -i], 'color',cMap( i, : ) );
  endfor
endfunction
