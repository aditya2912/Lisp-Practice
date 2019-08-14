import re

type_alias_map = {"initial_line": [], "body": []}
file_as_string = ""
type_aliases = []
file_as_list = []
body_code = []


def identify_type_aliases():
    slice_object = slice(0, 10, 1)
    global file_as_list, type_aliases, type_alias_map, body_code
    for iter in range(0, len(file_as_list)):
        if len(file_as_list[iter]) >= 10:
            if file_as_list[iter][slice_object] == "type alias":
                for iterator in range(iter, len(file_as_list)):
                    if re.match("^\s*}", file_as_list[iterator]):
                        break
                    else:
                        body_code.append(file_as_list[iterator])
        else:
            pass


elm_file = open("C:/WebApps/eis/assets/elm/OrgIdentity/Main.elm", "r")
# elm_file = open("C:/practice Programs/Elm Projects/src/question_24.elm", "r")

for line in elm_file:
    file_as_string = file_as_string + line

elm_file.close()
file_as_list = file_as_string.split("\n")
identify_type_aliases()
# print(body_code)
for line in body_code:
    print(line)
# print(type_alias_map)
# print(body_code)
