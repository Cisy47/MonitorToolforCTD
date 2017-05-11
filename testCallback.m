
function myCallback(reqid,isfinished,errorid,datas,codes,fields,times,selfdata)

global DBT;
global DBT_i;
global bigIRR;
global bigIRR_i;
global productMap;

mark = selfdata{1};
productArray=cellstr(keys(productMap));

str = sprintf('============updating %d===========',mark);
disp(str);

%%%%%%%%%%%%%%%%%%

m_temp = msg();

cnt =DBT_i(mark);

if(cnt>=2)
    fut_temp=DBT(mark).DBs(cnt-1).fut;
    for k=1:1:length(codes)
        ctd_temp=product();
        if(ismember(codes(k),productArray))
            cnt_last=productMap(codes(k));
            m_last=DBT(mark).DBs(cnt_last);
            for i=1:length(m_last.CTD)
                if(m_last.CTD(i).name==codes(k))
                    m_temp=m_last;
                end
            end
            remove(productMap,codes(k));
        for j=1:1:length(fields)
            if(strcmp(fields(j),'RT_TIME'))
                ctd_temp(k).time = datas(j,k);
            elseif(strcmp(fields(j),'RT_ASK1'))
                ctd_temp(k).ask1 = datas(j,k);
            elseif(strcmp(fields(j),'RT_BID1'))
                ctd_temp(k).bid1 = datas(j,k);
            elseif(strcmp(fields(j),'RT_BSIZE1'))
                ctd_temp(k).bidvol1 = datas(j,k);
            elseif(strcmp(fields(j), 'RT_ASIZE1'))
                ctd_temp(k).askvol1 = datas(j,k);
            end
        end
        
        productMap(codes(k))=cnt+1;
        elseif(codes(k)==fut_temp.name)
            for j=1:1:length(fields)
                   if(strcmp(fields(j),'RT_TIME'))
                       fut_temp.time = datas(j,k);
                   elseif(strcmp(fields(j),'RT_ASK1'))
                       fut_temp.ask1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BID1'))
                       fut_temp.bid1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BSIZE1'))
                       fut_temp.bidvol1 = datas(j,k);
                   elseif(strcmp(fields(j), 'RT_ASIZE1'))
                       fut_temp.askvol1 = datas(j,k);
                   end
            end
        end
    end
    
    m_temp.CTD=ctd_temp;
    m_temp.fut=fut_temp;
    m_temp.time = datestr(times,'yyyy/mm/dd HHMMSS');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(DBT_i(mark)==1)
    DBT(mark).DBs = msg();
    bigIRR(mark).DBs= msg();
    p=product();
    for k=1:1:length(codes)
    
        p(k) = product();
        p(k).name = codes(k);
        
        for j=1:1:length(fields)
            if(strcmp(fields(j),'RT_TIME'))        
                p(k).time = datas(j,k);
            elseif(strcmp(fields(j),'RT_ASK1'))
                p(k).ask1 = datas(j,k);
            elseif(strcmp(fields(j),'RT_BID1'))
                p(k).bid1 = datas(j,k);
            elseif(strcmp(fields(j),'RT_BSIZE1'))
                p(k).bidvol1 = datas(j,k);
            elseif(strcmp(fields(j), 'RT_ASIZE1'))
                p(k).askvol1 = datas(j,k);
            end
        end
        
        if(k==length(codes))
            m_temp.fut = p(k);
        else
            m_temp.CTD = p;
            productMap(p(k).name)=1;
        end        
    end    
    m_temp.time = datestr(times,'yyyy/mm/dd HHMMSS');      
end
%%%%%%%%%????IRR


for k=1:1:length(m_temp.CTD)
    n = m_temp.CTD(k).name;
    if(~ismember(m_temp.CTD(k).name,codes))
        continue;
    end
    
    if(~isempty(m_temp.CTD(k).ask1) && ~isempty(m_temp.CTD(k).bid1) && m_temp.CTD(k).ask1~=0 && m_temp.CTD(k).bid1~=0)
        %%%????????????
        IRR = IRRcal(m_temp.fut.bid1,m_temp.CTD(k).ask1,selfdata{2}(k),selfdata{3}(k),selfdata{4}(k),selfdata{5}(k),selfdata{6});
        m_temp.CTD(k).irr = IRR;             
        bigIRR(mark).DBs(bigIRR_i(mark)).CTD = product();
        bigIRR(mark).DBs(bigIRR_i(mark)).CTD = m_temp.CTD(k);
        bigIRR(mark).DBs(bigIRR_i(mark)).fut = m_temp.fut;
        bigIRR(mark).DBs(bigIRR_i(mark)).time = datestr(times,'yyyy/mm/dd HHMMSS');
        bigIRR_i(mark) = bigIRR_i(mark)+1;
        bigIRR(mark).DBs(bigIRR_i(mark))= msg();
        
    end

end



DBT(mark).DBs(DBT_i(mark))=m_temp;  
    
DBT_i(mark)=DBT_i(mark)+1;
    
end