include <wedge.scad>

solid_passthrough = 0.1;
slider_tolerance = 0.5;

dice_side = 14.5;
dice_dimensions = [dice_side, dice_side, dice_side];
plunger_travel = 4.5;
wall_thickness = 3;

spring_od = 7;
spring_id = 4.5;
spring_uncompressed_len = 13; //15mm spring 

// Release Mechanism

$fn = 64;

// Spring/solenoid contact
spring_od_tolerance = 1;
contact_height = spring_od + spring_od_tolerance + wall_thickness;

dice_side_tolerance = 1;
contact_length = dice_side + dice_side_tolerance;

plunger_travel_tolerance = .5;
contact_width = plunger_travel + wall_thickness; 

// spring mount variables
spring_mount_tolerance = 1;
spring_mount_diameter = spring_id - spring_mount_tolerance;

spring_mount_length =solid_passthrough + (spring_uncompressed_len - plunger_travel - spring_mount_tolerance) / 2;

// tower base
base_height = contact_height + wall_thickness + slider_tolerance;
base_width = contact_width + spring_uncompressed_len + wall_thickness;
base_length = contact_length + slider_tolerance;

dice_strike_factor = .75;
dice_strike_height = dice_strike_factor * dice_side + wall_thickness;
dice_striker_full_height = dice_side + wall_thickness - slider_tolerance;

mechanism_height = dice_striker_full_height + slider_tolerance;
tower_height = mechanism_height + 30;

module spring_solenoid_contact(){

    cube([contact_length, contact_width, contact_height]);

    // Create the spring mount point

    translate([ contact_length / 2, contact_width- solid_passthrough, (contact_height + wall_thickness) / 2])
    rotate([-90, 0, 0])
    cylinder(d=spring_mount_diameter, h=spring_mount_length);

difference() {
    // Add the dice contact portion of the contact
    translate([wall_thickness, 0, contact_height - solid_passthrough])
        cube([base_length - 2 * wall_thickness, contact_width, dice_striker_full_height]);

    top_angle = atan((dice_striker_full_height - dice_strike_height + contact_height) / contact_width);
    // Cut out the top angle

    translate([contact_length / 2,contact_width + solid_passthrough, contact_height + dice_strike_height - wall_thickness])
    rotate([90 + top_angle / 2, 0, 0])
    rotate([0,90,0])
    wedge(contact_length, contact_height + dice_striker_full_height, top_angle);
}
}

module tower_mount_points(tolerance=0){
    translate([-wall_thickness / 4, wall_thickness,0])
        cylinder(r=wall_thickness / 6 - tolerance, h=wall_thickness / 2);
    translate([wall_thickness / 4 + base_length, wall_thickness,0])
        cylinder(r=wall_thickness / 6 - tolerance, h=wall_thickness / 2);
    translate([wall_thickness / 4 + base_length, -wall_thickness+ base_width,0])
        cylinder(r=wall_thickness / 6 - tolerance, h=wall_thickness / 2);
    translate([-wall_thickness / 4 , -wall_thickness + base_width,0])
        cylinder( r=wall_thickness / 6 - tolerance, h=wall_thickness / 2);
}

//spring_solenoid_contct();

module tower_base(){    


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
        translate([wall_thickness, -2 * wall_thickness, wall_thickness])
            cube([base_length - 2 * wall_thickness, contact_width, base_height]);
    }

    translate([ contact_length / 2, base_width - spring_mount_length, (contact_height + wall_thickness) / 2 + wall_thickness])    
    rotate([-90, 0, 0])
    cylinder(d=spring_mount_diameter, h=spring_mount_length);

    translate([0, 0, base_height - solid_passthrough])
    tower_mount_points(tolerance=0.1);
}

module tower(){

    difference(){
         // Make the outer portion of the base box
        linear_extrude(tower_height) {
            minkowski() {
                square([base_length, base_width]);
                circle(d=wall_thickness);
            }
        }

        // Cut out the slider portion of the box
        translate([wall_thickness - 2 * slider_tolerance, 0, -solid_passthrough])
            cube([base_length - 2 * wall_thickness + 4 * slider_tolerance, contact_width + plunger_travel, mechanism_height + solid_passthrough * 2]);

        // Cut out the dice tower portion
        translate([(base_length - dice_side) / 2, contact_width + plunger_travel_tolerance, wall_thickness])
            cube([dice_side, dice_side, tower_height]);

        // Cut out the exit portion
        translate([-wall_thickness, contact_width + plunger_travel_tolerance + dice_side * .75, wall_thickness])
            cube([base_length + 2 * wall_thickness, base_width + 2 * wall_thickness + solid_passthrough, mechanism_height + dice_side_tolerance]);

        // Cut out the mounting points
        translate([0, 0, -solid_passthrough])
            tower_mount_points();
        
    }
}

tower_base();

translate([25, 25, 0])
rotate([90, 0, 0])
spring_solenoid_contact();

translate([-25, base_width, tower_height])
rotate([180,0,0])
tower();