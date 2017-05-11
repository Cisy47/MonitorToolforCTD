function [ data ] = InputData( w,fut )
%INPUTDATA Summary of this function goes here
%   Detailed explanation goes here

    %%%fut code
    Fcode=w.wss(fut,'trade_hiscode');

    %%%���ɿ���
    lldate = datenum(w.wss(Fcode,'lastdelivery_date'))-1;

    %%%���м�CTD    
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

    %%%ת������
    cvt = w.wss(F_CTD,'tbf_cvf',strcat('contractCode=',Fcode));

    %codes = '000002.sz,600887.sh,603300.sh';
    %%%������Ϣ
    intst=w.wss(F_CTD,'calc_accrint',strcat('tradeDate=',datestr(lldate,'yyyymmdd')));

    %%%��һ��Ϣ��
    nxcupn = w.wss(F_CTD,'nxcupn','');

    %%%����һ��Ϣ��
    for k=1:1:length(F_CTD)
        nxcupn_b(k) = w.wss(F_CTD(k),'nxcupn',strcat('tradeDate=',nxcupn(k)));
    end

    %%%ÿ�θ�Ϣ���
    bonus = w.wss(F_CTD,'couponrate2')./double(w.wss(F_CTD,'interestfrequency'));


    %%%���丶Ϣ
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

    %%%����Ӧ����Ϣ
    acc_intst=w.wss(F_CTD,'calc_accrint','');
    
    
    F_set = [F_CTD{:},Fcode];


    %%%��ţ����룬ת�����ӣ�������Ϣ��������Ϣ��Ӧ����Ϣ�����ɿ���,
    T_self = {cvt,intst,pmt,acc_intst,lldate};
    
    data = {F_set,T_self};

end

