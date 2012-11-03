DOT=dot
DOTOPTS=-Gcharset=latin1

DIRS	= 

.SUFFIXES:
.SUFFIXES: .gv .png

sources := $(patsubst %.gv,%.png,$(wildcard *.gv))
all : $(sources)
#all : $(sources) subs

.gv.png :
	$(DOT) $(DOTPTS) -Tpng -o $@ -Tcmap -o `basename $@ .png`.map $<
	@echo "<div style=\"border:solid 1px;overflow-x: scroll; overflow-y: hidden;\"><img id=\"graphvizimage\" usemap=\"#dotmap\" src=\"$@\"><map name=\"dotmap\">" > `basename $@ .png`.html
	@cat `basename $@ .png`.map >> `basename $@ .png`.html
	@echo "</map></div>" >> `basename $@ .png`.html

subs : 
	for d in $(DIRS); do echo "looking into: $$d";(cd $$d; make ); done

clean:
	rm -f *.png
	for d in $(DIRS); do echo "looking into: $$d";(cd $$d; make clean ); done

