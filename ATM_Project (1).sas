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

data bank;
set bank_details;
where user_id in (123, 345);
RUN;

proc print data = bank;
run;

%Let user = 123, 345;

data bank;
set bank_details;
where user_id in (&user.);
RUN;

proc print data = bank;
run;

%MACRO bank_acc(user_id=, pin_=, deposit_amount=, balance=);
%put user_id = &user_id;
%put balance = &balance;
%put pin_ = &pin_;
%put deposit_amount = &deposit_amount;

	data temp;
	user_id = &user_id;
	pin_ = &pin_;
	balance = &balance + &deposit_amount;
	deposit_amount = &deposit_amount;
	run;
	proc print data = temp; 0794664765
	where user_id = &user_id and pin_ = &pin_; 

run;
%MEND bank_acc;
%bank_acc(user_id=345,pin_=2222,deposit_amount=2000,balance=0);


data bank_details;
   modify bank_details temp;                                  
      by user_id;
      select (_iorc_);                                             
   
          when (%sysrc(_sok))do;                                   
             balance = balance;
             deposit_amount = deposit_amount;
             date = today();
             time = time();
             replace;                                              
          end;
   
          when (%sysrc(_dsenmr)) do;                               
             output;                                               
             _error_=0;
          end;
      otherwise do;                                                
         put "An unexpected I/O error has occurred."
         _error_ = 0; 
         stop;
      end;
   end; 
run;

proc print data = work.bank_details;
run;
 
 
 
 
 

 
 










