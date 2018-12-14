figure; hold on;
plot(0,0,'rs','MarkerSize',14);
plot(1,1,'ro','MarkerSize',7);
xlabel('X');
ylabel('Y');
title('Movement of Ballbot along floor');
for j=1:size(xw,1)
    plot(xw(j),yw(j),'ks','MarkerSize',4);
    drawnow;
end