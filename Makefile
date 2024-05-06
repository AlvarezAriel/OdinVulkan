compile:
	glslc shaders/shader.frag -fshader-stage=frag -o shaders/frag.spv
	glslc shaders/shader.vert -o shaders/vert.spv

run:
	make compile
	odin run .