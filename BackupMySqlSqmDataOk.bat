@echo off
d:
cd \Datos\DataSQM

Rem ++++.............................................................................
cls
echo ------------------------------------------
echo Proceso de BACKUP PARA sqmdata y sqmplani
echo ------------------------------------------
echo Ubicacion de los archivos en \Datos\DataSQM
Rem ++++.............................................................................


REM *--------------------------------------------------------------------------------
REM Este archivo general el backup de sqmdata para que despues de vuelva a restaurar 
REM en el modo local. Desarrollado por DVP el 20/04/2019 
REM *--------------------------------------------------------------------------------
set VAR_YYYY=%date:~6,4%
set VAR_MM=%date:~3,2%
set VAR_DD=%date:~,2%
Rem *--------------------------------------------------------------------------------
Rem Si queremos que las fechas sean de dias menores aplicar lo siguiente
Rem set /A res=VAR_DD - 1
Rem set VAR_DD=%res%
Rem *--------------------------------------------------------------------------------
set VAR_ULTDIA=%VAR_YYYY%%VAR_MM%%VAR_DD%

Rem ++++.............................................................................
echo Definición de variables  VAR_ULTDIA / VAR_YYYY / VAR_MM / VAR_DD

timeout /t 1 /nobreak


REM *--------------------------------------------------------------------------------
REM Backup Base de datos sqmdata y SqmPLani 
REM *--------------------------------------------------------------------------------
Rem ++++.............................................................................
echo Proceso de generación de BACKUP....
Rem ++++.............................................................................
echo .
echo Generando archivos de solo estructuras ...
echo .
echo "Backup estructura SQMDATA exluyendo Lab_det_reserva / Clientes / Empleados -> Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data --ignore-table=sqmdata.lab_det_reserva  --ignore-table=sqmdata.clientes --ignore-table=sqmdata.empleados sqmdata> "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
echo .
echo "Backup estructura SQMDATA solo lab_det_reserva -> Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data sqmdata lab_det_reserva> "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo .
echo "Backup estructura SQMDATA solo Clientes -> Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data sqmdata clientes> "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
echo .
echo "Backup estructura SQMDATA solo Empleados -> Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data sqmdata empleados> "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
echo .
echo "Backup estructura SQMPLANI exluyendo Empleados -> Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data --ignore-table=sqmplani.empleados sqmplani> "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
echo .
echo "Backup estructura SQMPLANI solo Empleados -> Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --host=192.168.1.179 --user=root --password=ti$qm@si --port=3306 --default-character-set=utf8 --lock-tables=false --no-data  sqmplani empleados> "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"

timeout /t 1 /nobreak

Rem ++++.............................................................................
echo Generando archivos de solo datos ...
Rem ++++.............................................................................
echo .

echo "Backup solo Datos SQMPLANI - > Bak_SQMPLANI_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --port=3306 --routines=false --triggers=false --events=false --lock-tables=false --hex-blob  --default-character-set=utf8 --host=192.168.1.179  sqmplani> "Bak_sqmplani_%VAR_ULTDIA%.sql"
echo .
echo "Backup solo Datos SQMDATA - solo lab_det_reserva -> Bak_SQMDATA2_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --port=3306 --routines=false --triggers=false --events=false --lock-tables=false --hex-blob  --default-character-set=utf8 --host=192.168.1.179  sqmdata lab_det_reserva> "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
echo .
echo "Backup solo Datos SQMDATA - excluyendo a lab_det_reserva -> Bak_SQMDATA1_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --port=3306 --routines=false --triggers=false --events=false --lock-tables=false --hex-blob  --default-character-set=utf8 --host=192.168.1.179 --ignore-table=sqmdata.lab_det_reserva sqmdata> "Bak_Sqmdata1_%VAR_ULTDIA%.sql"

timeout /t 1 /nobreak
echo .
Rem ++++.............................................................................
echo Generando archivos de solo SP / Trigger y Otros ...
Rem ++++.............................................................................

echo .
echo "Backup de solo Stored Procedure SQMDATA Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --port=3306 --host=192.168.1.179 --triggers  --events --routines --no-create-info --no-data --no-create-db --skip-opt  --default-character-set=utf8  sqmdata> "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
echo .
echo "Backup de solo Stored Procedure SQMPLANI Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --port=3306 --host=192.168.1.179 --triggers  --events --routines --no-create-info --no-data --no-create-db --skip-opt  --default-character-set=utf8  sqmplani> "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
echo .
Rem ++++.............................................................................
echo Termino de generar backup 

timeout /t 1 /nobreak

Rem ++++.............................................................................
echo Proceso de Empaquetado de los archivos de BACKUP....

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.7z" "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.7z" "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.7z" "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.7z" "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.7z" "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.7z" "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.7z"



"C:\Program Files\7-Zip\7z.exe" a "Bak_Sqmdata1_%VAR_ULTDIA%.7z" "Bak_Sqmdata1_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_Sqmdata1_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_Sqmdata2_%VAR_ULTDIA%.7z" "Bak_Sqmdata2_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_Sqmdata2_%VAR_ULTDIA%.7z"

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmplani_%VAR_ULTDIA%.7z" "Bak_sqmplani_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmplani_%VAR_ULTDIA%.7z"


"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmdata_sp_%VAR_ULTDIA%.7z" "Bak_sqmdata_sp_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmdata_sp_%VAR_ULTDIA%.7z" 

"C:\Program Files\7-Zip\7z.exe" a "Bak_sqmplani_sp_%VAR_ULTDIA%.7z" "Bak_sqmplani_sp_%VAR_ULTDIA%.sql"
echo Termino de generar empaquetado "Bak_sqmplani_sp_%VAR_ULTDIA%.7z"

timeout /t 1 /nobreak

REM *--------------------------------------------------------------------------------
REM Eliminar los archivos generados sqmdata y SqmPLani
REM *--------------------------------------------------------------------------------


del /F /S /Q "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst1_%VAR_ULTDIA%.sql"

del /F /S /Q "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst2_%VAR_ULTDIA%.sql"

del /F /S /Q "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst3_%VAR_ULTDIA%.sql"

del /F /S /Q "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmdata_onlyst4_%VAR_ULTDIA%.sql"

del /F /S /Q "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmplani_onlyst1_%VAR_ULTDIA%.sql"

del /F /S /Q  "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"
echo Eliminar archivo "Bak_sqmplani_onlyst2_%VAR_ULTDIA%.sql"


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

echo ------------------------------------------
echo Termino
echo ------------------------------------------

Pause

 