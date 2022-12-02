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
  123 01/04/2022 10:00 200 700
  345 20/09/2022 13:30 500 15000 
  567 02/02/2022 09:20 0 5000
  789 13/10/2022 17:50 3000 0
  910 25/11/2022 20:03 1000 0
  ;
proc print data=history;
RUN;

proc sort data = details;
by user_id;
run;

proc sort data = history;
by user_id;
run;

Data bank_details;        
Merge details history;
by user_id;
run;

proc print data=bank_details;
  title 'ATM Management System';
run; 




%MACRO bank(id_, deposit);
proc print data = work.details;
%if user_id =&id_ %then %do;
balance = balance  + deposit;

run;
%MEND;
%bank(345,500);


%MACRO bank(id_, balance_);
proc print data = work.details;
where user_id = &id_ and balance = &balance_;
   TITLE "Sales as of &SYSDAY &SYSDATE";
run;
%MEND;

%bank(345,500);












