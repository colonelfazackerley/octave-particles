% width modulation function
% f = widthMod( x, t)
% x: distance along streamer
% t: time step
function f = widthMod( x, t, params)

    %printf(" %i",x)
    
    t_step = 2 * pi() / 10;
     
    f1 = sin( params.phase(1) - t_step * t + 2 * pi() * x / params.period(1) ); % 35,60
    f2 = sin( params.phase(2) - t_step * t + 2 * pi() * x / params.period(2) ); % 1-6
    f3 = 1 - ( (x - 25) / 25) .^ 6 ;
    f3( f3 < 0 ) = 0 ;
    f = f1 .* f2 .* f3 ;
    f=abs( f );
    %subplot(2,1,1),plot( x, f3 ); hold on
    %subplot(2,1,2),plot( x, f ); hold on
    %subplot(2,1,1); axis([0 100 0 1]);
    %subplot(2,1,2); axis([0 100 -.1 1]); 
    %print(sprintf("modfn_%i.png",t));
    %close all
    
    
endfunction

%!demo
%!  f=zeros(1,100);
%!  x=1:100;
%!  params.phase=rand(1,2)*6;
%!  params.period = rand(1,2)*20+[30 60];
%!  for t=1:10
%!    for xi=x;
%!      f(xi) = widthMod(xi,t, params);
%!    endfor
%!    plot(x,f)
%!    print(sprintf("widthMod_demo_%i.png",t));
%!  endfor
%!  system("convert -loop 0 -delay 10 widthMod_demo_*.png widthMod_demo.gif");