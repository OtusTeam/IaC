"""
MIT License

Copyright (c) 2023 Aleksey E. Jhuravlev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
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

while True:
    # Генерация случайного знака зодиака
    # random_zodiac_sign = random.choice(zodiac_signs)

    # random_zodiac_sign = random.choice(zodiac_signs)

    file_path = os.path.join(ZODIAC_DIRECTORY, "forecast.html")

    # Проверка существования каталога и его создание при необходимости
    if not os.path.exists(ZODIAC_DIRECTORY):
        os.makedirs(ZODIAC_DIRECTORY)

    with open(file_path, "w") as file:
        # file.write(random_zodiac_sign)
        # file.write(generate_html_page(cont))
        file.write(generate_html_page(
            'For the groom {} and the bride {} a favorable forecast for the wedding in the {} month of 2024'.
            format(random.choice(zodiac_signs), random.choice(zodiac_signs), str(random.choice(month_name)))))

    # Пауза в 5 секунд
    time.sleep(5)
