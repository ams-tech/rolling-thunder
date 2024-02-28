module tower_base_flat(dice_dimensions, plunger_travel, wall_thickness) {
    translate([wall_thickness, wall_thickness, 0]) {
        minkowski(){
            square([
                dice_dimensions.x + 2 * plunger_travel, 
                dice_dimensions.y + 2 * wall_thickness,
            ]);
            circle(wall_thickness);
        }
    }
}

module tower_mount_points(dice_dimensions, plunger_travel, wall_thickness, mount_tolerance=0){
    translate([wall_thickness * 2, wall_thickness / 2, 0])
        cylinder(r=wall_thickness / 3.14 + mount_tolerance, h=wall_thickness*3);
    translate([ dice_dimensions.x + 2 * plunger_travel, wall_thickness / 2, 0])
        cylinder(r=wall_thickness / 3.14 + mount_tolerance, h=wall_thickness*3);
    translate([ dice_dimensions.x + 2 * plunger_travel, dice_dimensions.y + 3.5 * wall_thickness, 0])
        cylinder(r=wall_thickness / 3.14 + mount_tolerance, h=wall_thickness*3);
    translate([wall_thickness * 2, dice_dimensions.y + 3.5 * wall_thickness, 0])
        cylinder(r=wall_thickness / 3.14 + mount_tolerance, h=wall_thickness*3);
    
}

module tower_base(dice_dimensions, plunger_travel, wall_thickness) {
    $fn = 64;
    tower_mount_points(dice_dimensions, plunger_travel, wall_thickness);
    difference() {
        linear_extrude(wall_thickness * 2)
            tower_base_flat(dice_dimensions, plunger_travel, wall_thickness);

        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([dice_dimensions.x + 2 * plunger_travel, dice_dimensions.y + 2 * wall_thickness, wall_thickness * 2]);

        translate([wall_thickness, 2 * wall_thickness, -1 * wall_thickness])
            cube([dice_dimensions.x + 2 * plunger_travel + wall_thickness * 2, dice_dimensions.y, 4 * wall_thickness]);
    }
}

module tower(dice_dimensions, plunger_travel, wall_thickness, tower_height) {
    $fn = 64;
    difference(){
        linear_extrude(tower_height)
            tower_base_flat(dice_dimensions, plunger_travel, wall_thickness);

        translate([0, 0, -1 * wall_thickness / 2])
            tower_mount_points(dice_dimensions, plunger_travel, wall_thickness, mount_tolerance=0.1);
        
        translate([wall_thickness * 2, wall_thickness * 2, -1])
            cube([dice_dimensions.x, dice_dimensions.y, tower_height * 2]);
    }
}

