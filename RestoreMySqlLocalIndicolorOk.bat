d:
cd \Datos\DataSQM

set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%


Rem --------------------------------------------------------------------------------------------
Rem Crear las base de datos de Indicolor y Sqmplani
Rem --------------------------------------------------------------------------------------------

del /F /S /Q local_indicolor.txt

set texto=DROP database  IF EXISTS sqmplani;
echo %texto% >> local_indicolor.txt 
timeout /t 2 /nobreak

set texto=CREATE DATABASE sqmplani CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_indicolor.txt 
timeout /t 2 /nobreak

set texto=DROP database  IF EXISTS indicolor;
echo %texto% >> local_indicolor.txt 
timeout /t 2 /nobreak

set  texto=CREATE DATABASE indicolor CHARACTER SET utf8 COLLATE utf8_spanish2_ci;
echo %texto% >> local_indicolor.txt 
timeout /t 2 /nobreak

echo Termino de Limpiar la base de datos de Indicolor y Sqmplani en Localhost...

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 < local_indicolor.txt
timeout /t 2 /nobreak

echo Termino de crear la base de datos de SQMPLANI en Localhost...

REM *--------------------------------------------------------------------------------
REM Empaquetado de los archivos generados Indicolor y SqmPLani
REM *--------------------------------------------------------------------------------

"C:\Program Files\7-Zip\7z.exe" e "Bak_Indicolor_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 1...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" e "Bak_IndiPlani_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 2...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" e "Bak_Indicolor_SP_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 3...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" e "Bak_IndiPlani_SP_%VAR_ULTDIA%.7z" 
echo Termino de desempaquetar 4...
timeout /t 2 /nobreak

echo Termino de desempaquetar los archivos 7zip...

REM *--------------------------------------------------------------------------------
REM Proceso de Restauracion de los datos (Archivos .Sql) Indicolor y SqmPLani
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysql --user=root --password=987654321 --host=localhost sqmplani< "Bak_IndiPlani_%VAR_ULTDIA%.sql"  
echo Termino en proceso restauracion de archivo 2...
timeout /t 2 /nobreak

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 indicolor< "Bak_Indicolor_%VAR_ULTDIA%.Sql" 
echo Termino en proceso restauracion de archivo 1...
timeout /t 2 /nobreak


c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 indicolor< "Bak_Indicolor_SP_%VAR_ULTDIA%.Sql" 
echo Termino en proceso restauracion de archivo 3...
timeout /t 2 /nobreak

c:\xampp\mysql\bin\mysql -hlocalhost -uroot -p987654321 --port=3306 sqmplani< "Bak_IndiPlani_SP_%VAR_ULTDIA%.Sql"   
echo Termino en proceso restauracion de archivo 4...
timeout /t 2 /nobreak

echo Termino restauracion de datos en la base de datos...

REM *--------------------------------------------------------------------------------
REM Eliminar los archivos generados Indicolor y SqmPLani
REM *--------------------------------------------------------------------------------

del /F /S /Q "Bak_Indicolor_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 1...
timeout /t 2 /nobreak

del /F /S /Q "Bak_IndiPlani_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 2...
timeout /t 2 /nobreak

del /F /S /Q "Bak_Indicolor_SP_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 3...
timeout /t 2 /nobreak

del /F /S /Q "Bak_IndiPlani_SP_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 4...
timeout /t 2 /nobreak

