d:
cd \Datos\DataSQM

c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.1.179 sqmdata> BakSqmData_20190429_ultimo.sql

c:\xampp\mysql\bin\mysqldump --user=root --password=ti$qm@si  --routines=TRUE --extended-insert=false --lock-tables=false --hex-blob --triggers=true --default-character-set=utf8 --host=192.168.1.179 sqmplani> BakSqmPlani_20190429_ultimo.sql

"C:\Program Files\7-Zip\7z.exe" a "BakSqmData_20190429_ultimo.7z" "BakSqmData_20190429_ultimo.sql"

"C:\Program Files\7-Zip\7z.exe" a "BakSqmPlani_20190429_ultimo.7z" "BakSqmPlani_20190429_ultimo.sql"

del BakSqmData_20190429_ultimo.sql /y

del BakSqmPlani_20190429_ultimo.sql /y