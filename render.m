function render(X,times,rw,xw,yw)

% RENDER 2-D simulation of ballbot
% ARGS X: array of size (N,2) where N is length of sequence to be simulated
% X(j,1) is theta; X(j,2) is phi

r = rw;
l = 1;
b = 2*r;
length = size(X,1);
figure; 
subplot(2,1,1); hold on;
xlabel('X');
ylabel('Z');
title('2D Rendering of the Ballbot');
xlim([-2 2]);
ylim([0 2]);

subplot(2,1,2); hold on;
xlabel('X');
ylabel('Y');
title('Movement of Ballbot along floor');
plot(0,0,'rs','MarkerSize',14);
plot(1,1,'ro','MarkerSize',7);

w = waitforbuttonpress;
for j = 1:length
   t0 = cputime;
   x = r*(X(j,1)+X(j,2));
   subplot(2,1,1);
   cla;
   viscircles([x,r],r);
   plot_rectangle(x,X(j,2));
   subplot(2,1,2);
   plot(xw(j),yw(j),'ks','MarkerSize',4);
   drawnow;
   
   t1 = cputime;
   if j<length
    pause(times(j+1)-times(j)-(t1-t0));
%     pause(0.008)
   end
end
    function plot_rectangle(x,phi)
       x_coords = [x+0.5*b*cos(phi),x+0.5*b*cos(phi)+l*sin(phi),x-0.5*b*cos(phi)+l*sin(phi),x-0.5*b*cos(phi)];
       y_coords = [r-0.5*b*sin(phi),r-0.5*b*sin(phi)+l*cos(phi),r+0.5*b*sin(phi)+l*cos(phi),r+0.5*b*sin(phi)];
       plot(x_coords,y_coords,'k');
    end

end