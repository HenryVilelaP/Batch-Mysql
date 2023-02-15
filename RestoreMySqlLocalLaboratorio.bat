d:
cd \Datos\DataSQM

set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

Rem --------------------------------------------------------------------------------------------
Rem Crear las base de datos de laboratorio 
Rem --------------------------------------------------------------------------------------------

del /F /S /Q local_laboratorio.txt

set texto=DROP database  IF EXISTS laboratorio;
echo %texto% >> local_laboratorio.txt 
timeout /t 2 /nobreak

set  texto=CREATE DATABASE laboratorio CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_laboratorio.txt 
timeout /t 2 /nobreak

echo Termino de Limpiar la base de datos de laboratorio en Localhost...

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 < local_laboratorio.txt
timeout /t 2 /nobreak

echo Termino de crear la base de datos de Laboratorio en Localhost...

REM *--------------------------------------------------------------------------------
REM Empaquetado de los archivos generados laboratorio
REM *--------------------------------------------------------------------------------

"C:\Program Files\7-Zip\7z.exe" e "Bak_laboratorio_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 1...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" e "Bak_laboratorio_SP_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 2...
timeout /t 2 /nobreak

echo Termino de desempaquetar los archivos 7zip...

REM *--------------------------------------------------------------------------------
REM Proceso de Restauracion de los datos (Archivos .Sql) laboratorio 
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 laboratorio< "Bak_laboratorio_%VAR_ULTDIA%.Sql" 
echo Termino en proceso restauracion de archivo 1...
timeout /t 2 /nobreak

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 laboratorio< "Bak_laboratorio_SP_%VAR_ULTDIA%.Sql" 
echo Termino en proceso restauracion de archivo 2...
timeout /t 2 /nobreak

echo Termino restauracion de datos en la base de datos...

REM *--------------------------------------------------------------------------------
REM Eliminar los archivos generados laboratorio y SqmPLani
REM *--------------------------------------------------------------------------------

del /F /S /Q "Bak_laboratorio_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 1...
timeout /t 2 /nobreak

del /F /S /Q "Bak_laboratorio_SP_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 2...
timeout /t 2 /nobreak
