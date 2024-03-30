""" import re

# not ideal, but works
with open('roll_base.baselua', 'r') as file:
    base_content = file.read()

def create_effect_files(direction, angle):
    for i in range(1, 21):
        new_content = re.sub(r'roll_\*\*', f'roll_{i}_{direction}', base_content)
        new_content = re.sub(r'roll_\*', f'roll_{i}', new_content)
        new_content = re.sub(r'anim_\*\*', f'anim_{i}_{direction}', new_content)
        new_content = re.sub(r'anim_\*', f'anim_{i}', new_content)
        new_content = re.sub(r'Angle = [^+]+\+\+[^,]+', f'Angle = {angle}', new_content)
        
        with open(f'roll_{i}_{direction}.lua', 'w') as new_file:
            new_file.write(new_content)
        print(f'Файл roll_{i}_{direction}.lua создан.')

matches = re.search(r'Angle = ([^+]+)\+\+([^,]+)', base_content)
angle_left = matches.group(1)
angle_right = matches.group(2)

create_effect_files('left', angle_left)
create_effect_files('right', angle_right)
 """
import re

with open('roll_base.baselua', 'r') as file:
    base_content = file.read()

for i in range(1, 21):
    new_content = re.sub(r'roll_\*', f'roll_{i}', base_content)
    new_content = re.sub(r'anim_\*', f'anim_{i}', new_content)

    with open(f'roll_{i}.lua', 'w') as new_file:
        new_file.write(new_content)

    print(f'Файл roll_{i}.lua создан.')