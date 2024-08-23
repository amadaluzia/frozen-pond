#!/usr/bin/env python

from pyfzf import pyfzf
from pyfiglet import Figlet
import subprocess as sp
import json
import sys
import os


def flatten_list(_2d_list):
    flat_list = []
    # Iterate through the outer list
    for element in _2d_list:
        if type(element) is list:
            # If the element is of type list, iterate through the sublist
            for item in element:
                flat_list.append(item)
        else:
            flat_list.append(element)
    return flat_list


def add_update_input(i: str) -> list[str]:
    return ["--update-input", i]


os.chdir("/etc/nixos")

flake_metadata_command: sp.CompletedProcess = sp.run(
    ["nix", "flake", "metadata", "--json"], capture_output=True, encoding="UTF-8"
)
flake_metadata_json: str = flake_metadata_command.stdout
flake_metadata = json.loads(flake_metadata_json)

flake_inputs: list[str] = list(
    flake_metadata["locks"]["nodes"]["root"]["inputs"].keys()
)

fz: pyfzf.FzfPrompt = pyfzf.FzfPrompt()
inputs_to_update: map = map(
    add_update_input, fz.prompt(flake_inputs, "--multi --cycle")
)

nix_flake_update: sp.CompletedProcess = sp.run(
    flatten_list(["nix", "flake", "lock", flatten_list(list(inputs_to_update))]),
    stdout=sys.stdout,
)

f = Figlet(font="stop")

if nix_flake_update.returncode == 0:
    print(f.renderText("Successfully updated inputs!"))
else:
    print("Something has went ary. Exiting!")
