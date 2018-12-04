function render(X,rw)

% RENDER 2-D simulation of ballbot
% ARGS X: array of size (N,2) where N is length of sequence to be simulated
% X(j,1) is theta; X(j,2) is phi

r = rw;
l = 0.69;
b = 2*r;
length = size(X,1);
figure; hold on;
w = waitforbuttonpress;
xlim([-2 2]);
ylim([0 2]);

for j = 1:length
   cla;
   x = r*(X(j,1)+X(j,2));
   viscircles([x,r],r);
   plot_rectangle(x,X(j,2));
   drawnow;
   pause(0.1);
end

    function plot_rectangle(x,phi)
       x_coords = [x+0.5*b*cos(phi),x+0.5*b*cos(phi)+l*sin(phi),x-0.5*b*cos(phi)+l*sin(phi),x-0.5*b*cos(phi)];
       y_coords = [r-0.5*b*sin(phi),r-0.5*b*sin(phi)+l*cos(phi),r+0.5*b*sin(phi)+l*cos(phi),r+0.5*b*sin(phi)];
       plot(x_coords,y_coords,'k');
    end

end