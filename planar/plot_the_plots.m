function plot_the_plots(times,THETA,phival,phidval,tau,rw)

figure;
subplot(3,2,1);
plot(times,THETA(:,1)); grid on;
xlabel('Time');
ylabel('Angle \theta');
subplot(3,2,2);
plot(times,phival); grid on;
xlabel('Time');
ylabel('Angle \phi');
subplot(3,2,3);
plot(times,THETA(:,2)); grid on;
xlabel('Time');
ylabel('Angular Velocity \theta^{.}');
subplot(3,2,4);
plot(times,phidval); grid on;
xlabel('Time');
ylabel('Angular Velocity \phi^{.}');
subplot(3,2,5);
plot(times,tau); grid on;
xlabel('Time');
ylabel('Control Effort \tau');
subplot(3,2,6);
plot(times,rw*(THETA(:,1)+phival)); grid on;
xlabel('Time');
ylabel('X');

end