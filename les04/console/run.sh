set -x
echo "повторяющиеся элементы списка не будут повторятся после преобразования во множество:" > /dev/null
echo 'toset([1, 5, 2, 3, 1])'             | terraform console
echo "вложенные списки преобразуются в один плоский список, но все конечные элементы (включая повторяющиеся) сохранятся, лишние и пустые списки исчезнут:" > /dev/null
echo 'flatten([["a", "b"], [], ["c"]])'   | terraform console
echo 'flatten([[["a", "b"], []], ["c"]])' | terraform console
echo 'flatten([[["a", "b"], ["b"]], ["c"]])' | terraform console
echo "повторяющиеся элементы списка не будут повторятся после преобразования во множество:" > /dev/null
echo 'toset(flatten([[["a", "b"], ["b"]], ["c"]]))' | terraform console
set +x
