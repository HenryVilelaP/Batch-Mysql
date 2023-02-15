echo .
echo Generando archivos usuarios y privilegios...
echo .
set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
Rem *--------------------------------------------------------------------------------
Rem Si queremos que las fechas sean de dias menores aplicar lo siguiente
Rem set /A res=VAR_DD - 1
Rem set VAR_DD=%res%
Rem *--------------------------------------------------------------------------------
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "select concat('SHOW GRANTS FOR \'',user,'\'@\'',host,'\'; ') from mysql.user where user != 'root'" > "Bak_users_%VAR_ULTDIA%.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'accesoweb'@'%';" > "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sistemas'@'%';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmprueba'@'%';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmsistemas'@'%';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmweb'@'%';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmprueba'@'localhost';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmsistemas'@'localhost';" >> "Bak_user_privilegios.sql"
echo .
c:\xampp\mysql\bin\mysql -h192.168.1.179 -uroot -pti$qm@si --port=3306 -BNe "SHOW GRANTS FOR 'sqmweb'@'localhost';" >> "Bak_user_privilegios.sql"
echo .

pause
