#set -x
# Демонстрация передачи секрета в контейнер с использованием секретов docker compose

# Создадим переменную среды с секретом (только для демонстрации, секрет не хардкодим в скрипте IRL!):
export MY_COMPOSE_SECRET="StrongComposeSecret123"
# для контроля напечатаем размер секрета (только для демонстрации, информацию о значении секрета не печатаем IRL!)
echo -n "$MY_COMPOSE_SECRET" | wc -c
# Запустим контейнер с секретами:
docker compose up -d
# Внутри контейнера прочитаем и напечатаем секрет (только для демонстрации, информацию о значении секрета не печатаем IRL!):
docker exec -it compose-secret sh -c 'cat /run/secrets/my_compose_secret | wc -c'
# Остановим контейнер:
docker compose down
#set +x
