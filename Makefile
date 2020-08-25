# BEGIN: DIDEROT SETUP

LABEL_COURSE="CMU:Pittsburgh, PA:15001:Fall:2020-21"

## Label for textbook
LABEL_TEXTBOOK="CLASSTECH"

GUIDE_DIR = ../diderot-guide
CLI_DIR = ../diderot-cli
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

PREAMBLE = templates/preamble-diderot.tex


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

## DC_HOME = ~/DC
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


book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

%.pdf : %.tex book
	$(PDFLATEX) --shell-escape --jobname="target" "\includeonly{$*}\input{book} ";
	mv target.pdf $@

intro: intro/intro.xml intro/intro.pdf
upload_intro: NO=1
upload_intro: FILE=intro/intro
upload_intro: intro upload_xml_pdf


equipment: equipment/equipment.xml equipment/equipment.pdf
upload_equipment: NO=2
upload_equipment: FILE=equipment/equipment
upload_equipment: equipment upload_xml_pdf


displays: displays/displays.xml displays/displays.pdf
upload_displays: NO=3
upload_displays: FILE=displays/displays
upload_displays: displays upload_xml_pdf


tas: tas/tas.xml tas/tas.pdf
upload_tas: NO=4
upload_tas: FILE=tas/tas
upload_tas: tas upload_xml_pdf


panopto: panopto/panopto.xml panopto/panopto.pdf
upload_panopto: NO=5
upload_panopto: FILE=panopto/panopto
upload_panopto: panopto upload_xml_pdf


youtube: youtube/youtube.xml youtube/youtube.pdf
upload_youtube: NO=6
upload_youtube: FILE=youtube/youtube
upload_youtube: youtube upload_xml_pdf
