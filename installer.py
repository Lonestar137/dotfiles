#!/bin/env python3

import os
import abc
import yaml
import shlex
import subprocess
from pathlib import Path
from typing import Optional
from functools import partial
from dataclasses import dataclass

try:
    # Try to use rich printing.
    import rich
    pprint = rich.print
except:
    pprint = print


@dataclass
class InstallData:
    package_index: dict
    build_index: dict
    to_install: set
    symlinks: set


def read_yml(filepath: os.PathLike) -> dict:
    try:
        with open(filepath) as f:
            return yaml.safe_load(f)
    except yaml.YAMLError as exc:
        print('Failed to read: ' + filepath)
        return {}


def get_system_pm() -> str:
    """Get system package manager."""
    lines = []
    with open('/etc/os-release', r) as f:
        lines = f.readlines()

    os_name: str = filter(lambda l: l.startswith('NAME='), lines)

    if os_name.contains('Arch'):
        return 'pacman'
        # TODO: add other package managers here.
    else:
        return 'apt'


def format_symlink_str(build_index: dict, symlink: str) -> str:
    """Format string applied to each symlink path."""
    # TODO: format string with environment variables.
    installer_dir = str(Path(__file__).parent)
    config_dir = build_index['vars']['config_dir'].replace(
        '{HOME}', os.environ['HOME'])

    formatted_symlink = (symlink.replace('{PWD}', installer_dir).replace(
        '{CONFIG_DIR}', config_dir))
    return formatted_symlink


def get_data(
    data: InstallData,
    datatype: str,
    format_func=None,
) -> set[str]:
    f"""Retrieve a set of {datatype}."""
    install_keys = data.build_index['install']['config_keys']
    data_values = []

    pprint(f'Including {datatype} from sections: ', install_keys)

    for k, v in data.build_index['configs'].items():
        if k in install_keys:
            if datatype in v.keys():
                if v[datatype]:
                    if format_func:
                        pfunc = partial(format_func, data.build_index)
                        values = list(map(pfunc, v[datatype]))
                        data_values = data_values + values
                    else:
                        data_values = data_values + v[datatype]
    return set(data_values)


get_to_install = partial(get_data, **{
    'datatype': 'packages',
    'format_func': None
})
get_symlinks = partial(
    get_data, **{
        'datatype': 'symlinks',
        'format_func': format_symlink_str
    })


def create_symlinks(symlinks: list, dryrun=False) -> list:
    symlink_cmd = ['ln', '-s']
    result = []
    for s in symlinks:
        if dryrun:
            result.append(shlex.join(symlink_cmd) + ' ' + s)

    return result


def install_packages(package_manager: str,
                     packages: list,
                     dryrun=False) -> str:
    pm_cmd = None
    match package_manager:
        case 'pacman':
            pm_cmd = ['sudo', 'pacman', '-S']
        case 'apt':
            pm_cmd = ['sudo', 'apt', 'install']

    install_cmd = pm_cmd + packages

    if dryrun:
        return shlex.join(install_cmd)
    else:
        result = subprocess.run(install_cmd, stderr=subprocess.PIPE)
        return result.stderr.decode()


def main():
    if os.name != 'posix':
        print('Windows is not supported, install a better OS!')
        return

    script_path = Path(__file__).parent

    package_manager = 'pacman'
    package_index = read_yml(script_path / './index.yml')
    build_index = read_yml(script_path / './build.yml')

    config = InstallData(package_index=package_index,
                         build_index=build_index,
                         to_install=set(),
                         symlinks=set())

    config.to_install = get_to_install(config)
    config.symlinks = get_symlinks(config)

    package_list = []
    for p in config.to_install:
        package_list.append(package_index['packages'][p][package_manager][:-1])

    install_result = install_packages(package_manager, package_list, True)
    symlink_result = create_symlinks(config.symlinks, True)

    print()

    # Don't use pprint here.
    print(install_result)
    for s in symlink_result:
        pprint(s)


if __name__ == '__main__':
    main()
