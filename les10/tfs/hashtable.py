import random
import string

# Пустая хештаблица (словарь), ключи будут появляться по мере добавления значений
table = {}

# 10 итераций: выбираем случайный ключ из A/B/C, генерируем значение и добавляем в список
for i in range(10):
    key = random.choice(["A", "B", "C"])  # случайный ключ
    # случайное значение — строка длиной 6 из букв и цифр
    value = ''.join(random.choices(string.ascii_letters + string.digits, k=6))

    # Печать выбранного ключа и сгенерированного значения
    print(f"iter {i}: key={key}, value={value}")

    # Если ключа ещё нет в таблице — создать список; затем добавить значение
    table.setdefault(key, []).append(value)

# После заполнения печатаем списки значений для всех ключей в отсортированном порядке ключей
for key in sorted(table.keys()):
    print(f"{key}: {table[key]}")
