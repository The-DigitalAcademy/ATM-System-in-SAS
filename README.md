# ATM-System-in-SAS
data work.details;
  input user_id pin fname $ lname $ balance;
  format balance rand8.2;
  datalines;
  123 2010 Edwin Ngoveni 500
  345 2222 Nontando Masimula 0
  567 1212 Anna Mofokeng 500
  789 1234 Wayne Sithole 10000
  910 1997 Mpumi Phiri 6000
  ;
   proc print data=details;
RUN;

data work.history;
  input user_id date ddmmyy10. time time6. withdraw_amount deposit_amount;
  format date date10.;
  format time hhmm.;
  format withdraw_amount rand8.2;
  format deposit_amount rand8.2;
  datalines;
  123 01/04/2022 10:00 0 0
  345 20/09/2022 13:30 0 0 
  567 02/02/2022 09:20 0 0
  789 13/10/2022 17:50 0 0
  910 25/11/2022 20:03 0 0
  ;
  run;
proc print data=work.history;
RUN;

proc sort data = work.details;
by user_id;
run;

proc sort data = work.history;
by user_id;
run;

Data bank_details;        
Merge details history;
by user_id;
run;

proc print data=bank_details;
  title 'ATM Management System';
run; 