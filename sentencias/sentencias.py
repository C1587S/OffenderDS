#! /usr/bin/env python
# -*- coding: utf-8 -*-

import psycopg2
import psycopg2.extras

import sys
from datetime import timedelta

import click

import io

from dynaconf import settings

from pathlib import Path

@click.group() # Nos permite registrar otros comandos de Click a continuación
@click.pass_context #will make our callback also get the context passed on which we memorized the repo, otherwise, the context object would be entirely hidden from us.
def sentencias(ctx):
"""
Decorador que nos permite establecer la conexión a la base de datos en postgres, usando los parámetros establecidos en el archivo settings.toml, así como la ruta en la que encontraremos los archivos con las consultas a ejecutar. 
"""
    ctx.ensure_object(dict)
    conn = psycopg2.connect(settings.get('PGCONNSTRING'))
    conn.autocommit = True
    ctx.obj['conn'] = conn

    queries = {}
    for sql_file in Path('sql').glob('*.sql'):
        with open(sql_file,'r') as sql:
            sql_key = sql_file.stem
            query = str(sql.read())
            queries[sql_key] = query
    ctx.obj['queries'] = queries

@sentencias.command()
@click.pass_context
def create_schemas(ctx):
"""
Realiza la conexión a la base de datos, ejecuta e imprime el query create_schemas, que crea los esquemas raw, cleaned y semantic
"""
    query = ctx.obj['queries'].get('create_schemas')
    conn=ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)
    print(query)


@sentencias.command()
@click.pass_context
def create_raw_tables(ctx):
"""
Genera la conexión a la base de datos, ejecuta e imprime el query create_raw_tables, que crea las tablas del esquema raw
"""
    query = ctx.obj['queries'].get('create_raw_tables')
    conn=ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)
    print(query)

@sentencias.command()
@click.pass_context
def load_sentencias(ctx):
"""
Función para poblar las tablas del esquema raw a partir de los archivos csv de la ruta sentenciasDIR (definida en el archivo settings.toml)
"""
    conn = ctx.obj['conn']
    with conn.cursor() as cursor:
        for data_file in Path(settings.get('sentenciasDIR')).glob('*.csv'):
            print(data_file)
            table = data_file.stem
            print(table)
            sql_statement = f"copy raw.{table} from stdin with csv header delimiter as ','"
            print(sql_statement)
            buffer = io.StringIO()
            with open(data_file,'r') as data:
                buffer.write(data.read())
            buffer.seek(0)
            cursor.copy_expert(sql_statement, file=buffer)

@sentencias.command()
@click.pass_context
def helpers(ctx):
"""
Carga las funciones auxiliares definidas en el archivo helpers.sql
"""
    query = ctx.obj['queries'].get('helpers')
    conn=ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)
    print(query)


@sentencias.command()
@click.pass_context
def to_cleaned(ctx):
"""
Genera la conexión a la base de datos, ejecuta e imprime el query to_cleaned, que crea la tabla sentencias2017 del esquema cleaned a partir de las tablas del esquema raw
"""
    query = ctx.obj['queries'].get('to_cleaned')
    conn=ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)
    print(query)

@sentencias.command()
@click.pass_context
def to_semantic(ctx):
"""
Genera la conexión a la base de datos, ejecuta e imprime el query to_semantic, que crea las tablas del esquema semantic a partir de las tablas del esquema cleaned
"""
    query = ctx.obj['queries'].get('to_semantic')
    conn=ctx.obj['conn']
    with conn.cursor() as cur:
        cur.execute(query)
    print(query)

@sentencias.command()
@click.pass_context
def create_features():
    query = ctx.obj['queries'].get('create_features')
    print(query)


if __name__ == '__main__':
    sentencias()
