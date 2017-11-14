import time
import _thread
from pynput import keyboard

i = 0

def on_press(key):
    global i
    if key == keyboard.Key.f8:
        if i != 0:
            i -= 1
        print(i)

# Collect events until released
def listen():
    with keyboard.Listener(on_press=on_press) as listener:
        listener.join()

def timer():
    global i
    while True:
        print(i)
        time.sleep(360)
        i += 1

_thread.start_new_thread(listen, ())
time.sleep(0.1)
timer()