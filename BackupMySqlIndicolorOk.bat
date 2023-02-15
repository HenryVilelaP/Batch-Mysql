d:
cd \Datos\DataSQM

REM *--------------------------------------------------------------------------------
REM Este archivo general el backup de INDICOLOR para que despues de vuelva a restaurar 
REM en el modo local. Desarrollado por DVP el 20/04/2019 
REM *--------------------------------------------------------------------------------

set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

REM *--------------------------------------------------------------------------------
REM Backup Base de datos Indicolor y SqmPLani 
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysqldump --user=root --password=t1s9m.0201  --port=3306 --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.1.181 indicolor> "Bak_Indicolor_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_Indicolor_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak

c:\xampp\mysql\bin\mysqldump --user=root --password=t1s9m.0201  --port=3306 --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.1.181 sqmplani> "Bak_IndiPlani_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_IndiPlani_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak

REM *--------------------------------------------------------------------------------
REM Backup de los STORE Procedure  Indicolor y SqmPLani
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysqldump -h192.168.1.181 -uroot -pt1s9m.0201 --no-data --no-create-info --routines --triggers --events indicolor > "Bak_Indicolor_SP_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_Indicolor_SP_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak


c:\xampp\mysql\bin\mysqldump -h192.168.1.181 -uroot -pt1s9m.0201 --no-data --no-create-info --routines --triggers --events sqmplani > "Bak_IndiPlani_SP_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_IndiPlani_SP_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak

REM *--------------------------------------------------------------------------------
REM Empaquetado de los archivos generados Indicolor y SqmPLani
REM *--------------------------------------------------------------------------------

"C:\Program Files\7-Zip\7z.exe" a "Bak_Indicolor_%VAR_ULTDIA%.7z" "Bak_Indicolor_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 1...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" a "Bak_IndiPlani_%VAR_ULTDIA%.7z" "Bak_IndiPlani_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 2...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" a "Bak_Indicolor_SP_%VAR_ULTDIA%.7z" "Bak_Indicolor_SP_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 3...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" a "Bak_IndiPlani_SP_%VAR_ULTDIA%.7z" "Bak_IndiPlani_SP_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 4...
timeout /t 2 /nobreak

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

