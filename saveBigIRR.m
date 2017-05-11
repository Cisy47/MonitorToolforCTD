function saveBigIRR
    global bigIRR;
    for j=1:1
        columns = {'Category','Time', 'CTDname', 'CTDask1', 'CTDbid1', 'CTDaskvol1', 'CTDbidvol1', 'CTDtime','CTDirr','futname', 'futask1', 'futbid1', 'futaskvol1', 'futbidvol1', 'futtime'};
        testcol={'CTDname'};
        num=length(bigIRR(1,j).DBs);
        bigI=bigIRR(1,j).DBs;
        Time={num}; 
        CTDask1=[];CTDbid1=[];CTDaskvol1=[];CTDbidvol1=[];CTDtime=[];CTDirr=[];
        futask1=[];futbid1=[];futaskvol1=[];futbidvol1=[];futtime=[];
        CTDname={num};futname={num};   
        for i=1:num-1
            Category(i)=j;
            Time(i)=cellstr(bigI(1,i).time);
            CTDname{i}=cell2mat(bigI(1,i).CTD.name);
            CTDask1(i)=bigI(1,i).CTD.ask1;
            CTDbid1(i)=bigI(1,i).CTD.bid1;
            CTDaskvol1(i)=bigI(1,i).CTD.askvol1;
            CTDbidvol1(i)=bigI(1,i).CTD.bidvol1;
            CTDtime(i)=bigI(1,i).CTD.time;
            CTDirr(i)=bigI(1,i).CTD.irr;
            futname{i}=cell2mat(bigI(1,i).fut.name);
            futask1(i)=bigI(1,i).fut.ask1;
            futbid1(i)=bigI(1,i).fut.bid1;
            futaskvol1(i)=bigI(1,i).fut.askvol1;
            futbidvol1(i)=bigI(1,i).fut.bidvol1;
            futtime(i)=bigI(1,i).fut.time;
        end
        %xlswrite('test.xls',columns);
        data=table(Category',Time',CTDname',CTDask1',CTDbid1',CTDaskvol1',CTDbidvol1',CTDtime',CTDirr',futname',futask1',futbid1',futaskvol1',futbidvol1',futtime','VariableNames', columns);
        %data = table(LastName, Gender, Age, Location, Height, Weight, Smoker, 'VariableNames', columns); 
        name = strcat(date,'.csv');
        writetable(data, name);
    end
    clear global ;
    %xlswrite('test.xls',cell2mat(test),1,'A2');
end

