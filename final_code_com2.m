s = serial('COM2');
s= serial('COM2','BaudRate',9600);
s.BytesAvailableFcnCount = 16384;
s.InputBufferSize = 8192;
set(s,'Terminator','CR');
%s.InputBufferSize = 8192 ;
%s.BytesAvailable = 2048;
fopen(s)
%pause(1)

%-------=====++++====-------
%            MAIN
%-------=====++++====-------
%fprintf('------====++++ EEAE ++++====--------- \n')
%fprintf('----- Test Program For RSS-131 ------ \n')
%fprintf('------- by Vasileios Savakis -------- \n')
%fprintf('\n\n')
%pause(0.5)

    fprintf(s,'#v 0\w\n'); 
    pause(2)
    fscanf(s);
    pause(2)
    fscanf(s);
  
    fprintf('----- Firmware Version -----\n')
    pause(1)
    fprintf('%s\n', ans);
    pause(1)
    fprintf('Initiates...\n')
    pause(1)
    fclose(s)
    pause(1)
    fopen(s)
    fprintf('Program Starts\n')
    pause(1)

%read HPIC value
fprintf(s,'#s 0\w'); %read HPIC
%fgets(s); 

%===+++=== LOOP ===+++===
 %===+++=== LOOP ===+++===
t=1;
disp('Running');
x=0;
y=0;
z=0;
m=0;
%fprintf(s,'#s 0\w\n')
%pause(1) 

while(t < 600) 
     k = fgets(s);
     c = sscanf(k,'%f');
     ans = size(k);
     
    if ans(1,1) ~= 1 || ans(1,2) ~= 72%size(c)=[0,0]
        k = fgets(s)
         c = sscanf(k,'%f');
    end
   
    r = c(5,1);%radiation 1column 5row 
   rad=r*(10^3);
   x =[x rad]; %pinakas Radiation
   
    bias = c(6,1);%bias 1column row 
   y =[y bias]; %pinakas Bias
   
    battery = c(7,1);%bias 1column row 
   z =[z battery]; %pinakas Bias
   
     temp = c(8,1);%bias 1column row 
   m =[m temp]; %pinakas Bias
   

subplot(2,1,2);
title('Radiation');
leg1 = legend('nSv');
set(leg1,'Location','best');
axis auto;
plot(x,'g'); 
set(gca,'Color',[0.4 0.4 0.4]);  %CHANGE COLOR
grid on;
drawnow;
hold on


subplot(2,2,1);
title('Bias');
leg2 = legend('V');
set(leg2,'Location','best');
axis auto;
plot(y,'g');
set(gca,'Color',[0.4 0.4 0.4]);  %CHANGE COLOR
grid on;
drawnow;
hold on


subplot(2,4,3);
title('battery');
leg3 = legend('V');
set(leg3,'Location','best');
axis auto;
plot(z,'g');
grid on;
set(gca,'Color',[0.4 0.4 0.4]);  %CHANGE COLOR
drawnow;
hold on


subplot(2,4,4);
title('Temperature');
leg4 = legend('oC');
set(leg4,'Location','best');
axis auto;
plot(m,'g');
grid on;
set(gca,'Color',[0.4 0.4 0.4]);  %CHANGE COLOR
drawnow;
hold on

max1 = max(x);
max2 = max(y);
max3 = max(z);
max4 = max(m);

pause(0.6)

t=t+1;
end 

%=-=-=-=-  MAX =-=-=-=-
max11=num2str(max1);max22=num2str(max2);max33=num2str(max3);max44=num2str(max4);
msg1 = msgbox(['Radiation MAX:' max11 'nSv'], 'Message Box');
msg2 = msgbox(['Bias MAX:' max22 'Volt'], 'Message Box');
msg3 = msgbox(['Battery MAX:' max33 'Volt'], 'Message Box');
msg4 = msgbox(['Temperature MAX:' max44 'oC'], 'Message Box');