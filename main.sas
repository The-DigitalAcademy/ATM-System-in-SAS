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