include <tower_base.scad>
include <release_mechanism.scad>

dice_dimensions = [15, 15, 15];
plunger_travel = 4.5;
wall_thickness = 3;

 
translate([dice_dimensions.x * 2, dice_dimensions.y * 2, 30])
 rotate([0, 180, 0])
 tower(dice_dimensions, plunger_travel, wall_thickness, 30);

translate([dice_dimensions.x * 2, 0, 0])
tower_base(dice_dimensions, plunger_travel, wall_thickness);

release_mechanism(dice_dimensions, plunger_travel, wall_thickness);

//translate([dice_dimensions.x * 2, 0, 0])
//release_mechanism_cutout(dice_dimensions, plunger_travel, wall_thickness);

