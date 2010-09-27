""""""


def localize(lang):
    """"""
    return u"\u201C", u"\u201D", u"\u2018", u"\u2019"


OPEN_QUOTE, CLOSE_QUOTE, OPEN_SINGLE_QUOTE, CLOSE_SINGLE_QUOTE = localize("en")


BLOCK_ELEMENTS = ("address", "article", "aside", "blockquote", "body", "center",
                  "dd", "dialog", "dir", "div", "dl", "dt", "figure", "footer",
                  "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hgroup",
                  "hr", "html", "legend", "listing", "menu", "nav", "ol", "p",
                  "plaintext", "pre", "section", "ul", "xmp")

