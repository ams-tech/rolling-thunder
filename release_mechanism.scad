module release_mechanism(dice_dimensions, plunger_travel, wall_thickness) {

    travel_support_bottom = [dice_dimensions.x + wall_thickness, wall_thickness, wall_thickness];
    travel_support_back = [plunger_travel, wall_thickness, wall_thickness + dice_dimensions.z + sqrt(2) * plunger_travel / 2];

    cube([plunger_travel, dice_dimensions.y + 2 * wall_thickness, wall_thickness]);

    cube(travel_support_bottom);
    translate([0, wall_thickness + dice_dimensions.y, 0]) cube(travel_support_bottom); 

    translate([dice_dimensions.x, 0, 0]) cube(travel_support_back);
    translate([dice_dimensions.x, wall_thickness + dice_dimensions.y, 0]) cube(travel_support_back);

    translate([dice_dimensions.x, 0, dice_dimensions.z + wall_thickness]) {
        intersection () {
            cube([plunger_travel, dice_dimensions.y + wall_thickness * 2, plunger_travel]);
            rotate([0, 45, 0]) {
                cube([plunger_travel, dice_dimensions.y + wall_thickness * 2, plunger_travel]);
            }
        }
    }
}

module release_sider(dice_dimensions, plunger_travel, wall_thickness) {
    $fn = 64;
    // Draw the floor
    difference() {
        difference() {
            {translate([wall_thickness, wall_thickness, 0]) {
                linear_extrude(wall_thickness * 2){
                    minkowski(){
                        square([
                            dice_dimensions.x + 2 * plunger_travel, 
                            dice_dimensions.y + 2 * wall_thickness,
                        ]);
                        circle(wall_thickness);
                    }
                }
            }

            translate([wall_thickness, wall_thickness, wall_thickness])
                cube([dice_dimensions.x + 2 * plunger_travel, dice_dimensions.y + 2 * wall_thickness, wall_thickness * 2]);}
        }

        translate([wall_thickness, 2 * wall_thickness, -1 * wall_thickness])
            cube([dice_dimensions.x + 2 * plunger_travel + wall_thickness * 2, dice_dimensions.y, 4 * wall_thickness]);
    }
}

dice_dimensions = 14.5;
plunger_travel = 4.5;
wall_thickness = 3;

//release_mechanism([14.5, 14.5, 14.5], 4.5, 3);

release_sider([14.5, 14.5, 14.5], 5, 3);