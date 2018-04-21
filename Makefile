BUILD_DIR = bin
SRC_DIR = src

SL_SOURCES := $(wildcard $(SRC_DIR)/*.sl)
SDL_TARGETS:= $(SL_SOURCES:.sl=.sdl)
SDL_TARGETS:= $(subst src,bin,$(SDL_TARGETS))

all: shadows render convert clean

compile: $(SDL_TARGETS)
	
bin/%.sdl: src/%.sl
	shaderdl.exe -o $@ $<

render: compile shadows
	renderdl.exe -id rib/platon.rib

shadows: compile
	renderdl.exe rib/shadows.rib
	tdlmake.exe -shadow sun.depth sun.tdl

convert: # using imagemagick
	convert platon.tif platon.jpg

clean:
	rm *.tif *depth *.tdl