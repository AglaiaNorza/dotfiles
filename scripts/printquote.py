import random, os, sys
from colorama import Fore, Style

fname = "quotessafe.txt" if len(sys.argv) > 1 and sys.argv[1] == "--safe" else "quotes.txt"

with open(os.path.expanduser('~')+'/.config/'+fname, 'r') as file:
    quotes = file.read().split('----')

color = random.choice([Fore.RED, Fore.GREEN, Fore.YELLOW,
                       Fore.BLUE, Fore.CYAN, Fore.MAGENTA, Fore.WHITE])

quote = "\n".join("     " + line for line in random.choice(quotes).splitlines())

print(color + Style.DIM + "---------- " + os.getlogin() + " @ " + os.uname().nodename + " ----------" + Style.RESET_ALL)
print(color + Style.BRIGHT + quote + Style.RESET_ALL)
