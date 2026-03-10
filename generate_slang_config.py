#!/usr/bin/env python3
import os
import json
import argparse

def generate_slang_config(search_root):
    cwd = os.getcwd()
    slang_dir = os.path.join(cwd, ".slang")
    if not os.path.exists(slang_dir):
        os.makedirs(slang_dir)

    # Build flags string
    flags = ["--single-unit"]

    print("Environment variable check:")
    uvm_home = os.environ.get("UVM_HOME")
    if uvm_home:
        print(f"  UVM_HOME found: {uvm_home}")
        uvm_src = os.path.join(uvm_home, "src")
        uvm_pkg = os.path.join(uvm_src, "uvm_pkg.sv")
        if os.path.exists(uvm_src):
            flags.append(f"-I {uvm_src}")
        if os.path.exists(uvm_pkg):
            flags.append(uvm_pkg)
    else:
        print("  UVM_HOME not set.")

    denali_home = os.environ.get("DENALI")
    if denali_home:
        print(f"  DENALI found: {denali_home}")
        flags.append(f"-I {denali_home}/ddvapi/sv/uvm/cdn_axi")
        flags.append(f"-I {denali_home}/ddvapi/sv")
    else:
        print("  DENALI not set.")

    config = {
        "flags": " ".join(flags)
    }

    # Generate slang server.json
    config_path = os.path.join(slang_dir, "server.json")
    with open(config_path, "w") as f:
        json.dump(config, f, indent=2)

    print(f"Successfully generated {config_path}")
    print(f"Flags: {' '.join(flags)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate slang-server.json from source files")
    parser.add_argument("--root", default=".", help="Directory to search for files (default: current directory)")
    args = parser.parse_args()
    
    generate_slang_config(os.path.abspath(args.root))
