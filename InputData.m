function [ data ] = InputData( w,fut )
%INPUTDATA Summary of this function goes here
%   Detailed explanation goes here

    %%%fut code
    Fcode=w.wss(fut,'trade_hiscode');

    %%%最后缴款日
    lldate = datenum(w.wss(Fcode,'lastdelivery_date'))-1;

    %%%银行间CTD    
    switch fut
        case 'TF00'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000010190000000');
            F_CTD = F_CTD_temp(:,2);
        case 'TF01'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000010193000000');
            F_CTD = F_CTD_temp(:,2);            
        case 'TF02'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000010196000000');
            F_CTD = F_CTD_temp(:,2);           
        case 'T00'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000016389000000');
            F_CTD = F_CTD_temp(:,2);            
        case 'T01'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000016392000000');
            F_CTD = F_CTD_temp(:,2);            
        case 'T02'
            F_CTD_temp = w.wset('sectorconstituent',';sectorid=1000016395000000');
            F_CTD = F_CTD_temp(:,2);
        otherwise
            disp('*****************WRONG CODE!*******************');
    end

    %%%转换因子
    cvt = w.wss(F_CTD,'tbf_cvf',strcat('contractCode=',Fcode));

    %codes = '000002.sz,600887.sh,603300.sh';
    %%%交割利息
    intst=w.wss(F_CTD,'calc_accrint',strcat('tradeDate=',datestr(lldate,'yyyymmdd')));

    %%%下一付息日
    nxcupn = w.wss(F_CTD,'nxcupn','');

    %%%下下一付息日
    for k=1:1:length(F_CTD)
        nxcupn_b(k) = w.wss(F_CTD(k),'nxcupn',strcat('tradeDate=',nxcupn(k)));
    end

    %%%每次付息额度
    bonus = w.wss(F_CTD,'couponrate2')./double(w.wss(F_CTD,'interestfrequency'));


    %%%区间付息
    j_temp = (datenum(nxcupn)<lldate)+(datenum(nxcupn_b)<lldate);
    for k=1:1:length(nxcupn)
        if(j_temp(k) == 0)
            pmt(k) = 0;
        elseif(j_temp(k) == 1)
            pmt(k) = bonus(k);
        elseif(j_temp(k) == 2)
            pmt(k) = bonus(k)*2;
        end
    end

    %%%当日应计利息
    acc_intst=w.wss(F_CTD,'calc_accrint','');
    
    
    F_set = [F_CTD{:},Fcode];


    %%%编号，代码，转换因子，交割利息，区间利息，应计利息，最后缴款日,
    T_self = {cvt,intst,pmt,acc_intst,lldate};
    
    data = {F_set,T_self};

end

