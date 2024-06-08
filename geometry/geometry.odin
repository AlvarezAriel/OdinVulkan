package geometry

import vk "vendor:vulkan"

MyVertex :: struct {
	pos:   [2]f32,
	color: [3]f32,
}

my_vertices := []MyVertex{
	{{-0.5, -0.5}, {0.0, 0.0, 1.0}},
	{{ 0.5, -0.5}, {1.0, 0.0, 0.0}},
	{{ 0.5,  0.5}, {0.0, 1.0, 0.0}},
	{{-0.5,  0.5}, {1.0, 1.0, 1.0}},
};

my_indices := []u16{
	0, 1, 2,
	2, 3, 0,
};

myVertexBindingDescriptor :: proc() -> vk.VertexInputBindingDescription {
	return vk.VertexInputBindingDescription {
		binding   = 0,
		stride    = size_of(MyVertex),
		inputRate = vk.VertexInputRate.VERTEX, // otherwise use Instance for instance rendering
	}
}

myVertexAttributeDescription :: proc() -> [2]vk.VertexInputAttributeDescription {
	return [2]vk.VertexInputAttributeDescription {
		{
			binding = 0,
			location = 0,
			format = .R32G32_SFLOAT,
			offset = cast(u32)offset_of(MyVertex, pos),
		},
		{
			binding = 0,
			location = 1,
			format = .R32G32B32_SFLOAT,
			offset = cast(u32)offset_of(MyVertex, color),
		},
	}
}