ansible -i inv -a 's3fs otus-audit-log /mount/sc -o passwd_file=$HOME/.passwd-s3fs -o url=https://storage.yandexcloud.net -o use_path_request_style' sc


