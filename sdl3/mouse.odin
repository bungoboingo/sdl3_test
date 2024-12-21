package sdl3

import "core:c"

Cursor :: struct {}

MOUSE_BUTTON :: #force_inline proc "c" (X: c.int) -> c.int {return 1 << u32(X - 1)}

MOUSE_BUTTON_LEFT :: 1
MOUSE_BUTTON_MIDDLE :: 2
MOUSE_BUTTON_RIGHT :: 3
MOUSE_BUTTON_X1 :: 4
MOUSE_BUTTON_X2 :: 5
MOUSE_BUTTON_LMASK :: 1 << (MOUSE_BUTTON_LEFT - 1)
MOUSE_BUTTON_MMASK :: 1 << (MOUSE_BUTTON_MIDDLE - 1)
MOUSE_BUTTON_RMASK :: 1 << (MOUSE_BUTTON_RIGHT - 1)
MOUSE_BUTTON_X1MASK :: 1 << (MOUSE_BUTTON_X1 - 1)
MOUSE_BUTTON_X2MASK :: 1 << (MOUSE_BUTTON_X2 - 1)

MouseWheelDirection :: enum u32 {
	NORMAL, /**< The scroll direction is normal */
	FLIPPED, /**< The scroll direction is flipped / natural */
}
