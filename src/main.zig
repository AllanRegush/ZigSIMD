const std    = @import("std");
const print  = std.debug.print;
// Import C Internisics Header
// https://ziglang.org/documentation/0.8.1/#C
const c      = @cImport({
    // Intel Internsics Guide
    // https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html
    @cInclude("emmintrin.h");
});



// Program Outputs:
// SIMD Testing with Zig :)
// Value of XY: 11, 21, 31, 41
pub fn main() anyerror!void {
    print("SIMD Testing with Zig :)\n", .{});
    // Use some SSE Instructions
    // Look these up in the Intrensics Guide for more information.
    // Using C functions.
    // Zig uses the <lib>.<func> and <lib>.<type> convention.
    const x : c.__m128i = c._mm_set_epi32(10, 20, 30, 40);
    const y : c.__m128i = c._mm_set_epi32(1, 1, 1, 1);
    const xy: c.__m128i = c._mm_add_epi8(x, y);
    const mask: u64 = 0xFFFFFFFF00000000;
    const upper_ux0: i32 = @intCast(i32, ((@intCast(u64, xy[0]) & mask) >> 32));
    const upper_ux1: i32 = @intCast(i32, ((@intCast(u64, xy[1]) & mask) >> 32));
    print("Value of XY: {}, {}, {}, {}\n", .{ upper_ux1,
                                              @truncate(i32, xy[1]),
                                              upper_ux0,
                                              @truncate(i32, xy[0]) });
}