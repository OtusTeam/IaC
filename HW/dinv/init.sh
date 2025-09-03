sudo apt install python3-venv
# прописываем зависимости в файле:
echo ansible==2.9 > requirements.txt
# для yacloud_compute.py:
echo yandexcloud >> requirements.txt
# в отдельном каталоге создаем и активируем venv:
python3 -m venv .venv
. .venv/bin/activate
# устанавливаем зависимости в эту venv:
python3 -m pip install -r requirements.txt
