import os
import time
from tqdm import tqdm

print("\033[90mRunning System....\033[0m")
time.sleep(1)
os.system('clear')

for i in tqdm(range(100), desc="Loading OS...", ascii=False, ncols=100):
    time.sleep(0.06)

os.system('clear')

logo="""
\033[95m
    $$$$$$$$$$$$$$$   $$$$$$$$$$$$$$
    ===============   ==============
    $#           #$   $$
    $#           #$   $$
    $#           #$   $$
    $#           #$   %%%%%%%%%%%%%%
    $#           #$               $$
    $#           #$               $$
    $#           #$               $$
    ===============   ==============
    $$$$$$$$$$$$$$$   $$$$$$$$$$$$$$
\033[0m
"""

pattern = logo.strip().split('\n')
for line in pattern:
    print(line)
    time.sleep(0.1)
print('\033[92m')

