d:
cd \Datos\DataSQM

REM *--------------------------------------------------------------------------------
REM Este archivo general el backup de LABORATORIO para que despues de vuelva a restaurar 
REM en el modo local. Desarrollado por DVP el 20/04/2019 
REM *--------------------------------------------------------------------------------

set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

REM *--------------------------------------------------------------------------------
REM Backup Base de datos LABORATORIO
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysqldump --user=root --password=t1s9m.2017  --port=3306 --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.10.100 laboratorio> "Bak_laboratorio_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_Laboratorio_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak

REM *--------------------------------------------------------------------------------
REM Backup de los STORE Procedure  Laboratorio
REM *--------------------------------------------------------------------------------

c:\xampp\mysql\bin\mysqldump -h192.168.10.100 -uroot -pt1s9m.2017 --no-data --no-create-info --routines --triggers --events laboratorio > "Bak_laboratorio_SP_%VAR_ULTDIA%.sql"

echo Termino de generar backup "Bak_laboratorio_SP_%VAR_ULTDIA%.sql"...
timeout /t 2 /nobreak

REM *--------------------------------------------------------------------------------
REM Empaquetado de los archivos generados Laboratorio
REM *--------------------------------------------------------------------------------

"C:\Program Files\7-Zip\7z.exe" a "Bak_laboratorio_%VAR_ULTDIA%.7z" "Bak_laboratorio_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 1...
timeout /t 2 /nobreak

"C:\Program Files\7-Zip\7z.exe" a "Bak_laboratorio_SP_%VAR_ULTDIA%.7z" "Bak_laboratorio_SP_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado 3...
timeout /t 2 /nobreak

REM *--------------------------------------------------------------------------------
REM Eliminar los archivos generados Laboratorio
REM *--------------------------------------------------------------------------------

del /F /S /Q "Bak_laboratorio_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 1...
timeout /t 2 /nobreak

del /F /S /Q "Bak_laboratorio_SP_%VAR_ULTDIA%.sql"
echo Termino de eliminar archivo 3...
timeout /t 2 /nobreak

