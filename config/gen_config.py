#!/usr/bin/env python3
"""
generate config file based on sample config
TODO: might change it to config gen, config benchmark etc.
"""

import sys
import argparse
import yaml

supported_benchmarks = {
    'auctionmark',
    'chbenchmark',
    'epinions',
    'hyadapt',
    'jpab',
    'linkbench',
    'noop',
    'resourcestresser',
    'seats',
    'sibench',
    'smallbank',
    'tatp',
    'tpcc',
    'tpcds',
    'tpch',
    'twitter',
    'voter',
    'wikipedia',
    'ycsb'
}

supported_databases = {
    'db2',
    'mysql',
    'myrocks',
    'postgresql',
    'oracle',
    'sqlserver',
    'sqlite',
    'amazonrds',
    'sqlazure',
    'hsqldb',
    'h2',
    'monetdb',
    'nuodb',
    'timesten',
    'peloton',
    'cassandra',
    'comdb2',
    'saphana',
    'splicemachine',
    'firebird',
    'cubrid',
    'clickhouse',
    'memsql'
}

NAME_PRIMARY = 1
NAME_ALIAS = 2


def check_duplicate_name(benchmarks):
    known_names = {}
    for name, bench in benchmarks.items():
        if name in known_names:
            print("dup: name " + name + " already exists")
            return False
        known_names[name] = NAME_PRIMARY
        for alias in bench['alias']:
            if alias in known_names:
                print("dup: alias for " + name +
                      " " + alias + " already exists")
                return False
            known_names[alias] = NAME_ALIAS
    return True


def valid_benchmarks():
    with open('benchmarks.yml', 'r') as f:
        try:
            benchmarks = yaml.safe_load(f)
        except yaml.YAMLError as ex:
            print(ex)
    # print(benchmarks)
    check_duplicate_name(benchmarks)


def valid(args):
    print("valid")
    print(args)


def generate(args):
    print("generate")
    print(args)


def sub_commands(add_arg):
    # Create child commands
    # use required option to make the option mandatory
    # Use metavar to print description for what kind of input is expected
    add_arg.add_argument("--state", help='Location to tf state file',
                         default='state.xml',
                         metavar='<file>', required=True)
    add_arg.add_argument("--varfile", help='Location to input variables files',
                         default='var.xml',
                         metavar='<file>', required=True)


def main():
    # TODO: sub command? load choices from YAML file?
    # parser = argparse.ArgumentParser(description='generate config based on sample config')
    # parser.add_argument('benchmark', metavar='benchmark', type=str, choices=supported_benchmarks, help='benchmark type i.e. tpcc, tpch')
    # parser.add_argument('system', metavar='system', type=str, choices=supported_databases, help='target database system i.e. mysql, postgres')
    # args = parser.parse_args()
    # benchmark = args.benchmark
    # system = args.system

    # valid_benchmarks()

    #     # https://chase-seibert.github.io/blog/2014/03/21/python-multilevel-argparse.html
    #     parser = argparse.ArgumentParser(
    #         description='Oltpbench configuration util',
    #         usage='''config.py <command> [<args>]

    # Available Commands:
    # TODO: ...
    # '''
    #     )
    #     parser.add_argument('command', help='Subcommand to run')
    #     args = parser.parse_args(sys.argv[1:2])
    #     if not args.command:
    #         print("Unrecognized command")
    #         parser.print_help()
    #         exit(1)
    #     # TODO: sub parser ?...

    # https://docs.python.org/3/library/argparse.html#sub-commands
    # http://roshpr.net/blog/2016/09/argparse-adding-sub-commands-to-your-command-line-arguments/
    # https://chase-seibert.github.io/blog/2014/03/21/python-multilevel-argparse.html
    parser = argparse.ArgumentParser(
        description='Oltpbench configuration util')
    parser.add_argument('--bench', metavar='<benchmark>',
                        type=str, help='benchmark type i.e. tpcc, tpch')
    commands = parser.add_subparsers(dest='subcommand',
                                     title='subcommands', description='valid subcommands',
                                     help='subcommands')
    cmd_valid = commands.add_parser(
        'valid', help='Check catalog and config template consistency')
    cmd_valid.set_defaults(func=valid)
    cmd_gen = commands.add_parser(
        'generate', help='Generate config base on template')
    cmd_gen.set_defaults(func=generate)
    args = parser.parse_args()
    # print(args)
    if not args.subcommand:
        parser.print_help()
        exit(1)
    else:
        args.func(args)


if __name__ == '__main__':
    main()
