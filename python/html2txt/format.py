""""""


import re
from hyphenate import hyphenate_word


def format_block(text, **config):
    """"""
    return text


def center(text, **config):
    """"""
    return "\n".join([x.center(config['textwidth']).rstrip()
                      for x in text.splitlines()])


def space(text, **config):
    """"""
    return " ".join(list(text))


def underline(text, **config):
    """"""
    parts = text.splitlines()
    r = u""
    for part in parts:
        r += part + "\n" + \
             (config['char'] * len(part.strip())).center(config['textwidth']).rstrip() + \
             "\n"
    return r


def join_blocks(b1, b2, margin):
    """"""
    return b1+b2


def normalize_space(text, isblock=False):
    """"""
    text = re.sub(r'\s+', ' ', text)
    if isblock:
        text = text.strip()
    return text


def format_pre(string, **config):
    """"""
    return string


