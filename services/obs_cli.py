#!/usr/bin/env python
# coding: utf-8

import argparse
import logging
import re
import os
import obsws_python as obs
import sys

directory_pipe = "/tmp/obs_cli"

def read_client(file_path):
    with open(file_path, 'r') as file:
        name = file.readline().strip()
        port = int(file.readline().strip())
        password = file.readline().strip()
    return name, port, password


class ObsItemNotFoundException(ValueError):
    pass


def switch_to_scene(client, scene, exact=False, ignorecase=True):
    regex = re.compile(
        f"^{scene}$" if exact else scene,
        re.IGNORECASE if ignorecase else re.NOFLAG,
    )
    for sc in sorted(
        client.get_scene_list().scenes, key=lambda x: x.get("sceneName")
    ):
        if re.search(regex, sc.get("sceneName")):
            client.set_current_program_scene(sc.get("sceneName"))
            return True


def get_sources(
    client, scene=None, names_only=False, recurse=True, include_groups=False
):
    scene = scene or get_current_scene_name(client)
    sources = client.get_scene_item_list(scene).scene_items
    if recurse:
        all_sources = []
        for it in sources:
            if it.get("isGroup"):
                if include_groups:
                    all_sources.append(it)
                for grp_it in client.get_group_scene_source_list(
                    it.get("sourceName")
                ).scene_items:
                    # Inject parent group attribute
                    grp_it["parentGroup"] = it
                    all_sources.append(grp_it)
            else:
                all_sources.append(it)
        sources = all_sources

    sources = sorted(
        sources,
        key=lambda x: (
            x.get("parentGroup") is None,  # Items with parentGroup come first
            (
                x.get("parentGroup", {}).get("sourceName")
                if x.get("parentGroup")
                else None
            ),  # Then sort by parentGroup.sourceName
            x.get("sourceName"),  # Finally, sort by sourceName
        ),
    )

    return [x.get("sourceName") for x in sources] if names_only else sources


def get_groups(client, scene=None, names_only=False):
    scene = scene or get_current_scene_name(client)
    groups = sorted(
        [
            x
            for x in client.get_scene_item_list(scene).scene_items
            if x.get("isGroup", False)
        ],
        key=lambda x: x.get("sourceName"),
    )

    return [x.get("sourceName") for x in groups] if names_only else groups


def get_source_by_name(
    client, source, ignorecase=True, exact=False, scene=None, is_group=False
):
    sources = get_sources(client, scene) if not is_group else get_groups(client, scene)
    regex = re.compile(
        source if not exact else f"^{source}$",
        re.IGNORECASE if ignorecase else re.NOFLAG,
    )
    for it in sources:
        if re.search(regex, it.get("sourceName")):
            return it

    raise ObsItemNotFoundException(
        f"Item not found: '{source}' (Scene: '{scene}')"
    )


def get_source_id(client, source, scene=None, is_group=False):
    data = get_source_by_name(client, source, scene=scene, is_group=is_group)
    return data.get("sceneItemId", -1)


def get_source_parent(client, source, scene=None):
    data = get_source_by_name(client, source, scene=scene)
    parent_group = data.get("parentGroup")
    return parent_group.get("sourceName") if parent_group else scene


def is_source_enabled(client, source, scene=None, is_group=False):
    data = get_source_by_name(client, source=source, is_group=is_group, scene=scene)
    return data.get("sceneItemEnabled")


def show_source(client, source, scene=None, is_group=False):
    scene = scene or get_current_scene_name(client)
    source_id = get_source_id(client, source=source, scene=scene, is_group=is_group)
    parent = scene if is_group else get_source_parent(client, source, scene)
    return client.set_scene_item_enabled(parent, source_id, True)


def hide_source(client, source, scene=None, is_group=False):
    scene = scene or get_current_scene_name(client)
    source_id = get_source_id(client, source=source, scene=scene, is_group=is_group)
    parent = scene if is_group else get_source_parent(client, source, scene)
    return client.set_scene_item_enabled(parent, source_id, False)


def toggle_source(client, source, scene=None, is_group=False):
    scene = scene or get_current_scene_name(client)
    source_id = get_source_id(client, source=source, scene=scene, is_group=is_group)
    parent = scene if is_group else get_source_parent(client, source, scene)
    enabled = not is_source_enabled(
        client, source=source, scene=scene, is_group=is_group
    )
    return client.set_scene_item_enabled(parent, source_id, enabled)


def get_current_scene_name(client):
    return client.get_current_program_scene().current_program_scene_name


def get_inputs(cl):
    return sorted(client.get_input_list().inputs, key=lambda x: x.get("inputName"))


def get_input_settings(client, input):
    return client.get_input_settings(input).input_settings


