/// @function generate_map_layout()
/// @description Generates the core layout of rooms in the map_grid.
/// Uses instance variables: map_grid, grid_width, grid_height, max_rooms, start_x, start_y
/// Uses constants: ROOM_START, ROOM_NORMAL, ROOM_NULL

function generate_map_layout() {
    // Step 2.1: Place Starting Room
    map_grid[# start_x, start_y] = ROOM_START;

    var open_list_x = ds_list_create();
    var open_list_y = ds_list_create();

    ds_list_add(open_list_x, start_x);
    ds_list_add(open_list_y, start_y);

    current_rooms_count = 1; // This should be an instance variable if other scripts need it.
                             // If only used here, it can be a local 'var'.
                             // For compatibility with the problem description, assume it's an instance var.

    // Step 2.2: Iterative Room Placement Loop
    var _dx = [0, 0, 1, -1]; // Directions for neighbors (East, West, South, North)
    var _dy = [1, -1, 0, 0]; // Corresponding y-changes

    while (current_rooms_count < max_rooms && !ds_list_empty(open_list_x)) {
        var _list_size = ds_list_size(open_list_x);
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

            // 3. Crowding/Adjacency Check (Isaac rule)
            var adjacent_rooms_count = 0;
            for (var j = 0; j < 4; j++) {
                var nnx = nx + _dx[j]; // Neighbor of neighbor x
                var nny = ny + _dy[j]; // Neighbor of neighbor y

                // Check bounds for neighbor of neighbor
                if (nnx >= 0 && nnx < grid_width && nny >= 0 && nny < grid_height) {
                    if (map_grid[# nnx, nny] != ROOM_NULL) {
                        adjacent_rooms_count++;
                    }
                }
            }

            if (adjacent_rooms_count == 1) { // Should only be adjacent to (cx,cy)
                ds_list_add(valid_neighbors_x, nx);
                ds_list_add(valid_neighbors_y, ny);
            }
        }

        // c. Choose a neighbor and place a room
        if (!ds_list_empty(valid_neighbors_x)) {
            var _num_valid_neighbors = ds_list_size(valid_neighbors_x);
            var _chosen_index = irandom(_num_valid_neighbors - 1); // Pick one randomly

            var chosen_nx = valid_neighbors_x[| _chosen_index];
            var chosen_ny = valid_neighbors_y[| _chosen_index];

            map_grid[# chosen_nx, chosen_ny] = ROOM_NORMAL;
            current_rooms_count++;

            ds_list_add(open_list_x, chosen_nx);
            ds_list_add(open_list_y, chosen_ny);
        } else {
            // No valid neighbors found for (cx, cy)
            // Remove (cx, cy) from open_list to backtrack
            ds_list_delete(open_list_x, _list_size - 1);
            ds_list_delete(open_list_y, _list_size - 1);
        }

        // Clean up temporary neighbor lists for this iteration
        ds_list_destroy(valid_neighbors_x);
        ds_list_destroy(valid_neighbors_y);
    }

    // Step 2.3: Handle Loop Termination
    if (current_rooms_count < max_rooms) {
        show_debug_message("Map generation ended early: Placed " + string(current_rooms_count) + "/" + string(max_rooms) + " rooms.");
    } else {
        show_debug_message("Map generation complete: Placed " + string(current_rooms_count) + " rooms.");
    }
    
    // Clean up main open_lists
    ds_list_destroy(open_list_x);
    ds_list_destroy(open_list_y);
    
    show_debug_message("generate_map_layout() finished.");
}
