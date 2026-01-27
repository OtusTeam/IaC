#set -x
# Демонстрация передачи секрета в контейнер с использованием секретов swarm

# подготовим переменную среды с секретом (только для демонстрации, секрет не хардкодим в скрипте IRL!)
export MY_SWARM_SECRET="qwerty123"
# для контроля напечатаем размер секрета (только для демонстрации, информацию о значении секрета не печатаем IRL!)
echo -n "$MY_SWARM_SECRET" | wc -c

# создадим секрет для swarm из переменной среды
echo -n "$MY_SWARM_SECRET" | docker secret create my_swarm_secret -
# убедимся что секрет для swarm создан:
docker secret ls
docker secret inspect my_swarm_secret

# создадим swarm-сервис из стандартного образа, передадим ему секрет и пусть он немного поспит (чтобы сразу не завершился): 
docker service create --name swarm_secret_srv --secret source=my_swarm_secret,target=my_swarm_secret alpine:3.20 sleep 3600
# Внутри контейнера прочитаем и напечатаем секрет (только для демонстрации, информацию о значении секрета не печатаем IRL!):
docker exec -it $(docker ps --filter name=swarm_secret_srv --format '{{.ID}}') sh -c 'cat /run/secrets/my_swarm_secret | wc -c'

# поудаляем что насоздавали:
docker service rm swarm_secret_srv
docker secret rm my_swarm_secret

#set +x
