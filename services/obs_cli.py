#!/usr/bin/env python
# coding: utf-8

import argparse
import logging
import obsws_python as obs
import sys

directory_pipe = "/tmp/obs_cli"

def read_instance(file_path):
    with open(file_path, 'r') as file:
        name = file.readline().strip()
        port = int(file.readline().strip())
        password = file.readline().strip()
    return name, port, password

def handle_input_operation(instance, args):
    print("Parsed arguments:", args)
    if args.subcommand == 'mute':
        input_name = args.input_name
        print(f"Muting: {input_name}")
        if input_name == 'all':
            instance.set_input_mute('mic_bathroom', True)
            instance.set_input_mute('mic_desk', True)
            instance.set_input_mute('mic_kitchen', True)
            instance.set_input_mute('mic_mobile', True)
        elif input_name != 'all':
            instance.set_input_mute(input_name, True)
    elif args.subcommand == 'unmute':
        input_name = args.input_name
        print(f"Unmuting: {input_name}")
        if input_name == 'all':
            instance.set_input_mute('mic_bathroom', False)
            instance.set_input_mute('mic_desk', False)
            instance.set_input_mute('mic_kitchen', False)
            instance.set_input_mute('mic_mobile', False)
        elif input_name != 'all':
            instance.set_input_mute(input_name, False)
    elif args.subcommand == 'toggle':
        input_name = args.input_name
        print(f"Toggling input: {input_name}")
        instance.toggle_input_mute(input_name)
    else:
        print("Error: Invalid or missing subcommand for 'input'")

def handle_scene_item_operation(instance, args):
    if args.subcommand == 'hide':
        scene_name, item_name = args.scene_name, args.item_name
        print(f"Hiding item '{item_name}' in scene '{scene_name}'")
        instance.set_scene_item_enabled(scene_name, item_name, False)

    elif args.subcommand == 'show':
        scene_name, item_name = args.scene_name, args.item_name
        print(f"Showing item '{item_name}' in scene '{scene_name}'")
        instance.set_scene_item_enabled(scene_name, item_name, True)
    else:
        print("Error: Invalid or missing subcommand for 'scene-item'")

def main():
    logging.basicConfig()

    directory_instance_1 = "/media/storage/Streaming/Software/data/obs_instance_1.txt"
    directory_instance_2 = "/media/storage/Streaming/Software/data/obs_instance_2.txt"

    try:
        instance_1_name, instance_1_port, instance_1_password = read_instance(directory_instance_1)
        instance_2_name, instance_2_port, instance_2_password = read_instance(directory_instance_2)

        instance_1 = obs.ReqClient(host='localhost', port=instance_1_port, password=instance_1_password)
        instance_2 = obs.ReqClient(host='localhost', port=instance_2_port, password=instance_2_password)

        while True:
            with open(directory_pipe, 'r') as pipe:
                command = pipe.readline().strip()

                # Split the command string into separate arguments
                command_args = command.split()

                # Adding argument parsing for commands received via the pipe
                parser = argparse.ArgumentParser(description='Process OBS commands.')
                parser.add_argument('--instance', type=int, choices=[1, 2], required=True, help='Instance number')
                subparsers = parser.add_subparsers(dest='operation', help='Operation to perform')

                # Sub-parser for input operations
                input_parser = subparsers.add_parser('input', help='Input operations')
                input_parser.add_argument('subcommand', choices=['mute', 'unmute', 'toggle'], help='Subcommand')
                input_parser.add_argument('input_name', type=str, help='Input name')

                # Sub-parser for scene item operations
                scene_item_parser = subparsers.add_parser('scene-item', help='Scene item operations')
                scene_item_parser.add_argument('subcommand', choices=['hide', 'show'], help='Subcommand')
                scene_item_parser.add_argument('scene_name', type=str, help='Scene and item names, separated by a space')
                scene_item_parser.add_argument('item_name', type=str, help='Scene and item names, separated by a space')

                args = parser.parse_args(command_args)

                if args.instance == 1:
                    if args.operation == 'input':
                        handle_input_operation(instance_1, args)
                    elif args.operation == 'scene-item':
                        handle_scene_item_operation(instance_1, args)
                    else:
                        print("Invalid operation")
                        continue
                elif args.instance == 2:
                    if args.operation == 'input':
                        handle_input_operation(instance_2, args)
                    elif args.operation == 'scene-item':
                        handle_scene_item_operation(instance_2, args)
                    else:
                        print("Invalid operation")
                        continue
                else:
                    print("Invalid instance number")
                    continue

    except Exception as e:
        # Handle exceptions here
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
