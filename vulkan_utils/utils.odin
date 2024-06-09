package vulkan_utils

import "core:fmt"
import "core:log"
import "core:slice"
import "vendor:glfw"
import vk "vendor:vulkan"

find_memory_type :: proc(
	physical_device: vk.PhysicalDevice,
	type_filter: u32,
	properties: vk.MemoryPropertyFlags,
) -> (
	memory_type: u32,
	ok: bool,
) {
	mem_properties: vk.PhysicalDeviceMemoryProperties
	ok = true
	vk.GetPhysicalDeviceMemoryProperties(physical_device, &mem_properties)
	for i in 0 ..< mem_properties.memoryTypeCount {
		if (type_filter & (1 << i) != 0) &&
		   (mem_properties.memoryTypes[i].propertyFlags & properties) == properties {
			memory_type = i
			return
		}
	}
	ok = false
	return
}

create_shader_module :: proc(device: vk.Device, code: []byte) -> (module: vk.ShaderModule) {
	as_u32 := slice.reinterpret([]u32, code)

	create_info := vk.ShaderModuleCreateInfo {
		sType    = .SHADER_MODULE_CREATE_INFO,
		codeSize = len(code),
		pCode    = raw_data(as_u32),
	}
	must(vk.CreateShaderModule(device, &create_info, nil, &module))
	return
}

must :: proc(result: vk.Result, loc := #caller_location) {
	if result != .SUCCESS {
		log.panicf("vulkan failure %v", result, location = loc)
	}
}

create_descriptor_set_layout :: proc(device: vk.Device, descriptorSetLayout: ^vk.DescriptorSetLayout) {
    fmt.printfln("create_descriptor_set_layout")
	uboLayoutBinding := vk.DescriptorSetLayoutBinding {
		binding            = 0,
		descriptorType     = vk.DescriptorType.UNIFORM_BUFFER,
		descriptorCount    = 1,
		stageFlags         = {.VERTEX},
		pImmutableSamplers = nil,
	}

	layoutInfo := vk.DescriptorSetLayoutCreateInfo {
		sType        = vk.StructureType.DESCRIPTOR_SET_LAYOUT_CREATE_INFO,
		bindingCount = 1,
		pBindings    = &uboLayoutBinding,
	}

	must(vk.CreateDescriptorSetLayout(device, &layoutInfo, nil, descriptorSetLayout))
}
