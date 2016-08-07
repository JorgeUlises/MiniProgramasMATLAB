r = audiorecorder(8000, 16, 1);
recordblocking(r,3);
y1 = getaudiodata(r);
wavwrite(y1,8000,'rec1.wav')

recordblocking(r,3);
y2 = getaudiodata(r);
wavwrite(y2,8000,'rec2.wav')

recordblocking(r,3);
y3 = getaudiodata(r);
wavwrite(y3,8000,'rec3.wav')