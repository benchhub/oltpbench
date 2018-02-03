#!/usr/bin/env python3

'''
cli for creating database based on catalog
'''

import os
import argparse
import logging
import subprocess # TODO: 3.6 has newer API

import yaml

# CATALOG_BENCHMARK_FILE = '../benchmarks.yml'
CATALOG_DATABASE_FILE = '../databases.yml'


def load_yaml(file):
    with open(file, 'r') as f:
        try:
            d = yaml.safe_load(f)
        except yaml.YAMLError:
            # TODO: the stack trace is not necessary, just need to show where the yaml is wrong
            logging.exception('invalid YAML %s', file)
            exit(1)
    return d


class DbUtil:
    def __init__(self):
        self.benchmark = ''
        self.database = ''

    def read_args(self, args):
        # TODO: allow alias, or just drop alias support
        self.benchmark = args.bench.lower()
        self.database = args.db.lower()

    def load_catalog(self):
        self.catalog_databases = load_yaml(CATALOG_DATABASE_FILE)

    def create_db(self):
        pass


def main():
    cli = DbUtil()
    parser = argparse.ArgumentParser(
        description='create database util')
    parser.add_argument('--bench', metavar='<benchmark>',
                        type=str, help='benchmark type i.e. tpcc, tpch', required=True)
    parser.add_argument('--db', metavar='<database>',
                        type=str, help='target database i.e. mysql, postgres', required=True)
    parser.add_argument('--verbose', dest='verbose',
                        help='verbose logging', action='store_true')
    args = parser.parse_args()
    if args.verbose:
        logging.basicConfig(level=logging.DEBUG)
    else:
        logging.basicConfig(level=logging.INFO)
    cli.read_args(args)
    # switch to directory of create_db.py
    dir_path = os.path.dirname(os.path.realpath(__file__))
    os.chdir(dir_path)
    cli.load_catalog()
    cli.create_db()


if __name__ == '__main__':
    main()
