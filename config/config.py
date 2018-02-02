#!/usr/bin/env python3
"""
valid and generate config file based on catalog and template
"""

import sys
import logging
import argparse
import yaml

NAME_PRIMARY = 1
NAME_ALIAS = 2
CATALOG_BECHMARK_FILE = 'benchmarks.yml'
CATALOG_DATABASE_FILE = 'databases.yml'


def has_duplicate_name(entities):
    known_names = {}
    dup = False
    for name, entity in entities.items():
        if name in known_names:
            logging.error("dup: name %s already exists", name)
            dup = True
        known_names[name] = NAME_PRIMARY
        if not 'alias' in entity:
            continue
        for alias in entity['alias']:
            if alias in known_names:
                logging.error(
                    "dup: alias %s for %s already exists", name, alias)
                dup = True
            known_names[alias] = NAME_ALIAS
    return dup


def print_names(entities):
    for name, entity in entities.items():
        s = name
        if 'alias' in entity:
            s = s + ' ' + ','.join(entity['alias'])
        print(s)


def validate_benchmarks():
    logging.debug("validate %s", CATALOG_BECHMARK_FILE)
    benchmarks = load_yaml(CATALOG_BECHMARK_FILE)
    has_duplicate_name(benchmarks)
    return benchmarks


def validate_databases():
    logging.debug("validate %s", CATALOG_DATABASE_FILE)
    databases = load_yaml(CATALOG_DATABASE_FILE)
    has_duplicate_name(databases)
    return databases


def load_yaml(file):
    with open(file, 'r') as f:
        try:
            d = yaml.safe_load(f)
        except yaml.YAMLError:
            # TODO: the stack trace is not necessary, just need to show where the yaml is wrong
            logging.exception("invalid YAML %s", file)
            exit(1)
    return d


class ConfigUtil:
    def __init__(self):
        self.foo = 'bar'
        self.benchmark = ''
        self.database = ''
        self.catalog_benchmarks = None
        self.catalog_databases = None
        self.validated = False

    def read_args(self, args):
        self.benchmark = args.bench
        self.database = args.db

    def valid(self):
        if self.validated:
            return
        self.catalog_benchmarks = validate_benchmarks()
        self.catalog_databases = validate_databases()
        self.validated = True

    def generate(self):
        logging.debug("generate")

    def benchmarks(self):
        self.valid()
        print_names(self.catalog_benchmarks)

    def databases(self):
        self.valid()
        print_names(self.catalog_databases)


def main():
    cli = ConfigUtil()
    # https://docs.python.org/3/library/argparse.html#sub-commands
    parser = argparse.ArgumentParser(
        description='Oltpbench configuration util')
    # subcommands
    commands = parser.add_subparsers(dest='subcommand',
                                     title='subcommands', description='valid subcommands',
                                     help='subcommands')
    commands.add_parser(
        'valid', help='Check catalog and config template consistency')
    commands.add_parser(
        'generate', help='Generate config base on template')
    commands.add_parser(
        'benchmarks', help='List supported benchmarks')
    commands.add_parser(
        'databases', help='List supported databases')
    # global flags
    # NOTE: you have to apply them before sub command, i.e. config.py --verbose valid instead of config.py valid --verbose
    parser.add_argument('--verbose', dest='verbose',
                        help='verbose logging', action='store_true')
    parser.set_defaults(verbose=False)
    parser.add_argument('--bench', metavar='<benchmark>',
                        type=str, help='benchmark type i.e. tpcc, tpch')
    parser.add_argument('--db', metavar='<database>',
                        type=str, help='target database i.e. mysql, postgres')
    args = parser.parse_args()
    # print(args)
    if not args.subcommand:
        parser.print_help()
        exit(1)
    if args.verbose:
        logging.basicConfig(level=logging.DEBUG)
    else:
        logging.basicConfig(level=logging.INFO)
    cli.read_args(args)
    # dispatch
    if args.subcommand == 'valid':
        cli.valid()
    elif args.subcommand == 'generate':
        cli.generate()
    elif args.subcommand == 'benchmarks':
        cli.benchmarks()
    elif args.subcommand == 'databases':
        cli.databases()
    else:
        print("unknown command")
        exit(1)


if __name__ == '__main__':
    main()
