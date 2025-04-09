#!/bin/env python

import argparse
import json
import os
import subprocess
import sys
from pathlib import Path


def main():

    args = parse_args()

    config_dir = str(Path.home()) + "/.config/outs/"
    config_file = config_dir + "outs.json"

    os.makedirs(config_dir, exist_ok=True)
    if not os.path.exists(config_file):
        with open(config_file, "w"):
            pass

    if args.choose:
        set_sinks(config_file)
    if args.list:
        list_sinks(config_file)
    if args.next:
        set_next_sink(config_file)
    if args.previous:
        set_previous_sink(config_file)


def parse_args():

    parser = argparse.ArgumentParser(description="Manage Pulse Audio outputs")

    ig = parser.add_mutually_exclusive_group()
    ig.add_argument(
        "-c",
        "--choose",
        dest="choose",
        action="store_true",
        help="Choose from available sinks and write to config",
    )
    ig.add_argument(
        "-l",
        "--list",
        dest="list",
        action="store_true",
        help="List current sinks from config",
    )
    ig.add_argument(
        "-n",
        "--next",
        dest="next",
        action="store_true",
        help="Set output to next sink in config",
    )
    ig.add_argument(
        "-p",
        "--previous",
        dest="previous",
        action="store_true",
        help="Set output to previous sink in config",
    )

    args = parser.parse_args()

    if not any([args.choose, args.list, args.next, args.previous]):
        parser.print_help(sys.stderr)

    return args


def set_next_sink(config_file):

    current_sink = get_current()
    selected = get_selected(config_file)

    current_index = -1

    for i, sink in enumerate(selected):
        if sink["name"] == current_sink:
            current_index = i

    current_index += 1

    if current_index == len(selected):
        current_index = 0

    next_sink = selected[current_index]

    set_sink(next_sink)


def set_previous_sink(config_file):

    current_sink = get_current()
    selected = get_selected(config_file)

    current_index = -1

    for i, sink in enumerate(selected):
        if sink["name"] == current_sink:
            current_index = i

    current_index -= 1

    if current_index < 0:
        current_index = len(selected) - 1

    previous_sink = selected[current_index]

    set_sink(previous_sink)


def list_sinks(config_file):

    selected = get_selected(config_file)

    for sink in selected:
        print(f"Name: {sink['name']}")
        print(f"Description: {sink['description']}")


def get_selected(config_file):

    try:
        with open(config_file, "r") as f:
            selected = json.load(f)
    except:
        print("Outs: Error reading from config", file=sys.stderr)
        sys.exit(1)

    return selected


def set_sink(sink):

    name = sink["name"]
    description = sink["description"]
    nickname = sink["nickname"]
    notice = f"Set output to {nickname}"

    try:
        popen = subprocess.Popen(["/usr/bin/pactl", "set-default-sink", name])
        popen.wait()
        print(f"Set sink to {description}")
    except:
        print("Outs: Error setting default sink", file=sys.stderr)
        sys.exit(1)

    try:
        nproc = subprocess.Popen(["notify-send", "Outs", notice])
        nproc.wait()
    except:
        pass


def set_sinks(config_file):

    sinks_available = get_sinks()
    selected = choose_sinks(sinks_available)

    try:
        with open(config_file, "w") as f:
            json.dump(selected, f, indent=4)
            print(f"Wrote config to {config_file}")
    except:
        print("Outs: Error writing to config", file=sys.stderr)


def choose_sinks(sinks_available):

    selected = []

    for sink in sinks_available:
        print(f"Name: {sink['name']}")
        print(f"Description: {sink['description']}")
        while True:
            i = input("Select? (y/N)")
            if i in ("y", "Y"):
                nickname = input("Set nickname:")
                if nickname == "":
                    nickname = sink["description"]
                sink["nickname"] = nickname
                selected.append(sink)
            break

    return selected


def get_sinks():

    try:
        popen = subprocess.Popen(
            ["/usr/bin/pactl", "list", "sinks"], stdout=subprocess.PIPE, text=True
        )
        popen.wait()
        pactl_output = popen.stdout.read()
    except:
        print("Outs: Error reading from pactl", file=sys.stderr)
        sys.exit(1)

    filtered_output = []

    for line in pactl_output.split("\n"):
        if "Name" in line or "Description" in line:
            filtered_output.append(line.removeprefix("\t"))

    sinks_available = []

    try:
        for i, val in enumerate(filtered_output):
            if "Name" in val:
                sink = {}
                sink["name"] = val.removeprefix("Name: ")
                sink["description"] = filtered_output[i + 1].removeprefix(
                    "Description: "
                )
                sinks_available.append(sink)
    except:
        print("Outs: Error parsing output from pactl", file=sys.stderr)
        sys.exit(1)

    return sinks_available


def get_current():

    try:
        popen = subprocess.Popen(
            ["/usr/bin/pactl", "get-default-sink"], stdout=subprocess.PIPE, text=True
        )
        popen.wait()
        current_sink = popen.stdout.read()
    except:
        print("Outs: Error reading from pactl", file=sys.stderr)
        sys.exit(1)

    return current_sink.removesuffix("\n")


if __name__ == "__main__":
    main()
