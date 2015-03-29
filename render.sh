#!/bin/bash

#build html
bundle exec rake book:build

mv adoc.pdf adoc2.pdf   #this is the asciidoctor pdf build

# legacy asciidoc pdf build
a2x --verbose -fpdf -dbook --fop --icons --icons-dir=$HOME/opt/asciidoc/images/icons adoc.asc
