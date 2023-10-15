import os 
import time 
import random 
from tqdm import tqdm 

os.system('clear') 

class System_run() :
     def __init__(self) :
          for i in tqdm (range (100), desc = "Loading....", ascii = False, ncols = 100):
               time.sleep(0.02)
          print(' Complete..')
          time.sleep(1)
          
          for i in tqdm (range (100), desc = "Loading OS Boot....", ascii = False, ncols = 200):
               time.sleep(0.01)
          self.commands = ["neofetch", "ls -s", "tree", "cd .."] 
          
          print('\n\033[98m')
System_run()    
