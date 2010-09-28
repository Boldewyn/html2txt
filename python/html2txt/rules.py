""""""


from .tools import *
from .format import *


def apply_rules(node, **config):
    """"""
    if node.name in globals() and callable(globals()[node.name]):
        return globals()[node.name](node, **config)
    elif node.name in BLOCK_ELEMENTS:
        return block(node, **config)
    else:
        return inline(node, **config)


def inline(node, **config):
    """Generic inline element handling"""
    string = u""
    for child in node.contents:
        if hasattr(child, 'contents'):
            string += apply_rules(child, **config)
        else:
            string += child
    return string
rp = inline
span = inline


def block(node, first=u"", before=u"", after=u"", **config):
    """Generic block element handling"""
    string = u""
    tmp = u""
    config['textwidth'] = config['textwidth'] - len(before) - len(after)
    for child in node.contents:
        if hasattr(child, 'contents'):
            if child.name in BLOCK_ELEMENTS:
                string += format_block(first+normalize_space(tmp, True),
                            **config)
                string += apply_rules(child, **config)
                tmp = first = ""
            else:
                tmp += apply_rules(child, **config)
        else:
            tmp += child
    if first + tmp:
        string += format_block(first+normalize_space(tmp, True),
                    **config)
    if before:
        string = join_blocks(before, string)
    if after:
        string = join_blocks(string, after)
    return string
div = block


def p(node, **config):
    """"""
    indent = u""
    if node.previousSibling is not None and \
       getattr(node.previousSibling, 'name', '') == "p":
        indent = u"  "
    return block(node, first=indent, **config)


def h1(node, **config):
    """"""
    string = u""
    for child in node.contents:
        if hasattr(child, 'contents'):
            string += apply_rules(child, **config)
        else:
            string += normalize_space(child, True)
    return format_block(underline(center(space(string, **config),
            **config), char="=", **config), **config)


def pre(node, **config):
    """"""
    string = u""
    for child in node.contents:
        if hasattr(child, 'contents'):
            string += apply_rules(child, **config)
        else:
            string += child
    return format_pre(string, **config)


def br(node, **config):
    return u"\u000A"


def hr(node, **config):
    return u"\u000A" + ("-"*config['textwidth']) + u"\u000A"


def strong(node, **config):
    """"""
    return "*" + inline(node, **config) + "*"
b = strong


def em(node, **config):
    return "/" + inline(node, **config) + "/"
cite = em
dfn = em
i = em
var = em


def q(node, **config):
    return (config['open_quote'] + inline(node, **config) +
            config['close_quote'])


def code(node, **config):
    return "`" + inline(node, **config) + "`"
samp = code
tt = code


def a(node, **config):
    string = inline(node, **config)
    if node.get('href', False) and node['href'] not in string:
        string += u" <"+node['href']+u">"
    return string


def img(node, **config):
    return node.get("alt", u"")


def rt(node, **config):
    """Ruby annotation: Add parentheses if no <rp> is there"""
    if node.previous is None or node.previous.name != "rp":
        return "(" + inline(node, **config) + ")"
    return inline(node, **config)

