from pynput.keyboard import Key, Controller

keyboard = Controller()

keyboard.press(Key.ctrl_l)
keyboard.press('y')
keyboard.release('y')
keyboard.release(Key.ctrl_l)