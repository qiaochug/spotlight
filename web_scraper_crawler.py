# -*- coding: utf-8 -*-
"""
Created on Sat Sep  8 13:05:21 2018

@author: admin
"""

import requests
import unicodedata
import re

def content(url):
    page = requests.get(url).text
    convert_text = unicodedata.normalize('NFKD', page)
    pattern = re.compile('<p>(.*)</p>')
    res_cont = re.findall(pattern, convert_text)
    for i in range(len(res_cont)):
        print(res_cont(i))