def set_input_setting(client, input, key, value):
    try:
        value = json.loads(value)
    except (ValueError, TypeError):
        pass
    LOGGER.debug(f"Setting {key} to {value} ({type(value)})")
    return client.set_input_settings(input, {key: value}, overlay=True)


def get_mute_state(client, input):
    return client.get_input_mute(input).input_muted


def mute_input(client, input):
    client.set_input_mute(input, True)


def unmute_input(client, input):
    client.set_input_mute(input, False)


def toggle_mute_input(client, input):
    client.toggle_input_mute(input)


def get_filters(client, input):
    return client.get_source_filter_list(input).filters


def is_filter_enabled(client, source, filter):
    return client.get_source_filter(source, filter).filter_enabled


def enable_filter(client, source, filter):
    return client.set_source_filter_enabled(source, filter, True)


def disable_filter(client, source, filter):
    return client.set_source_filter_enabled(source, filter, False)


def toggle_filter(client, source, filter):
    enabled = is_filter_enabled(client, source, filter)
    return client.set_source_filter_enabled(source, filter, not enabled)


def get_hotkeys(client):
    return client.get_hot_key_list().hotkeys


def trigger_hotkey(client, hotkey):
    return client.trigger_hot_key_by_name(hotkey)


def virtual_camera_status(client):
    return client.get_virtual_cam_status().output_active


def virtual_camera_start(client):
    return client.start_virtual_cam()


def virtual_camera_stop(client):
    return client.stop_virtual_cam()


def virtual_camera_toggle(client):
    return client.toggle_virtual_cam()


def stream_status(client):
    return client.get_stream_status().output_active


def stream_start(client):
    return client.start_stream()


def stream_stop(client):
    return client.stop_stream()


def stream_toggle(client):
    return client.toggle_stream()


def replay_start(client):
    return client.start_replay_buffer()


def replay_stop(client):
    return client.stop_replay_buffer()


def replay_save(client):
    return client.save_replay_buffer()


def replay_toggle(client):
    return client.toggle_replay_buffer()


def replay_status(client):
    return client.get_replay_buffer_status().output_active


def record_status(client):
    return client.get_record_status().output_active


def record_start(client):
    return client.start_record()


def record_stop(client):
    return client.stop_record()


def record_toggle(client):
    return client.toggle_record()


def main():
    logging.basicConfig()

    clients_directory = "/media/storage/Streaming/Software/data/"
    
    try:
        client_directories = {}

        # List files in the specified directory
        for filename in os.listdir(clients_directory):
            # Check if the file name matches the pattern 'obs_client_#.txt'
            if filename.startswith("obs_client_") and filename.endswith(".txt"):
                # Extract the client name from the first line of the file
                with open(os.path.join(clients_directory, filename), 'r') as f:
                    client_name = f.readline().strip()
                # Store the client name and file path in the dictionary
                client_directories[client_name] = filename

        clients = {}

        # Iterate over the discovered client directories
        for client_name, filename in client_directories.items():
            client_name, client_port, client_password = read_client(os.path.join(clients_directory, filename))
            clients[client_name] = obs.ReqClient(host='localhost', port=client_port, password=client_password)

        while True:
            with open(directory_pipe, 'r') as pipe:
                command = pipe.readline().strip()

                command_args = command.split()

                # Client.
                parser = argparse.ArgumentParser(description='OBS_CLI')
                parser.add_argument('--client', type=str, required=True, help='Client name.')
                subparsers = parser.add_subparsers(dest='operation', help='Operation to perform')

                # Input.
                input_parser = subparsers.add_parser('input', help='Input audio subcommand.')
                input_parser.add_argument('subcommand', choices=['mute', 'unmute', 'toggle'], help='Subcommand')
                input_parser.add_argument('input', type=str, help='Input name.')

                # Source.
                source_parser = subparsers.add_parser('source', help='Source subcommand.')
                source_parser.add_argument('subcommand', choices=['hide', 'show'], help='Subcommand')
                source_parser.add_argument('scene', type=str, help='Scene name.')
                source_parser.add_argument('source', type=str, help='Source name.')

                args = parser.parse_args(command_args)

                client = clients.get(args.client)

                # Client.
                if client:

                    # Input.
                    if args.operation == 'input':
                        if args.subcommand == 'mute':
                            mute_input(client, args.input)
                        elif args.subcommand == 'unmute':
                            unmute_input(client, args.input)
                        else
                            print("Invalid input subcommand: " + args.subcommand)

                    # Source.
                    elif args.operation == 'source':
                        if args.subcommand == 'hide':
                            hide_source(client, args.source)
                        elif args.subcommand == 'show':
                            show_source(client, args.source)
                        else
                            print("Invalid source subcommand: " + args.subcommand)

                    # Error: argument.
                    else:
                        print("Invalid argument.")
                        continue

                # Error: client.
                else:
                    print("Invalid client name.")
                    continue

    except Exception as e:
        # Handle exceptions here
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()