# BEGIN: DIDEROT SETUP

LABEL_COURSE="CMU:Pittsburgh, PA:15XYZ:Fall:2020-21"

## Label for textbook
LABEL_TEXTBOOK="admin"

GUIDE_DIR = ../../diderot-guide
CLI_DIR = ../../diderot-cli
DIDEROT_ADMIN = $(CLI_DIR)/diderot_admin

## XML target rules
include $(GUIDE_DIR)/resources/makefile-xml-target

## CLI upload targets
include $(CLI_DIR)/resources/makefile-upload-to-diderot

# END: DIDEROT SETUP


# BEGIN: Local setup
PDFLATEX = pdflatex

FLAG_VERBOSE = -v 
FLAG_DEBUG = -d

PREAMBLE = ./templates/preamble-diderot.tex


ifeq ($(OS),Windows_NT)
	DC_HOME = $(GUIDE_DIR)/bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		DC_HOME = $(GUIDE_DIR)/bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		DC_HOME = $(GUIDE_DIR)/bin/macos
	endif
endif

#DC_HOME = ~/DC
DC = $(DC_HOME)/dc

# END: local setup


default: pdf

all:  guide html pdf

FORCE:

.PHONY: book

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 


html: FORCE
	$(PANDOC) -s book-html.tex > book.html



%.pdf : %.tex book
	$(PDFLATEX) --shell-escape --jobname="target" "\includeonly{$*}\input{book} ";
	mv target.pdf $@

book:
	$(PDFLATEX) --jobname="book" book

syllabus: syllabus/syllabus.xml syllabus/syllabus.pdf
upload_sy: NO=1
upload_sy: PART_NO=1
upload_sy: FILE=syllabus/syllabus
upload_sy: ATTACH=syllabus/*.p*
upload_sy: syllabus upload_xml_attach
