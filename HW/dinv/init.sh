sudo apt install python3-venv
# прописываем зависимости в файле:
#echo ansible==2.9 > requirements.txt
echo ansible==10.6.0 		 > requirements.txt
echo grpcio==1.65.4 		>> requirements.txt
echo yandexcloud==0.312.0	>> requirements.txt
#echo grpcio==1.76.0		>> requirements.txt
#echo yandexcloud==0.372.0	>> requirements.txt

# в отдельном каталоге создаем и активируем venv:
python3 -m venv .venv
. .venv/bin/activate
# устанавливаем зависимости в эту venv:
python3 -m pip install -r requirements.txt
