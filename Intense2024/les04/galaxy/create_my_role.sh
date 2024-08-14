#!/bin/bash -x

cd roles
# Создать директорию для роли
mkdir my_role

# Создать директории для файлов роли
mkdir my_role/tasks
mkdir my_role/templates
mkdir my_role/defaults

# Создать файлы роли
touch my_role/tasks/main.yml
touch my_role/templates/index.html.j2
touch my_role/defaults/main.yml

# Добавить содержимое в файлы роли
echo "---" > my_role/tasks/main.yml
echo "- name: Create index.html file" >> my_role/tasks/main.yml
echo "  template:" >> my_role/tasks/main.yml
echo "    src: index.html.j2" >> my_role/tasks/main.yml
echo "    dest: /var/www/html/index.html" >> my_role/tasks/main.yml
echo "    mode: '0644'" >> my_role/tasks/main.yml
echo "  vars:" >> my_role/tasks/main.yml
echo "    name: \"{{ name }}\"" >> my_role/tasks/main.yml

echo "<html>" > my_role/templates/index.html.j2
echo "  <body>" >> my_role/templates/index.html.j2
echo "    <h1>Hello, {{ name }}!</h1>" >> my_role/templates/index.html.j2
echo "  </body>" >> my_role/templates/index.html.j2
echo "</html>" >> my_role/templates/index.html.j2

echo "---" > my_role/defaults/main.yml
echo "name: \"Anonymous\"" >> my_role/defaults/main.yml
