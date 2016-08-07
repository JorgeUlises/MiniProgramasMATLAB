a = arduino('COM3', 'uno');
if c==0
    c=1;
    writePWMDutyCycle(a,10,0);
    pause(3);
    for i=0:100
        writePWMDutyCycle(a,9,i/100);
        pause(0.001);
    end;
else
    c=0;
    writePWMDutyCycle(a,9,0);
    pause(3);
    for i=0:100
        writePWMDutyCycle(a,10,i/100);
        pause(0.001);
    end;
end;
