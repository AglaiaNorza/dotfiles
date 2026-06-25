"""
screenshot handler script
(i hate screenshots)

this script is designed to be triggered after a screenshot tool (like flameshot) 
saves a temporary image to /tmp/screenshot_temp.png. It then prompts the user 
in a terminal to organize and save the image based on the chosen mode.

If /tmp/screenshot_temp.png does not exist or is empty, it will automatically
grab the newest screenshot in DEFAULT_SCREENSHOT_DIR and process that instead

Modes:
  1 : LaTeX mode - prompts for a subject (from my latex notes directory) and saves to ~/Documents/uni/latex/<subject>/assets
  2 : smart directory mode - saves to recent, pinned, or dynamically searched directories

Example: i3 Keybindings (using Flameshot and Alacritty):
  bindsym F1 exec bash -c "flameshot gui -r > /tmp/screenshot_temp.png && alacritty --class FloatingTerm -e python3 ~/scripts/screenshot-handler.py 1"
  bindsym F4 exec bash -c "flameshot gui -r > /tmp/screenshot_temp.png && alacritty --class FloatingTerm -e python3 ~/scripts/screenshot-handler.py 2"
"""


import os
import sys
import shutil
import subprocess
import difflib
import glob
from datetime import datetime
from collections import deque

LATEX_DIR = os.path.expanduser("~/Documents/uni/latex")
DOCUMENTS_DIR = os.path.expanduser("~/Documents")
DEFAULT_SCREENSHOT_DIR = os.path.expanduser("~/Documents")
HISTORY_FILE = os.path.expanduser("~/.config/screenshot_history.txt")
TEMP_IMG = "/tmp/flameshot_temp.png"

# fallback options for mode 2
HARDCODED_DIRS = [
    os.path.expanduser("~/Downloads"),
    os.path.expanduser("~/Documents"),
    os.path.expanduser("~/Pictures/Screenshots")
]

C_GREEN = '\033[92m'
C_CYAN = '\033[96m'
C_YELLOW = '\033[93m'
C_RESET = '\033[0m'


# ---------------HELPER FUNCTIONS---------------------
def copy_to_clipboard(text):
    subprocess.run(
        ['xclip', '-selection', 'clipboard'], 
        input=text.encode('utf-8'),
        start_new_session=True
    )

def get_unique_path(directory, base_title, extension=".png"):
    filename = f"{base_title}{extension}"
    dst_path = os.path.join(directory, filename)
    counter = 1
    
    while os.path.exists(dst_path):
        filename = f"{base_title}{counter}{extension}"
        dst_path = os.path.join(directory, filename)
        counter += 1
        
    return filename, dst_path

def get_latest_screenshot(directory):
    """finds the most recently created .png file in the given directory."""
    if not os.path.exists(directory):
        return None
    search_pattern = os.path.join(directory, "*.png")
    files = glob.glob(search_pattern)
    if not files: return None
    # return the file with the most recent creation/modification time
    return max(files, key=os.path.getctime)

def read_history():
    if not os.path.exists(HISTORY_FILE):
        return []
    with open(HISTORY_FILE, 'r') as f:
        return [line.strip() for line in f.readlines() if line.strip()]

def write_history(new_path, history):
    if new_path in history:
        history.remove(new_path)
    history.insert(0, new_path)
    history = history[:10]
    with open(HISTORY_FILE, 'w') as f:
        f.write('\n'.join(history))


def search_directory_bfs(start_path, target_name, threshold=0.75):
    print(f"{C_CYAN}searching for similar matches to '{target_name}' in {start_path}...{C_RESET}")
    queue = deque([start_path])
    target_lower = target_name.lower()
    
    while queue:
        current = queue.popleft()
        try:
            with os.scandir(current) as it:
                for entry in it:
                    if entry.is_dir():
                        # calculate similarity ratio between input and directory name
                        similarity = difflib.SequenceMatcher(None, target_lower, entry.name.lower()).ratio()
                        
                        # exact match or high similarity
                        if similarity >= threshold:
                            yield entry.path  # yield pauses the function and returns the path (generator!! super cool!!!)
                            
                        if not entry.name.startswith('.'):
                            queue.append(entry.path)
        except PermissionError:
            pass


# ----------- MODES --------------

