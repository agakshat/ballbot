function plot_the_plots(times,THETA,phival,phidval,tau,rw)

figure;
subplot(3,2,1);
plot(times,THETA(:,1),'linewidth',2); grid on;
set(gca,'FontSize',10);
xlabel('Time');
ylabel('Angle \theta');
subplot(3,2,2);
plot(times,phival,'linewidth',2); grid on;
set(gca,'FontSize',10);

xlabel('Time');
ylabel('Angle \phi');
subplot(3,2,3);
plot(times,THETA(:,2),'linewidth',2); grid on;set(gca,'FontSize',10);

xlabel('Time');
ylabel('\theta^{.}');
subplot(3,2,4);
plot(times,phidval,'linewidth',2); grid on;set(gca,'FontSize',10);

xlabel('Time');
ylabel('\phi^{.}');
subplot(3,2,5);
plot(times,tau,'linewidth',2); grid on;set(gca,'FontSize',10);

xlabel('Time');
ylabel('Control \tau');
subplot(3,2,6);
plot(times,rw*(THETA(:,1)+phival),'linewidth',2); grid on;set(gca,'FontSize',10);

xlabel('Time');
ylabel('X');

end