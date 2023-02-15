
@echo off

d:
cd \Datos\DataSQM

Rem ++++.............................................................................
cls
echo ---------------------------------------------
echo Proceso de RESTORE sqmdata y sqmplani a LOCAL
echo ---------------------------------------------
echo Ubicacion de los archivos en \Datos\DataSQM
Rem ++++.............................................................................


set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%

Rem *--------------------------------------------------------------------------------
Rem Si queremos que las fechas sean de dias menores aplicar lo siguiente
rem set /A res=VAR_DD - 1
rem set VAR_DD=0%res%
Rem *--------------------------------------------------------------------------------

set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

Rem --------------------------------------------------------------------------------------------
Rem Crear las base de datos de sqmdata y Sqmplani
Rem --------------------------------------------------------------------------------------------

del /F /S /Q local_sqmdata.txt

echo Crear archivo de limpieza de base de datos para sqmdata y Sqmplani en Localhost...

set texto=DROP database  IF EXISTS sqmplani;
echo %texto% >> local_sqmdata.txt 


set texto=CREATE DATABASE sqmplani CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_sqmdata.txt 
timeout /t 1 /nobreak

set texto=DROP database IF EXISTS sqmdata;
echo %texto% >> local_sqmdata.txt 

set  texto=CREATE DATABASE sqmdata CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_sqmdata.txt 

echo Termino de Limpiar la base de datos de sqmdata y Sqmplani en Localhost...
timeout /t 1 /nobreak


c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 < local_sqmdata.txt
timeout /t 1 /nobreak

echo Termino de crear la base de datos SQMDATA y SQMPLANI en Localhost...

pause

REM *--------------------------------------------------------------------------------
REM Empaquetado de los archivos generados sqmdata y SqmPLani
REM *--------------------------------------------------------------------------------

echo ................................
echo Archivos de SOLO estructuras ...
echo ................................
echo "Estructura SQMDATA exluyendo Lab_det_reserva / Clientes / Empleados -> Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.7z"
echo .
echo "Estructura SQMDATA solo lab_det_reserva -> Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.7z"
echo .
echo "Estructura SQMDATA solo Clientes -> Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.7z"
echo .
echo "Estructura SQMDATA solo Empleados -> Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.7z"
echo .
echo "Estructura SQMPLANI exluyendo Empleados -> Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmplani_onlyst_%VAR_ULTDIA%.7z"
echo .
echo "Estructura SQMPLANI solo Empleados -> Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado -> "Bak_sqmplani_onlyst_%VAR_ULTDIA%.7z"
echo ..........................
echo Archivos de solo datos ...
echo ..........................
echo "Desempaqueta archivo de solo Datos SQMDATA - excluyendo a lab_det_reserva -> Bak_SQMDATA1_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_Sqmdata1_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado "Bak_Sqmdata1_%VAR_ULTDIA%.7z"
echo .
echo "Desempaqueta archivo de solo Datos SQMDATA - solo lab_det_reserva -> Bak_SQMDATA2_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_SqmData2_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado "Bak_SqmData2_%VAR_ULTDIA%.7z"
echo .
echo "Desempaqueta archivo de solo Datos SQMPLANI - > Bak_SQMPLANI_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmplani_%VAR_ULTDIA%.7z" -y 
echo Termino desempaquetado "Bak_sqmplani_%VAR_ULTDIA%.7z"
echo ...............................
echo Archivos de Store Procedure ...
echo ...............................

echo "Desempaqueta archivo de SP - SQMDATA - > Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmdata_sp_%VAR_ULTDIA%.7z" -y 
echo Termino de generar empaquetado "Bak_sqmdata_sp_%VAR_ULTDIA%.7z"
echo .
echo "Desempaqueta archivo de SP - SQMPLANI - > Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
"C:\Program Files\7-Zip\7z.exe" e "Bak_sqmplani_sp_%VAR_ULTDIA%.7z" -y 
echo Termino de generar empaquetado "Bak_sqmplani_sp_%VAR_ULTDIA%.7z"

echo ...............................

timeout /t 1 /nobreak



REM *--------------------------------------------------------------------------------
REM Proceso de Restauracion de los datos (Archivos .Sql) sqmdata y SqmPLani
REM *--------------------------------------------------------------------------------

echo Termino de desempaquetar SQMPLANI los archivos 7zip... 
echo .
echo ..
echo ...

echo ................................
echo Archivos de SOLO estructuras ...
echo ................................

echo Procesando restauracion de archivo "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql" 
echo Termino en proceso restauracion de archivo "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmplani< "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmplani< "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"

echo ...............................
echo Archivos de Store Procedure ...
echo ...............................

echo .
echo Procesando restauracion de archivo "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmplani< "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"

echo ...
echo ..
echo .

Pause 

echo .
echo Procesando restauracion de archivo "Bak_Sqmdata1_%VAR_ULTDIA%.sql" 
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_Sqmdata1_%VAR_ULTDIA%.sql" 
echo Termino en proceso restauracion de archivo "Bak_Sqmdata1_%VAR_ULTDIA%.sql" 
echo .
echo Procesando restauracion de archivo "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmdata< "Bak_Sqmdata2_%VAR_ULTDIA%.sql" 
echo Termino en proceso restauracion de archivo "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
echo .
echo Procesando restauracion de archivo "Bak_sqmplani_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysql -h192.168.1.52 -uroot -ps9ms1st3m4s --port=3306 sqmplani< "Bak_sqmplani_%VAR_ULTDIA%.sql"
echo Termino en proceso restauracion de archivo "Bak_sqmplani_%VAR_ULTDIA%.sql"


echo ...
echo ..
echo .

timeout /t 1 /nobreak

echo Termino restauracion de datos en la base de datos...

REM *--------------------------------------------------------------------------------
REM Eliminar los archivos generados sqmdata y SqmPLani
REM *--------------------------------------------------------------------------------

del /F /S /Q  "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
del /F /S /Q  "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
del /F /S /Q  "Bak_sqmplani_onlyst_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmplani_onlyst_%VAR_ULTDIA%.sql"


del /F /S /Q  "Bak_Sqmdata1_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_Sqmdata1_%VAR_ULTDIA%.sql"
del /F /S /Q  "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
echo Eliminar archivo  "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
del /F /S /Q  "Bak_sqmplani_%VAR_ULTDIA%.sql"
echo Eliminar archivo  "Bak_sqmplani_%VAR_ULTDIA%.sql"


del /F /S /Q  "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
del /F /S /Q  "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"

timeout /t 1 /nobreak

pause
