include <solenoid.scad>

// All units are in mm
printer_tolerance = 0.2;

enclosure_thickness = 2;

module enclosure_box_solid(){
    $fn=64;
    // Enclosure box
    // Nudge the box over to account for minkowski thickness
    translate([enclosure_thickness, enclosure_thickness, 0]){
        linear_extrude(sol_box_clearance.z + enclosure_thickness){
            minkowski(){
                square([sol_box_clearance.x, sol_box_clearance.y]);
                circle(enclosure_thickness);
            }
        }
    }
}

module enclosure_box() {
    difference() {
        // Draw the enclosure box...
        enclosure_box_solid();
        // Subtract the solenoid, extending the top to ensure it cuts completely through
        translate([
                enclosure_thickness - sol_plung_back_len, 
                enclosure_thickness, 
                enclosure_thickness
        ]) solenoid_model(box_extension=[0,0,enclosure_thickness*2]);
        // Subtract the top of the plunger, leaving room to install the solenoid
        translate([
            sol_box_clearance.x + enclosure_thickness * 1.5,
            sol_box_clearance.y / 2 + enclosure_thickness,
            sol_box_clearance.z + enclosure_thickness
        ]) cube([enclosure_thickness * 2, sol_plung_d, sol_box_clearance.z], center=true);
    }
}

enclosure_box();

