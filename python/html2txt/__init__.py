""""""


from BeautifulSoup import BeautifulSoup
from .rules import apply_rules as _ar


def convert(file_or_name, **config):
    """"""
    if isinstance(file_or_name, basestring):
        html = BeautifulSoup(open(file_or_name, 'rb').read())
    else:
        file_or_name.seek(0)
        html = BeautifulSoup(file_or_name.read())
    return _convert(html, **config)


def convert_string(string, **config):
    """"""
    return _convert(BeautifulSoup(string), **config)


def _convert(soup, **config):
    """"""
    config["textwidth"] = config.get("textwidth", 78)
    config["class_prefix"] = config.get("class_prefix", "h2t")
    config["pageheight"] = config.get("paged", 50)
    config["align"] = config.get("align", "justify")
    return _ar(soup.body, **config)
