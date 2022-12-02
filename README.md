# ATM-System-in-SAS
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