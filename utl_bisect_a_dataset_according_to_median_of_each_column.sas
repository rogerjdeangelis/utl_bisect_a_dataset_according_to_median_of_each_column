
Bisect a dataset according to median of each column

github
https://tinyurl.com/y97gv7dx
https://github.com/rogerjdeangelis/utl_bisect_a_dataset_according_to_median_of_each_column

inspired by (not exactly the same problem but the variation is minimal.
https://stackoverflow.com/questions/51036614/bisect-a-data-frame-according-to-median-of-each-column


INPUT
=====

 SASHELP.CLASS total obs=19

  NAME       SEX    AGE    HEIGHT    WEIGHT

  Alfred      M      14     69.0      112.5
  Alice       F      13     56.5       84.0
  Barbara     F      13     65.3       98.0
  Carol       F      14     62.8      102.5
  Henry       M      14     63.5      102.5
  James       M      12     57.3       83.0
  Jane        F      12     59.8       84.5

EXAMPLE OUTPUT

 WORK.WANT total obs=19

   NAME       SEX    AGE    HEIGHT    WEIGHT    AGEMID    HGTMID    WGTMID

   Alfred      M      14     69.0      112.5    ABOVE     ABOVE     ABOVE
   Alice       F      13     56.5       84.0    BELOW     BELOW     BELOW
  ...


PROCESS
=======

data want;

 if _n_=0 then do;
    %let rc=%sysfunc(dosubl('
        proc sql;
           select
              median(age)
             ,median(height)
             ,median(weight)
           into
             :_age     trimmed
             ,:_height trimmed
             ,:_weight trimmed
           from
             sashelp.class
        ;quit;
    '));
  end;

  set sashelp.class;

  * use do_over if many columns;
  if age    <= &_age    then ageMid='BELOW'; else ageMid='ABOVE';
  if height <= &_height then hgtMid='BELOW'; else hgtMid='ABOVE';
  if weight <= &_weight then wgtMid='BELOW'; else wgtMid='ABOVE';

run;quit;


OUTPUT
======


 WORK.WANT total obs=19

   NAME       SEX    AGE    HEIGHT    WEIGHT    AGEMID    HGTMID    WGTMID

   Alfred      M      14     69.0      112.5    ABOVE     ABOVE     ABOVE
   Alice       F      13     56.5       84.0    BELOW     BELOW     BELOW
   Barbara     F      13     65.3       98.0    BELOW     ABOVE     BELOW
   Carol       F      14     62.8      102.5    ABOVE     BELOW     ABOVE
   Henry       M      14     63.5      102.5    ABOVE     ABOVE     ABOVE
   James       M      12     57.3       83.0    BELOW     BELOW     BELOW
   Jane        F      12     59.8       84.5    BELOW     BELOW     BELOW
   Janet       F      15     62.5      112.5    ABOVE     BELOW     ABOVE
   Jeffrey     M      13     62.5       84.0    BELOW     BELOW     BELOW
   John        M      12     59.0       99.5    BELOW     BELOW     BELOW
   Joyce       F      11     51.3       50.5    BELOW     BELOW     BELOW
   Judy        F      14     64.3       90.0    ABOVE     ABOVE     BELOW
   Louise      F      12     56.3       77.0    BELOW     BELOW     BELOW
   Mary        F      15     66.5      112.0    ABOVE     ABOVE     ABOVE
   Philip      M      16     72.0      150.0    ABOVE     ABOVE     ABOVE
   Robert      M      12     64.8      128.0    BELOW     ABOVE     ABOVE
   Ronald      M      15     67.0      133.0    ABOVE     ABOVE     ABOVE
   Thomas      M      11     57.5       85.0    BELOW     BELOW     BELOW
   William     M      15     66.5      112.0    ABOVE     ABOVE     ABOVE

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

just use sashelp.class

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

see process


