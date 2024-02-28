include <tower_base.scad>
include <release_mechanism.scad>

dice_dimensions = [14.5, 14.5, 14.5];
plunger_travel = 4.5;
wall_thickness = 3;

 
translate([0, dice_dimensions.y * 2, 30])
 rotate([0, 180, 0])
 tower(dice_dimensions, plunger_travel, wall_thickness, 30);

translate([dice_dimensions.x * 2, 0, 0])
tower_base(dice_dimensions, plunger_travel, wall_thickness);

//translate([wall_thickness, wall_thickness, wall_thickness])
release_mechanism(dice_dimensions, plunger_travel, wall_thickness);