%??????????????????????????????????????????????
%????????????
function myCallback(reqid,isfinished,errorid,datas,codes,fields,times,selfdata)

global DBT;
global DBT_i;
global bigIRR;
global bigIRR_i;


mark = selfdata{1};

str = sprintf('============updating %d===========',mark);
disp(str);

%%%%%%%%%%%%%%%%%%

m_temp = msg();

if(DBT_i(mark)>=2)
    m_temp = DBT(mark).DBs(DBT_i(mark)-1);

    for k=1:1:length(codes)
    
        for o=1:1:length(m_temp.CTD)
            if(strcmp(codes(k),m_temp.CTD(o).name))                
               str = sprintf('look at the number %d.', o);
               disp(str);
                
               for j=1:1:length(fields)
                   if(strcmp(fields(j),'RT_TIME'))
                       m_temp.CTD(o).time = datas(j,k);
                   elseif(strcmp(fields(j),'RT_ASK1'))
                       m_temp.CTD(o).ask1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BID1'))
                       m_temp.CTD(o).bid1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BSIZE1'))
                       m_temp.CTD(o).bidvol1 = datas(j,k);
                   elseif(strcmp(fields(j), 'RT_ASIZE1'))
                       m_temp.CTD(o).askvol1 = datas(j,k);
                   end
               end
            end
        end  
        
        
        if(strcmp(codes(k),m_temp.fut.name))                
 %%%            str = sprintf('look at the fut');
%%%             disp(str);
                
               for j=1:1:length(fields)
                   if(strcmp(fields(j),'RT_TIME'))
                       m_temp.fut.time = datas(j,k);
                   elseif(strcmp(fields(j),'RT_ASK1'))
                       m_temp.fut.ask1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BID1'))
                       m_temp.fut.bid1 = datas(j,k);
                   elseif(strcmp(fields(j),'RT_BSIZE1'))
                       m_temp.fut.bidvol1 = datas(j,k);
                   elseif(strcmp(fields(j), 'RT_ASIZE1'))
                       m_temp.fut.askvol1 = datas(j,k);
                   end
               end
        end          
    end
    
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
        end        
    end    
    m_temp.time = datestr(times,'yyyy/mm/dd HHMMSS');      

end
%%%%%%%%%????IRR


for k=1:1:length(m_temp.CTD)
    
    if(~ismember(m_temp.CTD(k).name,codes))
        continue;
    end
    
    if(~isempty(m_temp.CTD(k).ask1) && ~isempty(m_temp.CTD(k).bid1) && m_temp.CTD(k).ask1~=0 && m_temp.CTD(k).bid1~=0)
        %%%????????????
        IRR = IRRcal(m_temp.fut.bid1,m_temp.CTD(k).ask1,selfdata{2}(k),selfdata{3}(k),selfdata{4}(k),selfdata{5}(k),selfdata{6});
        m_temp.CTD(k).irr = IRR;
        
        if(IRR<0)              
            bigIRR(mark).DBs(bigIRR_i(mark)).CTD = product();
            bigIRR(mark).DBs(bigIRR_i(mark)).CTD = m_temp.CTD(k);
            bigIRR(mark).DBs(bigIRR_i(mark)).fut = m_temp.fut;
            bigIRR(mark).DBs(bigIRR_i(mark)).time = datestr(times,'yyyy/mm/dd HHMMSS');
            
            bigIRR_i(mark) = bigIRR_i(mark)+1;
            bigIRR(mark).DBs(bigIRR_i(mark))= msg();
            
        end
        
    end

end



DBT(mark).DBs(DBT_i(mark))=m_temp;  
      

    
    
DBT_i(mark)=DBT_i(mark)+1;
    
end