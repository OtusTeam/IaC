set -x
echo 'toset([1, 5, 2, 3, 1])'             | terraform console
echo 'flatten([["a", "b"], [], ["c"]])'   | terraform console
echo 'flatten([[["a", "b"], []], ["c"]])' | terraform console
echo 'flatten([[["a", "b"], ["b"]], ["c"]])' | terraform console
echo 'toset(flatten([[["a", "b"], ["b"]], ["c"]]))' | terraform console
set +x
