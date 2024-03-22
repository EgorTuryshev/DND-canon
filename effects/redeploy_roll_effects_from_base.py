import re

with open('roll_base.lua', 'r') as file:
    base_content = file.read()

base_content = re.sub(r'^\-\-\[\[', '', base_content, count=1)
base_content = re.sub(r'\]\]$', '', base_content, count=1)

for i in range(1, 21):
    new_content = re.sub(r'roll_\*', f'roll_{i}', base_content)
    new_content = re.sub(r'/anim\*.png', f'/anim_{i}.png', new_content)

    with open(f'roll_{i}.lua', 'w') as new_file:
        new_file.write(new_content)

    print(f'Файл roll_{i}.lua создан.')
