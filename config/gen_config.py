#!/usr/bin/env python3

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

# generate config file based on sample config
# def help():

def main():
    parser = argparse.ArgumentParser(description='generate config based on sample config')
    parser.add_argument('benchmark', metavar='benchmark', type=str, choices=supported_benchmarks, help='benchmark type i.e. tpcc, tpch')
    parser.add_argument('system', metavar='system', type=str, choices=supported_databases, help='target database system i.e. mysql, postgres')
    args = parser.parse_args()
    benchmark = args.benchmark
    system = args.system


if __name__ == '__main__':
    main()
