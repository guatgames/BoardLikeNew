/// @description Procedural Map Generation - Create Event

// Define Room Type Constants
#macro ROOM_NULL 0
#macro ROOM_NORMAL 1
#macro ROOM_START 2
#macro ROOM_BOSS 3
#macro ROOM_TREASURE 4
#macro ROOM_SHOP 5
// Add any other room types you anticipate here, e.g.:
// #macro ROOM_CHALLENGE 6
// #macro ROOM_SECRET 7

// Define Map Parameters
grid_width = 20;
grid_height = 20;
max_rooms = 15;

// Calculate starting position (typically center of the grid)
start_x = floor(grid_width / 2);
start_y = floor(grid_height / 2);

// Create and Initialize map_grid
map_grid = ds_grid_create(grid_width, grid_height);
ds_grid_clear(map_grid, ROOM_NULL); // Fill the grid with ROOM_NULL

// Seed Random Number Generator (ensures different layouts each run)
randomize();

// --- Optional: Placeholder for future variables ---
// For example, you might want to store the list of actual room instances
// room_instances = ds_list_create();

// --- Debugging: Output that the creation is done (optional) ---
// show_debug_message("Obj_procedural Create Event: Initialization complete.");
// show_debug_message("Grid dimensions: " + string(grid_width) + "x" + string(grid_height));
// show_debug_message("Max rooms: " + string(max_rooms));
// show_debug_message("Start position: (" + string(start_x) + "," + string(start_y) + ")");
// show_debug_message("map_grid initialized with ID: " + string(map_grid));

// Trigger Alarm 0 to start map generation
alarm[0] = 1;