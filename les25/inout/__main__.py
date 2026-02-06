import pulumi
import os

# чтение строки из файла (первой строки файла "zero.txt")
with open("zero.txt", "r", encoding="utf-8") as f:
    file_line = f.readline().rstrip("\n")

# чтение строки из переменной окружения
env_line = os.getenv(file_line, "")

config = pulumi.Config("inout")

# чтение строки из секрета
secret_line = config.require(env_line)

# чтение строки из конфига
config_line = config.require(secret_line)

print("Из файла:", file_line)
print("Из окружения:", env_line)
print(f"Размер секрета: {len(secret_line)}")
print("Из конфига:", config_line)

pulumi.export("joined_line", ", ".join([file_line, env_line, str(len(secret_line)), config_line]))

# пометить как секретный Output — Pulumi шифрует его в стейте
secret_output = pulumi.Output.secret(secret_line)
pulumi.export("my_secret", secret_output)                       