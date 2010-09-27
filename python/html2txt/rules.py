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
    tmp = first
    config['textwidth'] = config['textwidth'] - len(before) - len(after)
    for child in node.contents:
        if hasattr(child, 'contents'):
            if child.name in BLOCK_ELEMENTS:
                string += format_block(tmp, **config)
                string += apply_rules(child, **config)
                tmp = ""
            else:
                tmp += apply_rules(child, **config)
        else:
            tmp += child
    if tmp:
        string += format_block(tmp, **config)
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
    return OPEN_QUOTE + inline(node, **config) + CLOSE_QUOTE


def code(node, **config):
    return "[" + inline(node, **config) + "]"
samp = code
tt = code


def a(node, **config):
    string = inline(node, **config)
    if 'href' in node and node['href'] != node.string:
        string += u" <"+node['href']+u">"
    return string


def rt(node, **config):
    """Ruby annotation: Add parentheses if no <rp> is there"""
    if node.previous is None or node.previous.name != "rp":
        return "(" + inline(node, **config) + ")"
    return inline(node, **config)

