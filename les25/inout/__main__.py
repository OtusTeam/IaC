import pulumi
import os

# чтение строки из файла (первой строки файла "input.txt")
with open("input.txt", "r", encoding="utf-8") as f:
    file_line = f.readline().rstrip("\n")

# чтение строки из переменной окружения MY_VAR
env_line = os.getenv("MY_VAR", "")

config = pulumi.Config("inout")
# чтение строки из конфига
config_line = config.require("three")

# чтение строки из секрета
secret_line = config.require("four")


print("Из файла:", file_line)
print("Из окружения:", env_line)
print("Из конфига:", config_line)
print(f"Размер секрета: {len(secret_line)}", )

pulumi.export("message", ", ".join([file_line, env_line, config_line, str(len(secret_line))]))

# пометить как секретный Output — Pulumi шифрует его в стейте
secret_output = pulumi.Output.secret(secret_line)
pulumi.export("my_secret", secret_output)                       