# import time
# from terminaltexteffects.effects.effect_beams import Beams

# text = ("EXAMPLE")

# effect = Beams(text)
# effect.effect_config.merge = True # 
# with effect.terminal_output() as terminal:
#     for frame in effect:
#         terminal.print(frame)

# time.sleep(3)

# from terminaltexteffects.effects.effect_beams import Beams
# from terminaltexteffects.effects.effect_errorcorrect import ErrorCorrect



# effect = Beams("YourTextHere")
# effect = ErrorCorrect("YourTextHere")

# effect.effect_config.swap_delay = 1

# while True:

#     with effect.terminal_output() as terminal:
#         for frame in effect:
#             terminal.print(frame)

#     # with effect.terminal_output() as terminal:
#     #     for frame in effect:
#     #         terminal.print(frame)

#     clear_screen()





import time
from terminaltexteffects.effects.effect_slide import Slide

def clear_screen():
    print("\033c", end="")

text = ("Hello World!")

effect = Slide(text)
effect.effect_config.merge = True # 
effect.terminal_config.terminal_dimensions = (50, 2)
for frame in effect:
    print(frame.split('\n')[0], end='\r')

    time.sleep(0.02)

    # clear_screen()







# import time
# from terminaltexteffects.effects.effect_slide import Slide

# def clear_screen():
#     print("\033c", end="")

# text = "Hello World!"

# effect = Slide(text)
# effect.effect_config.merge = True
# effect.terminal_config.terminal_dimensions = (50, 2)

# # Count the total number of frames
# total_frames = sum(1 for _ in effect)

# # Iterate over frames
# for i, frame in enumerate(effect):
#     # Check if it's the final frame
#     if i == total_frames - 1:
#         # Print the final frame without clearing the screen
#         print(frame)
#     else:
#         # Print the frame and clear the screen
#         print(frame, end='\r')
#         time.sleep(0.02)
#         clear_screen()
