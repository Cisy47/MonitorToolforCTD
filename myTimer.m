


delay = (datenum('2017/4/21 6:00:00') - datenum((now)))*24*3600;




t=timer('Name','CircleTimer',...
 'TimerFcn',{@test,5},...
 'Period',5,...
 'ExecutionMode','fixedRate',...
 'StartFcn',{@test,9},...
 'StartDelay', delay);




function test(obj,event,inp)

    t = sprintf('hello====>%d=======>%s',inp,datestr(now));
    disp(t);
    
    
    
    
    
end