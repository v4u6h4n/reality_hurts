#!/usr/bin/env python
# coding: utf-8

import argparse
import re
import os
import obsws_python as obs
import socket
import subprocess
import sys
import time
from loguru import logger
from threading import Thread


directory_audio = "../alerts/"
directory_data = "/media/storage/Streaming/Software/data/"
directory_socket = '/tmp/script_socket'


def read_client(file_path):
    with open(file_path, 'r') as file:
        name = file.readline().strip()
        port = int(file.readline().strip())
        password = file.readline().strip()
    return name, port, password


class ObsItemNotFoundException(ValueError):
    pass


def startup_logger():
    logger.add("/media/storage/Streaming/Software/logs/obs_cli/{time:YYYY-MM-DD}.log",  rotation="00:00", format="{time:HH:mm:ss.SSSS} | {level} | {message}", level="INFO", compression="zip")
    logger.add(logger_error, level="ERROR", enqueue=True)
    logger.success("Logger started.")


def logger_error(record):
    logger.info("Error sounds.")
    subprocess.run(['paplay', "/media/storage/Streaming/Software/scripts/dev/alerts/debug_error.wav"])


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


@logger.catch(reraise=True)
def show_source(client, source, scene=None, is_group=False):
    scene = scene or get_current_scene_name(client)
    source_id = get_source_id(client, source=source, scene=scene, is_group=is_group)
    parent = scene if is_group else get_source_parent(client, source, scene)
    logger.info("Show: scene: " + scene + ", source: " + source)
    return client.set_scene_item_enabled(parent, source_id, True)


@logger.catch(reraise=True)
def hide_source(client, source, scene=None, is_group=False):
    scene = scene or get_current_scene_name(client)
    source_id = get_source_id(client, source=source, scene=scene, is_group=is_group)
    parent = scene if is_group else get_source_parent(client, source, scene)
    logger.info("Hide: scene: " + scene + ", source: " + source)
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
    return print(client.get_input_settings(input).input_settings)


def set_input_setting(client, input, key, value):
    try:
        value = json.loads(value)
    except (ValueError, TypeError):
        pass
    LOGGER.debug(f"Setting {key} to {value} ({type(value)})")
    return client.set_input_settings(input, {key: value}, overlay=True)


def get_mute_state(client, input):
    return client.get_input_mute(input).input_muted

@logger.catch(reraise=True)
def mute_input(client, input):
    logger.info("Input mute: " + input)
    client.set_input_mute(input, True)

@logger.catch(reraise=True)
def unmute_input(client, input):
    client.set_input_mute(input, False)
    logger.info("Input unmute: " + input)

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
    return print(client.get_hot_key_list().hotkeys)

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
    return print(client.get_stream_status().output_active)

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

# def record_chapter(client, chapter):
#    return client.create_chapter_record(chapter)

@logger.catch(reraise=True)
def hotkey_trigger_key(client, key):
    return client.trigger_hot_key_by_key_sequence(key, pressShift=False, pressCtrl=False, pressAlt=False, pressCmd=False)

# def open_source_projector():
#     OpenSourceProjector



