""""""


class Config(object):
    """Access dict via member notation"""

    def __init__(self, dictionary=None):
        if dictionary is None:
            dictionary = {}
        self.__dict__.update(dictionary)

    def update(self, dictionary):
        self.__dict__.update(dictionary)

    def ___getattr___(self, name):
        return self.__dict__.get(name, None)

    def __setattr__(self, name, value):
        self.__dict__[name] = value

    def __delattr__(self, name):
        if name in self.__dict__:
            del self.__dict__[name]


def localize(lang):
    """"""
    return u"\u201C", u"\u201D", u"\u2018", u"\u2019"


OPEN_QUOTE, CLOSE_QUOTE, OPEN_SINGLE_QUOTE, CLOSE_SINGLE_QUOTE = localize("en")


BLOCK_ELEMENTS = ("address", "article", "aside", "blockquote", "body", "center",
                  "dd", "dialog", "dir", "div", "dl", "dt", "figure", "footer",
                  "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hgroup",
                  "hr", "html", "legend", "listing", "menu", "nav", "ol", "p",
                  "plaintext", "pre", "section", "ul", "xmp")

