// All units are in mm

// Solenoid Box Dimensions
sol_box = [20.5, 11, 12];
// Solenoid box tolerances
sol_box_tol = [2, 2, 0.2];
// Clearance is the box size + tolerance
sol_box_clearance = sol_box + sol_box_tol;

// Mounting holes
mount_d = 1;
mount_len = 2;
mount_spread_y = 6.05;
mount_spread_x = 10.05;
mount_start_x = 5.05;

//Sol rear plunger 
sol_plung_back_len = 5;
sol_plung_back_d = 3.5;

//Sol plunger
sol_plung_len = 8;
sol_plung_d = 7;

wire_thickness = 2;
wire_offset = 1;
wire_length = 10;
wire_height = sol_box_clearance.z / 2;


module solenoid_model(box_extension=[0,0,0]) {
    $fn = 64;
    // Draw the rear portion of the solenoid plunger
    translate([0,sol_box_clearance.y / 2, sol_box_clearance.z / 2]) {
        rotate([0,90,0]){
            cylinder(h = sol_plung_back_len + 1, r = sol_plung_back_d/2);
        }
    }

    // Draw the cube portion of the solenoid
    translate([sol_plung_back_len, 0, 0]) {
        difference() {
            // Box portion
            cube(sol_box_clearance + box_extension);
            // mounting holes
            translate([
                mount_start_x + sol_box_tol.x / 2, 
                sol_box_clearance.y / 2 - mount_spread_y / 2, 
                -1
            ]) cylinder(r = mount_d / 2, h = mount_len + 1);
            translate([
                mount_start_x + sol_box_tol.x / 2 + mount_spread_x, 
                sol_box_clearance.y / 2 + mount_spread_y / 2, 
                -1
            ]) cylinder(r = mount_d / 2, h = mount_len + 1);
        }
        // Draw the wire cutout portion of the box
        translate([wire_offset, sol_box_clearance.y - 1, 0]) cube([wire_thickness, wire_length + 1, sol_box_clearance.z + 5]);
    }

    // Draw room for the plunger portion of the solenoid
    translate([sol_plung_back_len + sol_box_clearance.x - 1, wall_thickness * .5, wall_thickness * .5]) {
        cube([sol_plung_len + 1, sol_box_clearance.y - wall_thickness, sol_box_clearance.z + 5]);
    }

    translate([0, wall_thickness * .5, wall_thickness * .5]) {
        cube([sol_plung_len + 1, sol_box_clearance.y - wall_thickness, sol_box_clearance.z + 5]);
    }
}

