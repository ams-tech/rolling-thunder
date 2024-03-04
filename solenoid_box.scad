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

module solenoid_enclosure_box() {
    difference() {
        // Draw the enclosure box...
        enclosure_box_solid();
        // Subtract the solenoid, extending the top to ensure it cuts completely through
        translate([
                enclosure_thickness - sol_plung_back_len, 
                enclosure_thickness, 
                enclosure_thickness
        ]) solenoid_model(box_extension=[0,0,enclosure_thickness*2]);
    }
}

//enclosure_box();
//solenoid_model();
