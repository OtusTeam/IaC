FROM alpine:3.20
# Демонстрация использования секретного значения во время сборки образа контейнера
 
# вычисляем размер секретного значения во время сборки и сохраняем в /secret-length.txt
RUN --mount=type=secret,id=mysecret \
  sh -c 'cat /run/secrets/mysecret | wc -c > /secret-length.txt'
# будем печатать размер секретного значения при запуске контейнера (только для демонстрации, не печатаем информацию о секретном значении IRL):
CMD ["sh", "-c", "cat /secret-length.txt || echo 'no length'"]
