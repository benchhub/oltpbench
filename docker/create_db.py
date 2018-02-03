#!/usr/bin/env python3

'''
cli for creating database based on catalog
'''

import os
import argparse
import logging
import subprocess  # NOTE: we use older API because travis have Python 3.4.3

import yaml

# CATALOG_BENCHMARK_FILE = '../config/benchmarks.yml'
CATALOG_DATABASE_FILE = '../config/databases.yml'


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
        if not self.database in self.catalog_databases:
            logging.error(
                'database %s is not in catalog, check config/databases.yml or run `config/config.py benchmarks`', self.database)
            exit(1)
        db = self.catalog_databases[self.database]
        cmd = db['shell_exec']
        sql = db['create_db'].replace('{db}', self.benchmark)
        cmd = cmd.replace('{username}', db['username']).replace(
            '{password}', db['password']).replace('{sql}', sql)
        logging.debug(cmd)
        code = subprocess.call([
            'docker-compose', '-f', self.database + '.yml',
            'exec', self.database, 'bash', '-c', cmd
        ])
        if code != 0:
            logging.error('non zero return code %d', code)
            exit(1)
        print('created database {} for {}'.format(self.benchmark, self.database))


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
