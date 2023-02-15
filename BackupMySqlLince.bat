d:
cd \Datos\DataSQM

c:\xampp\mysql\bin\mysqldump --user=laboratorio --password=d3b14nfw123 --port=3306 --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.10.100 laboratorio> BakLaboratorio_20190429_ultimo.sql

"C:\Program Files\7-Zip\7z.exe" a "BakLaboratorio_20190429_ultimo.7z" "BakLaboratorio_20190429_ultimo.sql"

del BakLaboratorio_20190429_ultimo.sql /y
