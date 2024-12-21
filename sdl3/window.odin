package sdl3
import "core:c"
foreign import lib "system:SDL3"

Window :: struct {}

WindowFlag :: enum u64 {
	// Window is in fullscreen mode
	FULLSCREEN         = 0,
	// Window usable with OpenGL context
	OPENGL             = 1,
	// Window is occluded
	OCCLUDED           = 2,
	// Window is neither mapped onto the desktop nor shown in the taskbar/dock/window list; SDL_ShowWindow() is required for it to become visible
	HIDDEN             = 3,
	// No window decoration
	BORDERLESS         = 4,
	// Window can be resized
	RESIZABLE          = 5,
	// Window is minimized
	MINIMIZED          = 6,
	// Window is maximized
	MAXIMIZED          = 7,
	// Window has grabbed mouse input
	MOUSE_GRABBED      = 8,
	// Window has input focus
	INPUT_FOCUS        = 9,
	// Window has mouse focus
	MOUSE_FOCUS        = 10,
	// Window not created by SDL
	EXTERNAL           = 11,
	// Window is modal
	MODAL              = 12,
	// Window uses high pixel density back buffer if possible
	HIGH_PIXEL_DENSITY = 13,
	// Window has mouse captured (unrelated to MOUSE_GRABBED)
	MOUSE_CAPTURE      = 14,
	// Window has relative mode enabled
	RELATIVE_MODE      = 15,
	// Window should always be above others
	ALWAYS_ON_TOP      = 16,
	// Window should be treated as a utility window, not showing in the task bar and window list
	UTILITY            = 17,
	// Window should be treated as a tooltip and does not get mouse or keyboard focus, requires a parent window
	TOOLTIP            = 18,
	// Window should be treated as a popup menu, requires a parent window
	POPUP_MENU         = 19,
	// Window has grabbed keyboard input
	KEYBOARD_GRABBED   = 20,
	// Window usable for Vulkan surface
	VULKAN             = 28,
	// Window usable for Metal view
	METAL              = 29,
	// Window with transparent buffer
	TRANSPARENT        = 30,
	// Window should not be focusable
	NOT_FOCUSABLE      = 31,
}

WindowFlags :: distinct bit_set[WindowFlag;u32]

WINDOW_FULLSCREEN :: WindowFlags{.FULLSCREEN}
WINDOW_OPENGL :: WindowFlags{.OPENGL}
WINDOW_OCCLUDED :: WindowFlags{.OCCLUDED}
WINDOW_HIDDEN :: WindowFlags{.HIDDEN}
WINDOW_BORDERLESS :: WindowFlags{.BORDERLESS}
WINDOW_RESIZABLE :: WindowFlags{.RESIZABLE}
WINDOW_MINIMIZED :: WindowFlags{.MINIMIZED}
WINDOW_MAXIMIZED :: WindowFlags{.MAXIMIZED}
WINDOW_MOUSE_GRABBED :: WindowFlags{.MOUSE_GRABBED}
WINDOW_INPUT_FOCUS :: WindowFlags{.INPUT_FOCUS}
WINDOW_MOUSE_FOCUS :: WindowFlags{.MOUSE_FOCUS}
WINDOW_EXTERNAL :: WindowFlags{.EXTERNAL}
WINDOW_MODAL :: WindowFlags{.MODAL}
WINDOW_HIGH_PIXEL_DENSITY :: WindowFlags{.HIGH_PIXEL_DENSITY}
WINDOW_MOUSE_CAPTURE :: WindowFlags{.MOUSE_CAPTURE}
WINDOW_RELATIVE_MODE :: WindowFlags{.RELATIVE_MODE}
WINDOW_ALWAYS_ON_TOP :: WindowFlags{.ALWAYS_ON_TOP}
WINDOW_UTILITY :: WindowFlags{.UTILITY}
WINDOW_TOOLTIP :: WindowFlags{.TOOLTIP}
WINDOW_POPUP_MENU :: WindowFlags{.POPUP_MENU}
WINDOW_KEYBOARD_GRABBED :: WindowFlags{.KEYBOARD_GRABBED}
WINDOW_VULKAN :: WindowFlags{.VULKAN}
WINDOW_METAL :: WindowFlags{.METAL}
WINDOW_TRANSPARENT :: WindowFlags{.TRANSPARENT}
WINDOW_NOT_FOCUSABLE :: WindowFlags{.NOT_FOCUSABLE}

@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
	// Create a window with the specified dimensions & `flags`.
	CreateWindow :: proc(title: cstring, w, h: c.int, flags: WindowFlags) -> ^Window ---
	// Destroy a window
	DestroyWindow :: proc(window: ^Window) ---
	// Gets the window size
	GetWindowSize :: proc(window: ^Window, w: ^c.int, h: ^c.int) -> bool ---
	// Gets the surface for the window
	GetWindowSurface :: proc(window: ^Window) -> ^Surface ---
	SetWindowSurfaceVSync :: proc(window: ^Window, vsync: i8) -> bool ---
}
