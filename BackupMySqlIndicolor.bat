set CUR_YYYY=%date:~6,4%
set CUR_MM=%date:~3,2%
set CUR_DD=%date:~,2%
set hora=%TIME:~,2%
set min=%TIME:~3,2%
set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%
c:\xampp\mysql\bin\mysqldump --user=sistemas --password=informatica  --port=3304 --routines=TRUE --host=192.168.1.79 indicolor> "BakupIndicolor %SUBFILENAME% %hora%%min%.sql"
