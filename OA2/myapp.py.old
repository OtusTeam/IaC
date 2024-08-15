"""
Copyright (c) 2023 Aleksey E. Jhuravlev
"""

import os
import time
import random

ZODIAC_DIRECTORY = '/tmp/web'
zodiac_signs = [
    "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
    "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"
]

month_name = ['Yan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

cont = 'for the groom Cancer and the bride Capricorn a favorable forecast for the wedding in the 10th month of 2024'


def generate_html_page(content):
    # Функция для генерации HTML-страницы с заданным содержимым
    html_template = '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Forecast</title>
    </head>
    <body>
        <h1>[Place for rent] Forecast: [Place for rent]</h1>
        {}
    </body>
    </html>
    '''.format(content)

    return html_template


# print(generate_html_page(cont))
# print('hello')


file_path = os.path.join(ZODIAC_DIRECTORY, "forecast.html")

# Проверка существования каталога и его создание при необходимости
if not os.path.exists(ZODIAC_DIRECTORY):
        os.makedirs(ZODIAC_DIRECTORY)

while True:
    with open(file_path, "w") as file:
        file.write(generate_html_page(
            'For the groom {} and the bride {} a favorable forecast for the wedding in the {} month of 2024'.
            format(random.choice(zodiac_signs), random.choice(zodiac_signs), str(random.choice(month_name)))))

    # Пауза в 5 секунд
    time.sleep(5)
