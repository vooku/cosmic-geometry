BUILD_DIR = bin
SRC_DIR = src

SL_SOURCES := $(wildcard $(SRC_DIR)/*.sl)
SDL_TARGETS:= $(SL_SOURCES:.sl=.sdl)
SDL_TARGETS:= $(subst src,bin,$(SDL_TARGETS))

all: render convert

compile: $(SDL_TARGETS)
	
bin/%.sdl: src/%.sl
	shaderdl.exe -o $@ $<

render: compile
	renderdl.exe -id rib/platon.rib

convert: # using imagemagick
	convert platon.tif platon.jpg