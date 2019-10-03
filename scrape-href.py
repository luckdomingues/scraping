#!/usr/bin/env python3
# Exemplo retirado do livro : WEB SCRAPING COM PYTHON
#
from urllib.request import urlopen
from urllib.error import URLError
from bs4 import BeautifulSoup
import re

html = urlopen("http://www.businesscorp.com.br")
bsOj = BeautifulSoup(html,"lxml")
for link in bsOj.findAll("a", href=re.compile("^https?://")):
	print (link.attrs['href'])
