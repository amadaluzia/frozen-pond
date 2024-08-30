#!/usr/bin/env python

from pyfzf import pyfzf
from pyfiglet import Figlet
import subprocess as sp
import json
import sys
import os

flake_metadata_command: sp.CompletedProcess = sp.run(
    ["nix", "flake", "metadata", "--json"], capture_output=True, encoding="UTF-8"
)
flake_metadata_json: str = flake_metadata_command.stdout
flake_metadata = json.loads(flake_metadata_json)

flake_inputs: list[str] = list(
    flake_metadata["locks"]["nodes"]["root"]["inputs"].keys()
)

fz: pyfzf.FzfPrompt = pyfzf.FzfPrompt()

inputs_to_update = []
for i in fz.prompt(flake_inputs, "--multi"):
    inputs_to_update += ["--update-input", i]

print(inputs_to_update)

if len(list(inputs_to_update)) != 0:
    command = ["nix", "flake", "lock"] + inputs_to_update
    print()
else:
    command = ["nix", "flake", "lock", "--recreate-lock-file"]

nix_flake_update: sp.CompletedProcess = sp.run(
    command,
    stdout=sys.stdout,
)

f = Figlet(font="ghost")

if nix_flake_update.returncode == 0:
    print(f.renderText("updated inputs!"))
else:
    print("Something has went ary. Exiting!")
