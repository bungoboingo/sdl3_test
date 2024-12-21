package main

import "core:fmt"
import "core:os"
import sdl "sdl3"

window: ^sdl.Window
device: ^sdl.GPUDevice

vert_shader_spv := #load("RawTriangle.vert.spv")
frag_shader_spv := #load("SolidColor.frag.spv")

vert_shader: ^sdl.GPUShader
frag_shader: ^sdl.GPUShader
graphics_pipeline: ^sdl.GPUGraphicsPipeline

main :: proc() {
	sdl.Init(.VIDEO)
	window = sdl.CreateWindow("Triangle Test", 1024, 768, sdl.WindowFlags{.RESIZABLE})
	device = sdl.CreateGPUDevice(.SPIRV, true, nil)
	driver := sdl.GetGPUDeviceDriver(device)
	sdl.ClaimWindowForGPUDevice(device, window)

	// Load shaders
	vert_info := sdl.GPUShaderCreateInfo {
		code_size   = len(vert_shader_spv),
		code        = raw_data(vert_shader_spv),
		entry_point = "main",
		format      = sdl.GPUShaderFormat.SPIRV,
		stage       = sdl.GPUShaderStage.VERTEX,
	}

	frag_info := sdl.GPUShaderCreateInfo {
		code_size   = len(frag_shader_spv),
		code        = raw_data(frag_shader_spv),
		entry_point = "main",
		format      = sdl.GPUShaderFormat.SPIRV,
		stage       = sdl.GPUShaderStage.FRAGMENT,
	}

	vert_shader = sdl.CreateGPUShader(device, &vert_info)
	frag_shader = sdl.CreateGPUShader(device, &frag_info)

	// Create graphics_pipeline
	color_target_description := sdl.GPUColorTargetDescription {
		format = sdl.GetGPUSwapchainTextureFormat(device, window),
	}

	pipeline_info := sdl.GPUGraphicsPipelineCreateInfo {
		vertex_shader = vert_shader,
		fragment_shader = frag_shader,
		primitive_type = .TRIANGLE_LIST,
		target_info = sdl.GPUGraphicsPipelineTargetInfo {
			color_target_descriptions = &color_target_description,
			num_color_targets = 1,
		},
	}

	graphics_pipeline = sdl.CreateGPUGraphicsPipeline(device, &pipeline_info)

	sdl.ReleaseGPUShader(device, vert_shader)
	sdl.ReleaseGPUShader(device, frag_shader)

	program: for {
		cmd_buffer := sdl.AcquireGPUCommandBuffer(device)
		swapchain_texture: ^sdl.GPUTexture
		sdl.AcquireGPUSwapchainTexture(cmd_buffer, window, &swapchain_texture, nil, nil)

		color_target_info := sdl.GPUColorTargetInfo {
			texture     = swapchain_texture,
			clear_color = sdl.FColor{0.0, 0.0, 0.0, 1.0},
			load_op     = sdl.GPULoadOp.CLEAR,
			store_op    = sdl.GPUStoreOp.STORE,
		}

		render_pass := sdl.BeginGPURenderPass(cmd_buffer, &color_target_info, 1, nil)
		sdl.BindGPUGraphicsPipeline(render_pass, graphics_pipeline)
		fmt.println("Bound graphics pipeline")
		sdl.DrawGPUPrimitives(render_pass, 3, 1) //SEGFAULT
		sdl.EndGPURenderPass(render_pass)
		sdl.SubmitGPUCommandBuffer(cmd_buffer)
	}

	sdl.ReleaseWindowFromGPUDevice(device, window)
	sdl.DestroyWindow(window)
	sdl.DestroyGPUDevice(device)
}
