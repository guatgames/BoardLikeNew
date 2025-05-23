/// @description Procedural Map Generation - Alarm 0 Event (Core Room Layout)

// This event is triggered by the Create event (alarm[0] = 1;)
// It uses instance variables from Create: map_grid, grid_width, grid_height, max_rooms, start_x, start_y
// It uses constants from Create: ROOM_START, ROOM_NORMAL, ROOM_NULL

show_debug_message("Alarm 0: Starting map generation...");

// Step 2.1: Place Starting Room
map_grid[# start_x, start_y] = ROOM_START;

var open_list_x = ds_list_create();
var open_list_y = ds_list_create();

ds_list_add(open_list_x, start_x);
ds_list_add(open_list_y, start_y);

current_rooms_count = 1; // Instance variable to track number of rooms placed

// Step 2.2: Iterative Room Placement Loop
var _dx = [0, 0, 1, -1]; // Directions for neighbors (East, West, South, North)
var _dy = [1, -1, 0, 0]; // Corresponding y-changes

while (current_rooms_count < max_rooms && !ds_list_empty(open_list_x)) {
    var _list_size = ds_list_size(open_list_x);
    // Select a room to branch from (from the end of the list - acts like a stack)
    var cx = open_list_x[| _list_size - 1];
    var cy = open_list_y[| _list_size - 1];

    // b. Find valid neighbors
    var valid_neighbors_x = ds_list_create();
    var valid_neighbors_y = ds_list_create();

    for (var i = 0; i < 4; i++) { // Loop 4 times (for each direction)
        var nx = cx + _dx[i];
        var ny = cy + _dy[i];

        // Validation checks for (nx, ny):
        // 1. Bounds Check
        if (nx < 0 || nx >= grid_width || ny < 0 || ny >= grid_height) {
            continue; // Skip to next direction
        }

        // 2. Cell Empty Check
        if (map_grid[# nx, ny] != ROOM_NULL) {
            continue; // Skip to next direction
        }

        // 3. Crowding/Adjacency Check (Isaac rule: new room should only touch one existing room)
        var adjacent_existing_rooms = 0;
        for (var j = 0; j < 4; j++) { // Check all 4 neighbors of the potential new room (nx,ny)
            var nnx = nx + _dx[j]; // neighbor's neighbor x
            var nny = ny + _dy[j]; // neighbor's neighbor y

            // Bounds check for neighbor of neighbor
            if (nnx < 0 || nnx >= grid_width || nny < 0 || nny >= grid_height) {
                continue;
            }
            
            if (map_grid[# nnx, nny] != ROOM_NULL) {
                adjacent_existing_rooms++;
            }
        }

        // If the new room (nx,ny) would be adjacent to more than one existing room, it's invalid.
        // It should only be adjacent to (cx,cy) at this stage.
        if (adjacent_existing_rooms > 1) { 
            continue;
        }
        
        // If all checks pass:
        ds_list_add(valid_neighbors_x, nx);
        ds_list_add(valid_neighbors_y, ny);
    }

    // c. Choose a neighbor and place a room
    var _num_valid_neighbors = ds_list_size(valid_neighbors_x);
    if (_num_valid_neighbors > 0) {
        var _chosen_index = irandom(_num_valid_neighbors - 1); // Pick one randomly

        var chosen_nx = valid_neighbors_x[| _chosen_index];
        var chosen_ny = valid_neighbors_y[| _chosen_index];

        map_grid[# chosen_nx, chosen_ny] = ROOM_NORMAL;
        current_rooms_count++;

        // Add the new room to the open list to branch from it later
        ds_list_add(open_list_x, chosen_nx);
        ds_list_add(open_list_y, chosen_ny);
    } else {
        // No valid neighbors found for (cx, cy)
        // Remove (cx, cy) from open_list to backtrack (it's a dead end for now)
        ds_list_delete(open_list_x, _list_size - 1);
        ds_list_delete(open_list_y, _list_size - 1);
    }

    // d. Clean up temporary neighbor lists for this iteration
    ds_list_destroy(valid_neighbors_x);
    ds_list_destroy(valid_neighbors_y);
}

// Step 2.3: Handle Loop Termination
if (current_rooms_count < max_rooms) {
    show_debug_message("Map generation stopped early: " + string(current_rooms_count) + "/" + string(max_rooms) + " rooms placed.");
} else {
    show_debug_message("Map generation complete: Placed " + string(current_rooms_count) + " rooms.");
}

// --- Boss Room Placement ---
show_debug_message("Attempting to place Boss Room...");
var max_dist = -1;
var boss_x = -1;
var boss_y = -1;

// Iterate through the grid to find the ROOM_NORMAL furthest from the start
for (var i = 0; i < grid_width; i++) {
    for (var j = 0; j < grid_height; j++) {
        if (map_grid[# i, j] == ROOM_NORMAL) {
            var dist = abs(i - start_x) + abs(j - start_y);
            if (dist > max_dist) {
                max_dist = dist;
                boss_x = i;
                boss_y = j;
            }
        }
    }
}

// Place the boss room if a suitable location was found
if (boss_x != -1 && boss_y != -1) {
    map_grid[# boss_x, boss_y] = ROOM_BOSS;
    show_debug_message("Boss room placed at: (" + string(boss_x) + "," + string(boss_y) + ") with distance: " + string(max_dist));
} else {
    show_debug_message("Could not place boss room: No normal rooms found or other issue.");
}
// --- End of Boss Room Placement ---

// --- Treasure Room Placement ---
show_debug_message("Attempting to place Treasure Room(s)...");
var candidate_treasure_rooms_x = ds_list_create();
var candidate_treasure_rooms_y = ds_list_create();

var _dx_treasure = [0, 0, 1, -1]; // Directions for neighbors
var _dy_treasure = [1, -1, 0, 0]; // Corresponding y-changes

// 1. Identify Candidate Treasure Rooms (Dead Ends)
for (var i = 0; i < grid_width; i++) {
    for (var j = 0; j < grid_height; j++) {
        if (map_grid[# i, j] == ROOM_NORMAL) { // Only consider normal rooms
            var neighbor_room_count = 0;
            for (var k = 0; k < 4; k++) { // Check all 4 direct neighbors
                var ni = i + _dx_treasure[k];
                var nj = j + _dy_treasure[k];

                // Check bounds
                if (ni >= 0 && ni < grid_width && nj >= 0 && nj < grid_height) {
                    if (map_grid[# ni, nj] != ROOM_NULL) {
                        neighbor_room_count++;
                    }
                }
            }

            if (neighbor_room_count == 1) { // This is a dead-end room
                ds_list_add(candidate_treasure_rooms_x, i);
                ds_list_add(candidate_treasure_rooms_y, j);
            }
        }
    }
}

// 2. Place Treasure Room(s)
var max_treasure_rooms = 1; // Define how many treasure rooms you want
var placed_treasure_rooms = 0;

if (!ds_list_empty(candidate_treasure_rooms_x)) {
    show_debug_message("Found " + string(ds_list_size(candidate_treasure_rooms_x)) + " candidate(s) for treasure rooms.");
    for (var k = 0; k < max_treasure_rooms && !ds_list_empty(candidate_treasure_rooms_x); k++) {
        var _candidate_list_size = ds_list_size(candidate_treasure_rooms_x);
        var _chosen_index = irandom(_candidate_list_size - 1);

        var tx = candidate_treasure_rooms_x[| _chosen_index];
        var ty = candidate_treasure_rooms_y[| _chosen_index];

        // Ensure we don't convert the Boss room if it happened to be a dead-end
        if (map_grid[# tx, ty] == ROOM_NORMAL) { 
            map_grid[# tx, ty] = ROOM_TREASURE;
            placed_treasure_rooms++;
            show_debug_message("Treasure room placed at: (" + string(tx) + "," + string(ty) + ")");
        } else {
             show_debug_message("Skipped placing treasure at (" + string(tx) + "," + string(ty) + ") as it was not ROOM_NORMAL (e.g. already Boss Room).");
             // If we skipped, we might want to try picking another candidate if available
             // Decrement k so the loop tries one more time if candidates are left and k < max_treasure_rooms
             if (k < max_treasure_rooms) {
                 k--; // This allows another attempt if we skipped one
             }
        }
        
        ds_list_delete(candidate_treasure_rooms_x, _chosen_index);
        ds_list_delete(candidate_treasure_rooms_y, _chosen_index);
    }
    if (placed_treasure_rooms == 0 && ds_list_size(candidate_treasure_rooms_x) == 0 && max_treasure_rooms > 0){
        show_debug_message("Could not place treasure room: All ("+string(ds_list_size(candidate_treasure_rooms_x))+") candidates were unsuitable (e.g. already Boss Room).");
    } else if (placed_treasure_rooms < max_treasure_rooms  && max_treasure_rooms > 0) {
        show_debug_message("Placed " + string(placed_treasure_rooms) + "/" + string(max_treasure_rooms) + " treasure rooms. Not enough suitable candidates found for all.");
    }
} else {
    show_debug_message("Could not place treasure room: No suitable dead-end rooms found.");
}

// 3. Clean up
ds_list_destroy(candidate_treasure_rooms_x);
ds_list_destroy(candidate_treasure_rooms_y);
show_debug_message("Treasure Room placement logic finished.");
// --- End of Treasure Room Placement ---

// --- BFS Pathfinding Check for Boss Room Accessibility ---
show_debug_message("Performing BFS to check Boss Room accessibility...");

var bfs_queue = ds_queue_create();
var visited_grid = ds_grid_create(grid_width, grid_height);
ds_grid_clear(visited_grid, false); // Initialize all cells to not visited

// Enqueue the starting room's coordinates
ds_queue_enqueue(bfs_queue, start_x);
ds_queue_enqueue(bfs_queue, start_y);
visited_grid[# start_x, start_y] = true;

var boss_room_found = false;
var _dx_bfs = [0, 0, 1, -1]; // Directions for neighbors
var _dy_bfs = [1, -1, 0, 0]; // Corresponding y-changes

while (!ds_queue_empty(bfs_queue)) {
    var cx_bfs = ds_queue_dequeue(bfs_queue); // Use distinct names to avoid conflict
    var cy_bfs = ds_queue_dequeue(bfs_queue); // Use distinct names to avoid conflict

    // Check if the current room is the Boss Room
    if (map_grid[# cx_bfs, cy_bfs] == ROOM_BOSS) {
        boss_room_found = true;
        break; // Boss room found, path exists
    }

    // Explore neighbors
    for (var i = 0; i < 4; i++) {
        var nx_bfs = cx_bfs + _dx_bfs[i];
        var ny_bfs = cy_bfs + _dy_bfs[i];

        // 1. Bounds Check
        if (nx_bfs < 0 || nx_bfs >= grid_width || ny_bfs < 0 || ny_bfs >= grid_height) {
            continue;
        }

        // 2. Valid Room Check (can path through any non-null room)
        if (map_grid[# nx_bfs, ny_bfs] == ROOM_NULL) {
            continue;
        }

        // 3. Visited Check
        if (visited_grid[# nx_bfs, ny_bfs] == false) {
            visited_grid[# nx_bfs, ny_bfs] = true;
            ds_queue_enqueue(bfs_queue, nx_bfs);
            ds_queue_enqueue(bfs_queue, ny_bfs);
        }
    }
}

// Validation Result & Cleanup
ds_queue_destroy(bfs_queue);
ds_grid_destroy(visited_grid);

if (!boss_room_found) {
    show_debug_message("VALIDATION FAILED: Boss room is NOT accessible from the start room!");
    // Optional: self.generation_failed = true; 
} else {
    show_debug_message("VALIDATION SUCCESS: Boss room IS accessible from the start room.");
}
// --- End of BFS Pathfinding Check ---

// Clean up main open_lists
ds_list_destroy(open_list_x);
ds_list_destroy(open_list_y);

show_debug_message("Alarm 0: Map generation finished.");

// Optional: For visualization or further steps, you might call another script or set another alarm here.
// For example: place_special_rooms(); or alarm[1] = 1; to trigger next phase.
