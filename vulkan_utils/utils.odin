package vulkan_utils

import "core:fmt"
import "core:slice"
import "core:log"
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