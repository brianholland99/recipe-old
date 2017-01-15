#!/usr/bin/env python3

import subprocess
import os
import os.path
import xml.etree.ElementTree as etree

GHP_DIR = 'docs/'
XML_DIR = 'xml/'
XSL = 'xsl/to_html_simple.xsl'
INDEX_FMT = '<li><a href="%s">%s</a></li>\n'

def get_title(xmlfile):
    tree = etree.parse(xmlfile)
    root = tree.getroot()
    title = root.attrib['title']
    return title

def publish(recipe):
    print(recipe)
    xmlfile = ''.join([XML_DIR, recipe, '.xml'])
    title = get_title(xmlfile)
    htmlfile = ''.join([GHP_DIR, recipe, '.html']) 
    with open(xmlfile) as tmpfd, open(htmlfile, 'w') as htmlfd:
        proc = subprocess.Popen(
            ['xsltproc', XSL, '-'],
            stdout=htmlfd,
            stdin=tmpfd)
    return title


def do_recipes():
    '''
    do_recipes - For all files ending in '.xml' in the xml directory, process
    as a recipe and publish output to docs. Also creates index.html file.
    '''
    recipes = os.listdir('xml')
    with open('docs/index.html', 'w') as index:
        index.write('<html><head><title>Recipe List</title></head>\n')
        index.write('<body><h1>Recipe List</h1><ul>\n')
        for recipe in recipes:
            name, ext = os.path.splitext(recipe)
            # There should only be XML files, but just double check.
            if ext == ".xml":
                title = publish(name)
                index.write(INDEX_FMT % (recipe, title))
        index.write('</ul></body></html>')

do_recipes()
