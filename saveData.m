function saveData
    global data;
    filename='2017-4-26.mat';
    s=load(filename);
    columns = {'Time', 'CTDname', 'CTDirr','CTDbid'};
    mark =1;
    Time={};
    CTDname={};
    CTDirr=[];
    temp=s.DBT(1,1).DBs;
    for i=1:1:length(temp)
        m = temp(1,i);
        for k=1:1:length(m.CTD)
            if(~isempty(m.CTD(k).irr))
                Time(mark)=cellstr(m.time);
                CTDname{mark}=cell2mat(m.CTD(k).name);
                CTDirr(mark)=m.CTD(k).irr;
                CTDbid(mark)=m.CTD(k).bid1;
                mark=mark+1;
            end
        end
    end
    t=table(Time',CTDname',CTDirr',CTDbid','VariableNames', columns); 
    name = strcat('2017-4-26.csv');
    writetable(t, name);
end