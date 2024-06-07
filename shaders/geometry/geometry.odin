package geometry

import vk "vendor:vulkan"

MyVertex :: struct {
    pos: [2]f32,
    color: [3]f32,
}

my_vertices := []MyVertex{
    MyVertex{{0.0, -0.5}, {1.0, 0.0, 0.0}},
    MyVertex{{0.5, 0.5}, {0.0, 1.0, 0.0}},
    MyVertex{{-0.5, 0.5}, {0.0, 0.0, 1.0}}
}

myVertexBindingDescriptor :: proc() -> vk.VertexInputBindingDescription {
    return vk.VertexInputBindingDescription {
        binding = 0,
        stride = size_of(MyVertex),
        inputRate = vk.VertexInputRate.VERTEX, // otherwise use Instance for instance rendering
    }
}

myVertexAttributeDescription :: proc() -> vk.VertexInputAttributeDescription {
    return vk.VertexInputAttributeDescription {
        binding = 0,
        location = 0,
        format = vk._
        
    }
}