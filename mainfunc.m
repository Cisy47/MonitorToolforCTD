
function mainfunc

    clear;

    global DBT_i;
    global bigIRR_i;
    global DBT;
    global bigIRR;
    global productMap;

    DBT = DBsum();
    DBT(1:6) = DBsum();
    bigIRR = DBsum();
    bigIRR(1:6) = DBsum();
    DBT_i(1:6)=1;
    bigIRR_i(1:6)=1;
    productMap= containers.Map;
    
    w = windmatlab;

    %codes = w.wset('sectorconstituent','date=2017-04-14;sectorid=1000010190000000');

    % TFset=w.wss('TF00.CFE,TF01.CFE,TF02.CFE,T00.CFE,T01.CFE,T02.CFE','trade_hiscode');
    % 
    % %%%??????????
    % lldate = datenum(w.wss(TFset,'lastdelivery_date'))-1;
    % 
    % %%%??????CTD
    % TF00=w.wset('sectorconstituent',';sectorid=1000010190000000');
    % TF01=w.wset('sectorconstituent',';sectorid=1000010193000000');
    % TF02=w.wset('sectorconstituent',';sectorid=1000010196000000');
    % 
    % T00=w.wset('sectorconstituent',';sectorid=1000016389000000');
    % T01=w.wset('sectorconstituent',';sectorid=1000016392000000');
    % T02=w.wset('sectorconstituent',';sectorid=1000016395000000');
    % 
    % %%%????????
    % cvt_TF00 = w.wss(TF00(:,2),'tbf_cvf',strcat('contractCode=',TF1706.cfe'));
    % 
    % %codes = '000002.sz,600887.sh,603300.sh';
    % %%%????????
    % intst_TF00=w.wss(TF00(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(1),'yyyymmdd')));
    % intst_TF01=w.wss(TF01(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(2),'yyyymmdd')));
    % intst_TF02=w.wss(TF02(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(3),'yyyymmdd')));
    % intst_T00=w.wss(T00(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(4),'yyyymmdd')));
    % intst_T01=w.wss(T01(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(5),'yyyymmdd')));
    % intst_T02=w.wss(T02(:,2),'calc_accrint',strcat('tradeDate=',datestr(lldate(6),'yyyymmdd')));
    % 
    % %%%??????????
    % nxcupn_TF00 = w.wss(TF00(:,2),'nxcupn','');
    % nxcupn_TF01 = w.wss(TF01(:,2),'nxcupn','');
    % nxcupn_TF02 = w.wss(TF02(:,2),'nxcupn','');
    % nxcupn_T00 = w.wss(T00(:,2),'nxcupn','');
    % nxcupn_T01 = w.wss(T01(:,2),'nxcupn','');
    % nxcupn_T02 = w.wss(T02(:,2),'nxcupn','');
    % 
    % %%%????????????
    % for k=1:1:length(TF01(:,2))
    %     nxcupn_TF01_b(k) = w.wss(TF01(k,2),'nxcupn',strcat('tradeDate=',nxcupn_TF01(k)));
    % end
    % for k=1:1:length(TF02(:,2))
    %     nxcupn_TF02_b(k) = w.wss(TF02(k,2),'nxcupn',strcat('tradeDate=',nxcupn_TF02(k)));
    % end
    % for k=1:1:length(TF00(:,2))
    %     nxcupn_TF00_b(k) = w.wss(TF00(k,2),'nxcupn',strcat('tradeDate=',nxcupn_TF00(k)));
    % end
    % for k=1:1:length(T00(:,2))
    %     nxcupn_T00_b(k) = w.wss(T00(k,2),'nxcupn',strcat('tradeDate=',nxcupn_T00(k)));
    % end
    % for k=1:1:length(T01(:,2))
    %     nxcupn_T01_b(k) = w.wss(T01(k,2),'nxcupn',strcat('tradeDate=',nxcupn_T01(k)));
    % end
    % for k=1:1:length(T02(:,2))
    %     nxcupn_T02_b(k) = w.wss(T02(k,2),'nxcupn',strcat('tradeDate=',nxcupn_T02(k)));
    % end
    % 
    % 
    % %%%????????????
    % bonus_TF00 = w.wss(TF00(:,2),'couponrate2')./double(w.wss(TF00(:,2),'interestfrequency'));
    % bonus_TF01 = w.wss(TF01(:,2),'couponrate2')./double(w.wss(TF01(:,2),'interestfrequency'));
    % bonus_TF02 = w.wss(TF02(:,2),'couponrate2')./double(w.wss(TF02(:,2),'interestfrequency'));
    % bonus_T00 = w.wss(T00(:,2),'couponrate2')./double(w.wss(T00(:,2),'interestfrequency'));
    % bonus_T01 = w.wss(T01(:,2),'couponrate2')./double(w.wss(T01(:,2),'interestfrequency'));
    % bonus_T02 = w.wss(T02(:,2),'couponrate2')./double(w.wss(T02(:,2),'interestfrequency'));
    % 
    % %%%????????
    % j_temp = (datenum(nxcupn_TF00)<lldate(1))+(datenum(nxcupn_TF00_b)<lldate(1));
    % for k=1:1:length(nxcupn_TF00)    
    %     if(j_temp(k) == 0)
    %         pmt_TF00(k) = 0;
    %     elseif(j_temp(k) == 1)
    %         pmt_TF00(k) = bonus_TF00(k);
    %     elseif(j_temp(k) == 2)
    %         pmt_TF00(k) = bonus_TF00(k)*2;
    %     end   
    % end
    % 
    % TF00_set = {TFset{1},TF00{:,2}};
    % TF01_set = {TFset{2},TF01{:,2}};
    % TF02_set = {TFset{3},TF02{:,2}};
    % 
    % T00_set = {TFset{1},T00{:,2}};
    % T01_set = {TFset{2},T01{:,2}};
    % T02_set = {TFset{3},T02{:,2}};

    %%%1set;2????????????????????????????
    TF00 = InputData(w,'TF00');
    TF01 = InputData(w,'TF01');
    TF02 = InputData(w,'TF02');
    T00 = InputData(w,'T00');
    T01 = InputData(w,'T01');
    T02 = InputData(w,'T02');

    fields = 'rt_ask1,rt_bid1,rt_bsize1,rt_asize1,rt_time';



    w.wsq(TF00{1},fields,@myCallback,[1,TF00{2}]);
    w.wsq(TF01{1},fields,@myCallback,[2,TF01{2}]);
    w.wsq(TF02{1},fields,@myCallback,[3,TF02{2}]);
    w.wsq(T00{1},fields,@myCallback,[4,T00{2}]);
    w.wsq(T01{1},fields,@myCallback,[5,T01{2}]);
    w.wsq(T02{1},fields,@myCallback,[6,T02{2}]);


end



