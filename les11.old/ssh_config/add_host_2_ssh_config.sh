#!/bin/bash

# Проверка количества переданных параметров
if [ $# -ne 4 ]; then
    echo "Usage: $0 <host> <hostname> <user> <identity_file>"
    exit 1
fi

# Параметры для нового хоста
new_host="$1"
new_hostname="$2"
new_user="$3"
new_identity_file="$4"

# добавляем в начало файла
echo "Host $new_host
    HostName $new_hostname
    User $new_user
    IdentityFile $new_identity_file
$(cat "$HOME/.ssh/config")" > "$HOME/.ssh/config"
echo "Добавлено описание хоста $new_host в файл ~/.ssh/config"

