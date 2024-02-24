// All units are in mm

// Solenoid Box Dimensions
sol_box = [20.5, 12, 11];
// Solenoid box tolerances
sol_box_tol = [0.2, 0.2, 0.2];
// Clearance is the box size + tolerance
sol_box_clearance = sol_box + sol_box_tol;

//Sol rear plunger 
sol_plung_back_len = 5;
sol_plung_back_d = 3.5;

//Sol plunger
sol_plung_len = 8;
sol_plung_d = 7;


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
        cube(sol_box + box_extension);
    }

    // Draw the plunger portion of the solenoid
    translate([sol_plung_back_len + sol_box.x - 1, sol_box_clearance.y / 2, sol_box_clearance.z / 2]) {
        rotate([0,90,0]){
            cylinder(h = sol_plung_len + 1, r = sol_plung_d/2);
        }
    }
}

