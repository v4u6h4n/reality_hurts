from rgbprint import gradient_scroll, Color

while True:

    print("\033c", end="")

    gradient_scroll(
        "[CRITICAL] system failure, program can't open file in location C:/foo/bar/baz.tgz", 
        start_color=0x4BBEE3, 
        end_color=Color.medium_violet_red,
        times=1
    )