def handle_command(command, clients):
    try:
        command_args = command.split()

        parser = argparse.ArgumentParser(description='OBS_CLI')
        parser.add_argument('--client', type=str, required=True, help='Client name.')
        subparsers = parser.add_subparsers(dest='operation', help='Operation to perform')


        input_parser = subparsers.add_parser('input', help='Input audio subcommand.')
        input_parser.add_argument('subcommand', choices=['mute', 'unmute', 'toggle'], help='Subcommand')
        input_parser.add_argument('input', type=str, help='Input name.')


        source_parser = subparsers.add_parser('source', help='Source subcommand.')
        source_parser.add_argument('subcommand', choices=['hide', 'show'], help='Subcommand')
        source_parser.add_argument('scene', type=str, help='Scene name.')
        source_parser.add_argument('source', type=str, help='Source name.')


        scene_parser = subparsers.add_parser('scene', help='Scene subcommand.')
        scene_parser.add_argument('subcommand', choices=['list', 'switch'], help='Subcommand')
        scene_parser.add_argument('scene', type=str, help='Scene name.')


        record_parser = subparsers.add_parser('record', help='Record subcommand.')
        record_parser.add_argument('subcommand', choices=['status', 'stop', 'start', 'chapter'], help='Subcommand')
        record_parser.add_argument('chapter', type=str, help='Chapter name.')


        stream_parser = subparsers.add_parser('stream', help='Stream subcommand.')
        stream_parser.add_argument('subcommand', choices=['status', 'stop', 'start'], help='Subcommand')




        hotkey_parser = subparsers.add_parser('hotkey', help='Hotkey subcommand.')
        hotkey_subparsers = hotkey_parser.add_subparsers(dest='subcommand', help='Subcommand')

        hotkey_list_parser = hotkey_subparsers.add_parser('list', help='List all hotkeys')

        hotkey_trigger_parser = hotkey_subparsers.add_parser('trigger', help='Trigger a specific hotkey')
        hotkey_trigger_subparsers = hotkey_trigger_parser.add_subparsers(dest='trigger_subcommand', help='Subcommand')

        hotkey_trigger_name_parser = hotkey_trigger_subparsers.add_parser('name', help='Trigger hotkey by name.')
        hotkey_trigger_name_parser.add_argument('name', type=str, help='Hotkey name.')

        hotkey_trigger_key_parser = hotkey_trigger_subparsers.add_parser('key', help='Trigger hotkey by key.')
        hotkey_trigger_key_parser.add_argument('key', type=str, help='Hotkey key.')

        args = parser.parse_args(command_args)

        client = clients.get(args.client)

        if client:
            if args.operation == 'input':
                if args.subcommand == 'mute':
                    mute_input(client, args.input)
                elif args.subcommand == 'unmute':
                    unmute_input(client, args.input)
                else:
                    print("Invalid input subcommand: " + args.subcommand)

            elif args.operation == 'source':
                if args.subcommand == 'hide':
                    hide_source(client, args.source, args.scene)
                elif args.subcommand == 'show':
                    show_source(client, args.source, args.scene)
                else:
                    print("Invalid source subcommand: " + args.subcommand)
            elif args.operation == 'hotkey':
                if args.subcommand == 'list':
                    print("Not implemented.")
                    get_hotkeys(client)
                elif args.subcommand == 'trigger':
                    if args.trigger_subcommand == 'key':
                        hotkey_trigger_key(client, args.key)
                else:
                    print("Invalid hotkey subcommand: " + args.subcommand)
            elif args.operation == 'stream':
                if args.subcommand == 'status':
                    stream_status(client)
                elif args.subcommand == 'stop':
                    stream_stop(client)
                elif args.subcommand == 'start':
                    stream_start(client)
                else:
                    print("Invalid stream subcommand: " + args.subcommand)
            elif args.operation == 'record':
                if args.subcommand == 'status':
                    print("Not implemented.")
                elif args.subcommand == 'stop':
                    print("Not implemented.")
                elif args.subcommand == 'start':
                    print("Not implemented.")
                elif args.subcommand == 'chapter':
                    print("Not implemented.")
                    # record_chapter(client, args.chapter)
                else:
                    print("Invalid record subcommand: " + args.subcommand)
            else:
                print("Invalid argument.")
                return
        else:
            print("Invalid client name.")
            return

    except Exception as e:
        print(f"Error: {e}")


def command_listener(clients):
    try:
        server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        if os.path.exists(directory_socket):
            os.unlink(directory_socket)
        server_socket.bind(directory_socket)
        server_socket.listen(1)

        while True:
            client_socket, _ = server_socket.accept()
            command = client_socket.recv(1024).decode()
            if command:
                logger.info("Command:", command)
                handle_command(command, clients)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


@logger.catch(reraise=True)
def main():

    startup_logger()

    try:
        client_directories = {}

        for filename in os.listdir(directory_data):
            if filename.startswith("obs_client_") and filename.endswith(".txt"):
                with open(os.path.join(directory_data, filename), 'r') as f:
                    client_name = f.readline().strip()
                client_directories[client_name] = filename

        clients = {}

        for client_name, filename in client_directories.items():
            client_name, client_port, client_password = read_client(os.path.join(directory_data, filename))
            clients[client_name] = obs.ReqClient(host='localhost', port=client_port, password=client_password)

        command_thread = Thread(target=command_listener, args=(clients,))
        command_thread.start()

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()