#!/usr/bin/env python3
import os
import json
import argparse

def generate_slang_config(search_root):
    cwd = os.getcwd()
    slang_dir = os.path.join(cwd, ".slang")
    if not os.path.exists(slang_dir):
        os.makedirs(slang_dir)

    source_files = []
    inc_dirs = set()

    # Walk the directory tree bottom-up
    for root, dirs, files in os.walk(search_root, topdown=False):
        if '.git' in root or '.slang' in root:
            continue
        
        dir_has_headers = False
        # Sort files to ensure deterministic compilation order
        for file in sorted(files):
            if file.endswith(('.sv', '.v')):
                full_path = os.path.join(root, file)
                source_files.append(full_path)
            
            # If the directory contains any SV/V files (including headers), 
            # we should add it to the include paths to resolve `include directives.
            if file.endswith(('.sv', '.v', '.svh', '.vh')):
                dir_has_headers = True

        if dir_has_headers:
            inc_dirs.add(root)

    master_f_path = os.path.join(slang_dir, "slang_master.f")
    
    with open(master_f_path, "w") as mf:
        # Check for UVM_HOME and add to include paths / files if present
        uvm_home = os.environ.get("UVM_HOME")
        if uvm_home:
            print(f"Found UVM_HOME: {uvm_home}")
            uvm_src = os.path.join(uvm_home, "src")
            uvm_pkg = os.path.join(uvm_src, "uvm_pkg.sv")
            
            if os.path.exists(uvm_src):
                mf.write(f"+incdir+{uvm_src}\n")
            if os.path.exists(uvm_pkg):
                mf.write(f"{uvm_pkg}\n")
        
        # Add all discovered include directories
        for inc in sorted(inc_dirs):
            mf.write(f"+incdir+{inc}\n")

        # Add every source file found
        for f in source_files:
            mf.write(f"{f}\n")

    config = {
        "build": ".slang/slang_master.f",
        "flags": ""
    }

    config_path = os.path.join(slang_dir, "server.json")
    with open(config_path, "w") as f:
        json.dump(config, f, indent=2)

    print(f"Successfully generated {config_path} and {master_f_path}")
    print(f"Included {len(source_files)} source files and {len(inc_dirs)} include directories.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate slang-server.json from source files directly")
    parser.add_argument("--root", default=".", help="Directory to search for files (default: current directory)")
    args = parser.parse_args()
    
    generate_slang_config(os.path.abspath(args.root))