def run_mode_1(source_img):
    os.system('clear')
    print(f"{C_CYAN}--- option 1: LaTeX ---{C_RESET}\n")
    print(f"Target image: {source_img}\n")
    
    title = input("screenshot title: ").strip()
    if not title:
        title = f"img_{datetime.now().strftime('%Y%m%d_%H%M%S')}"

    try:
        subjects = [d for d in os.listdir(LATEX_DIR) if os.path.isdir(os.path.join(LATEX_DIR, d)) and not d.startswith('.')]
    except FileNotFoundError:
        print(f"error: LaTeX directory not found at {LATEX_DIR}")
        input("\npress enter to exit...")
        return

    print("\nsubjects:")
    for i, subj in enumerate(subjects, 1):
        print(f"{C_YELLOW}{i}){C_RESET} {subj}")
    
    while True:
        try:
            choice = int(input(f"\nselect subject number: ")) - 1
            if choice < 0 or choice >= len(subjects):
                raise ValueError
            selected_subject = subjects[choice]
            break
        except ValueError:
            print(f"{C_YELLOW}invalid choice; choose again.{C_RESET}")
    
    assets_dir = os.path.join(LATEX_DIR, selected_subject, "assets")
    os.makedirs(assets_dir, exist_ok=True)
    
    # unique filename
    filename, dst_path = get_unique_path(assets_dir, title)
    
    shutil.move(source_img, dst_path)
    # "assets/[name]" (to write in latex)
    copy_to_clipboard(f"assets/{filename}")
    
    print(f"\n{C_GREEN}success!{C_RESET}")
    print(f"saved to: {dst_path}")
    print(f"copied 'assets/{filename}' to clipboard!")
    subprocess.run(["sleep", "0.1"])


def run_mode_2(source_img):
    os.system('clear')
    print(f"{C_CYAN}-- option 2: smart directory --{C_RESET}\n")
    print(f"Target image: {source_img}\n")
    
    history = read_history()
    all_options = []
    for path in history + HARDCODED_DIRS:
        if path not in all_options and os.path.exists(path):
            all_options.append(path)

    print("recent & pinned directories:")
    for i, path in enumerate(all_options, 1):
        print(f"{C_YELLOW}{i}){C_RESET} {path}")
    
    print("\ntype a number to select, OR type a new directory name to search !!")
    choice = input("Choice: ").strip()
    
    selected_path = None
    
    if choice.isdigit() and 1 <= int(choice) <= len(all_options):
        selected_path = all_options[int(choice) - 1]
    else:
        selected_path = None
        # loop through the generator as it yields results
        for found_path in search_directory_bfs(DOCUMENTS_DIR, choice):
            confirm = input(f"\n{C_GREEN}found:{C_RESET} {found_path}\nuse this path? [Y/n]: ").strip().lower()
            if confirm in ['', 'y', 'yes']:
                selected_path = found_path
                break # stop searching once confirmed
                
        # if the loop finishes and nothing was selected (or found)
        if not selected_path:
            print(f"\ncould not find any (more) directories named '{choice}'.")
            input("press enter to exit...")
            return

    if selected_path:
        title = input(f"\nscreenshot title: ").strip()
        if not title:
            title = f"screenshot_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        # unique filename and path
        _, dst_path = get_unique_path(selected_path, title)
        
        shutil.move(source_img, dst_path)
        
        write_history(selected_path, history)

        copy_to_clipboard(dst_path)
        
        print(f"\n{C_GREEN}success!{C_RESET} saved to {dst_path}")
        print(f"copied '{dst_path}' to clipboard!")
        subprocess.run(["sleep", "0.1"])


# -----------------MAIN----------------------
if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] not in ["1", "2"]:
        print(f"{C_YELLOW}usage: python3 screenshot-handler.py <mode>{C_RESET}")
        print("Modes:")
        print("  1 - LaTeX mode")
        print("  2 - smart directory mode")
        sys.exit(1)

    source_img = TEMP_IMG

    # checks if the temp image exists and is not empty
    if not os.path.exists(TEMP_IMG) or os.path.getsize(TEMP_IMG) == 0:
        if os.path.exists(TEMP_IMG):
            os.remove(TEMP_IMG) # clean up empty file if user cancelled Flameshot
        
        # fallback to the latest screenshot in the default directory
        latest_screenshot = get_latest_screenshot(DEFAULT_SCREENSHOT_DIR)
        
        if latest_screenshot:
            source_img = latest_screenshot
        else:
            print("no temp image provided and no screenshots found")
            sys.exit(0)

    mode = sys.argv[1]
    if mode == "1":
        run_mode_1(source_img)
    elif mode == "2":
        run_mode_2(source_img)
