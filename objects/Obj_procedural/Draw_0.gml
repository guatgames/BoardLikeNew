/// @description Draw Event for Obj_procedural - Visualizes the generated map
///
/// This event iterates through the `map_grid` and draws a representation of each
/// room/cell based on its type. It uses placeholder drawing functions (e.g.,
/// colored rectangles) to represent different room types.
///
/// Assumes the following instance variables are available from the Create event:
/// - map_grid: The ds_grid containing the map layout.
/// - grid_width: The width of the map_grid.
/// - grid_height: The height of the map_grid.
///
/// Assumes the following room type constants (#macro) are defined:
/// - ROOM_NULL
/// - ROOM_NORMAL
/// - ROOM_START
/// - ROOM_BOSS
/// - ROOM_TREASURE
/// - (any other custom room types like ROOM_SHOP)
///
// --- BEGIN DRAW EVENT LOGIC ---

// 1. Define Tile/Room Size for Drawing
//    These values determine the pixel dimensions of each cell on the screen.
var tile_width = 32;  // Example: Each grid cell is 32 pixels wide
var tile_height = 32; // Example: Each grid cell is 32 pixels tall

// Optional: Define an offset for drawing the entire map.
// This allows the map to be drawn relative to the object's position or a fixed screen point.
var map_offset_x = x; // Draw relative to the object's x position
var map_offset_y = y; // Draw relative to the object's y position
// Alternatively, for a fixed origin (e.g., top-left of the view):
// var map_offset_x = 0;
// var map_offset_y = 0;

// 2. Iterate through map_grid
//    Use nested loops to visit every cell in the grid.
for (var i = 0; i < grid_width; i++) {
    for (var j = 0; j < grid_height; j++) {

        // 3. Determine Draw Coordinates for the current cell (i, j)
        var draw_x = map_offset_x + (i * tile_width);
        var draw_y = map_offset_y + (j * tile_height);

        // 4. Conditional Drawing based on Room Type
        var room_type = map_grid[# i, j];

        // Use a switch statement (or if/else if chain) to handle different room types.
        switch (room_type) {
            case ROOM_NULL:
                // For ROOM_NULL, either do nothing, or draw a specific "empty" tile/color.
                // Example: Draw a dark gray or black rectangle for empty space.
                // draw_set_color(c_dkgray);
                // draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false); // -1 for slight border
                break;

            case ROOM_NORMAL:
                // Draw a "normal room" representation.
                // Example: Draw a light gray rectangle.
                draw_set_color(c_ltgray);
                draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;

            case ROOM_START:
                // Draw a "start room" representation.
                // Example: Draw a green rectangle.
                draw_set_color(c_green);
                draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;

            case ROOM_BOSS:
                // Draw a "boss room" representation.
                // Example: Draw a red rectangle.
                draw_set_color(c_red);
                draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;

            case ROOM_TREASURE:
                // Draw a "treasure room" representation.
                // Example: Draw a yellow rectangle.
                draw_set_color(c_yellow);
                draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;
            
            // Example for an anticipated ROOM_SHOP (if defined)
            /*
            case ROOM_SHOP:
                // Draw a "shop room" representation.
                // Example: Draw a purple rectangle.
                draw_set_color(c_purple);
                draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;
            */

            default:
                // Optional: Handle any unexpected room types.
                // Example: Draw a magenta rectangle to indicate an unknown type.
                // draw_set_color(c_fuchsia);
                // draw_rectangle(draw_x, draw_y, draw_x + tile_width -1, draw_y + tile_height -1, false);
                break;
        }

        // 5. Door Drawing (Conceptual - Advanced)
        //    After drawing the room base, you could add logic here to draw doors
        //    by checking adjacent cells. This is a more complex visual refinement.
        //    For example, to draw a door on the right side of the current room:
        //
        //    if ((i + 1 < grid_width) && (map_grid[# i + 1, j] != ROOM_NULL)) {
        //        // Calculate door position (e.g., middle of the right wall)
        //        var door_draw_x = draw_x + tile_width - (door_thickness / 2);
        //        var door_draw_y = draw_y + (tile_height / 2) - (door_height / 2);
        //        draw_set_color(c_white); // Or a specific door color/sprite
        //        // draw_rectangle(door_draw_x, door_draw_y, door_draw_x + door_thickness, door_draw_y + door_height, false);
        //        // Or draw_sprite(spr_door_horizontal, 0, door_draw_x, door_draw_y);
        //    }
        //    // Similar checks for left (i-1), bottom (j+1), and top (j-1) neighbors.
        //
        //    Note: The actual implementation of door drawing would require defining
        //    door dimensions, sprites, and more precise positioning logic.
        //    For this subtask, outlining the room type drawing is sufficient.

    } // End of inner loop (j)
} // End of outer loop (i)

// Reset draw color to default (good practice)
draw_set_color(c_white);

// --- END DRAW EVENT LOGIC ---
