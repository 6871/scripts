#!/usr/bin/env python3
import sys
"""
Generate a table of contents with clickable links for a given markdown file.
"""


def parse_line(line):
    """
    Convert the passed line into a TOC entry with a clickable markdown link.
    :param line: The file line to be converted to a TOC entry.
    :return: The formatted TOC entry.
    """
    indent = 2
    delimiter_position = line.find(' ')
    level = line[:delimiter_position].count('#')

    item_text = line[delimiter_position + 1:]
    item_link = line[delimiter_position + 1:].lower()\
        .replace(' ', '-')\
        .replace("'", '')\
        .replace('.', '')\
        .replace(',', '')\
        .replace(';', '')\
        .replace(':', '')\
        .replace('/', '')\
        .replace('\\', '')\
        .replace('(', '')\
        .replace(')', '')\
        .replace('[', '')\
        .replace('[', '')\
        .replace('{', '')\
        .replace('}', '')\
        .replace('+', '')\
        .replace('*', '')\
        .replace('&', '')\
        .replace('@', '')\
        .replace('$', '')\
        .replace('#', '')\
        .replace('£', '')\
        .replace('!', '')\
        .replace('=', '')\
        .replace('"', '')\
        .replace('>', '')\
        .replace('<', '')\
        .replace('?', '')\
        .replace('~', '')\
        .replace('`', '')\
        .replace('|', '')\
        .replace('^', '')\
        .replace('%', '')\
        .replace('_', '')

    return (
        f'{" " * ((level - 1) * indent)}* '
        f'[{item_text}]'
        f'(#{item_link})'
    )


def get_toc(input_file):
    """
    Read input_file and return list of table of content entries with markdown links.

    :param input_file: The markdown file for which a TOC will be generated.
    :return: List of formatted TOC entries.
    """
    toc = []
    skipping_block = False  # to track and skip ```code``` blocks
    with open(input_file) as f:
        for raw_line in f:
            line = raw_line.rstrip('\n')
            if line.count('```') % 2 == 1:
                skipping_block = not skipping_block
            if not skipping_block:
                if len(line) > 0 and line[0] == '#':
                    toc.append(parse_line(line))
    return toc


def print_toc(toc):
    """
    Print given list of toc entries.
    :param toc: list of toc entries to print
    """
    for entry in toc:
        print(entry)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        raise ValueError('usage: input_file')

    print_toc(get_toc(sys.argv[1]))
