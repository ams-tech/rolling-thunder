include <wedge.scad>

solid_passthrough = 0.1;
slider_tolerance = 0.5;

dice_side = 14.5;
dice_dimensions = [dice_side, dice_side, dice_side];
plunger_travel = 4.5;
wall_thickness = 3;

spring_od = 7;
spring_uncompressed_len = 13; //15mm spring 

// Release Mechanism

$fn = 64;

// Spring/solenoid contact
spring_od_tolerance = 1;
contact_height = spring_od + spring_od_tolerance + wall_thickness;

dice_side_tolerance = 1;
contact_length = dice_side + dice_side_tolerance;

plunger_travel_tolerance = 0;
contact_width = plunger_travel + wall_thickness + plunger_travel_tolerance; 

// spring mount variables
spring_mount_tolerance = 1;
spring_mount_diameter = spring_od - spring_mount_tolerance;

spring_mount_length =solid_passthrough + (spring_uncompressed_len - plunger_travel - spring_mount_tolerance) / 2;


module spring_solenoid_contct(){

    cube([contact_length, contact_width, contact_height]);

    // Create the spring mount point

    translate([ contact_length / 2, contact_width- solid_passthrough, (contact_height + wall_thickness) / 2])
    rotate([-90, 0, 0])
    cylinder(d=spring_mount_diameter, h=spring_mount_length);
}

//spring_solenoid_contct();

module tower_base(){    
    // tower base
    base_height = contact_height + wall_thickness + slider_tolerance;

    base_width = contact_width + spring_uncompressed_len + wall_thickness;

    base_length = contact_length + slider_tolerance;

    difference() {

        // Make the outer portion of the base box
        linear_extrude(base_height) {
            minkowski() {
                square([base_length, base_width]);
                circle(d=wall_thickness);
            }
        }

        // Cut out the slider portion of the box
        translate([0, 0, wall_thickness])
            cube([base_length, contact_width + plunger_travel, base_height]);

        // Cut out the spring portion of the box
        translate([0, 0, 2 * wall_thickness])
            cube([base_length, base_width, base_height]);

        // Cut out the front portion of the box
        translate([wall_thickness, -2 * wall_thickness, 2 * wall_thickness])
            cube([base_length - 2 * wall_thickness, base_width, base_height]);
    }

    translate([ contact_length / 2, base_width - spring_mount_length, (contact_height + wall_thickness) / 2 + wall_thickness])    
    rotate([-90, 0, 0])
    cylinder(d=spring_mount_diameter, h=spring_mount_length);

}

tower_base();
translate([25, 0, 0])
rotate([90, 0, 0])
spring_solenoid_contct();