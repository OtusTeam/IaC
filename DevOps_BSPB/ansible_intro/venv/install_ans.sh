# прописываем зависимости в файле:
echo ansible==9.0.0 > requirements.txt

# в отдельном каталоге создаем и активируем venv:
python3 -m venv .venv
. .venv/bin/activate

# устанавливаем зависимости в эту venv:
python3 -m pip install -r requirements.txt

# что-то делаем в этой среде,

# для выхода:
# deactivate

