from terminaltexteffects.effects.effect_slide import Slide

text = ("EXAMPLE" * 10 + "\n") * 10

effect = Slide(text)
effect.effect_config.merge = True
effect.terminal_config.terminal_dimensions = (50, 2)
with effect.terminal_output() as terminal:
    for frame in effect:
        terminal.print(frame)