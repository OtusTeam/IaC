import boto3
from botocore.exceptions import ClientError

# Функция для создания клиента S3 с использованием учетных данных
def create_s3_client(aws_access_key_id, aws_secret_access_key):
    """
    Функция для создания клиента S3 с использованием учетных данных AWS.

    Параметры:
    aws_access_key_id (str): AWS Access Key ID.
    aws_secret_access_key (str): AWS Secret Access Key.

    Возвращает:
    boto3.client: Клиент для взаимодействия с S3.
    """
    try:
        session = boto3.Session(
            aws_access_key_id=aws_access_key_id,
            aws_secret_access_key=aws_secret_access_key
        )
        return session.client('s3')
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")
        return None

# Функция для выгрузки имен файлов и каталогов
def list_objects(s3_client, bucket_name, prefix='', delimiter='/', path=''):
    """
    Функция для выгрузки имен файлов и каталогов из S3 бакета.

    Параметры:
    s3_client (boto3.client): Клиент для взаимодействия с S3.
    bucket_name (str): Имя S3 бакета.
    prefix (str): Префикс, используемый для фильтрации ключей объектов.
    delimiter (str): Символ-разделитель для выделения каталогов.
    path (str): Путь в дереве каталогов, по которому нужно выгрузить объекты.
    """
    # Формируем полный префикс
    full_prefix = f"{path}/{prefix}" if path else prefix

    # Вызываем метод list_objects_v2 для получения списка объектов
    response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=full_prefix, Delimiter=delimiter)

    # Выводим имена файлов
    for obj in response.get('Contents', []):
        print(f"File: {obj['Key']}")

    # Выводим имена каталогов
    for prefix in response.get('CommonPrefixes', []):
        print(f"Directory: {prefix['Prefix']}")

    # Если есть дополнительные объекты, рекурсивно вызываем функцию для следующей части
    if response['IsTruncated']:
        list_objects(s3_client, bucket_name, prefix, delimiter, path)

# Пример использования
aws_access_key_id = ''
aws_secret_access_key = ''
bucket_name = 'your-bucket-name'
prefix = 'your-prefix'
path = 'your/path/in/directory/tree'

# Создаем клиент S3
s3_client = create_s3_client(aws_access_key_id, aws_secret_access_key)

# Если клиент создан успешно, выгружаем объекты
if s3_client:
    list_objects(s3_client, bucket_name, prefix, '/', path)
