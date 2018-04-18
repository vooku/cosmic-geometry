all: render convert

compile:
	shaderdl.exe -d bin src/helloWorld.sl

render: compile
	renderdl.exe -id rib/platon.rib

convert: # using imagemagick
	convert platon.tif platon.png