d:
cd \Datos\DataSQM

rem  _  set VAR_DD=%date:~,2%
rem  _  echo Fecha: %VAR_DD% 
rem  _  set /A res=VAR_DD - 1
rem  _  echo %res%
rem  _  del /F /S /Q local_laboratorio.txt
rem  _  c:\xampp\mysql\bin\mysqldump -h192.168.1.181 -uroot -pt1s9m.0201 --no-data --no-create-info --routines --triggers --events indicolor > MySQLStoredProcedures.sql

cls

set texto=DROP DATABASE IF EXISTS laboratorio;
echo %texto% >> local_laboratorio.txt 
timeout /t 2 /nobreak
set  texto=CREATE DATABASE laboratorio CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_laboratorio.txt 
timeout /t 2 /nobreak
echo Termino de crear el archivo para procesar...
echo --------------------------------------------
 
c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 < local_laboratorio.txt
timeout /t 2 /nobreak
echo Termino de creae la base de datos de laboratorio en Localhost...
echo -------------------------------------------------------------------


