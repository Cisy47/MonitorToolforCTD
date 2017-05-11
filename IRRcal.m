function [ IRR ] = IRRcal( fut, CTD, cvt, intst, pmt ,acc_intst, lldate)
%IRRCAL Summary of this function goes here
%   Detailed explanation goes here
    fut_cvt = fut.*cvt;
    fapiao = fut_cvt + intst;
    quanjia = CTD + acc_intst;
    IRR = (fapiao - quanjia + pmt)./(quanjia - pmt) *365 / (lldate-datenum(today()));

end

