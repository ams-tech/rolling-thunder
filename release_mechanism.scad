module wedge(h,r,a)
{
	th=(a%360)/2;
	difference()
	{
		cylinder(h=h,r=r,center=true);
		if(th<90)
		{
			for(n=[-1,1])rotate(-th*n)translate([(r+0.5)*n,0,0])
				cube(size=[r*2+1,r*2+1,h+1],center=true);
		}
		else
		{
			intersection()
			{
				rotate(-th)translate([(r+0.5),(r+0.5),0])
					cube(size=[r*2+1,r*2+1,h+1],center=true);
				rotate(th)translate([-(r+0.5),(r+0.5),0])
					cube(size=[r*2+1,r*2+1,h+1],center=true);
			}
		}
	}
}

module release_mechanism_cutout(dice_dimensions, plunger_travel, wall_thickness, slider_tolerance=0.05) {
    translate([slider_tolerance / -2, slider_tolerance / -2, slider_tolerance / -2])
    cube([
        dice_dimensions.x + 2 * wall_thickness + plunger_travel + slider_tolerance , 
        dice_dimensions.y + 2 * wall_thickness + slider_tolerance, 
        wall_thickness + slider_tolerance
    ]);
    translate([dice_dimensions.x - slider_tolerance / 2, slider_tolerance / -2, slider_tolerance / -2]) 
        cube([
            2 * plunger_travel + wall_thickness / 2 + slider_tolerance, 
            wall_thickness + slider_tolerance, 
            wall_thickness + dice_dimensions.z + slider_tolerance + plunger_travel
            ]);
    translate([dice_dimensions.x - slider_tolerance / 2, wall_thickness + dice_dimensions.y - slider_tolerance / 2, slider_tolerance / -2]) 
        cube([2 * plunger_travel + wall_thickness / 2 + slider_tolerance, wall_thickness + slider_tolerance, wall_thickness + dice_dimensions.z + slider_tolerance + plunger_travel]);
    translate([dice_dimensions.x  - slider_tolerance / 2, slider_tolerance / -2, dice_dimensions.z / 2 + wall_thickness  - slider_tolerance / 2]) 
    {

   rear_cutout_height =  plunger_travel + slider_tolerance + dice_dimensions.z / 2;
    rear_cutout_len = 2 * plunger_travel + wall_thickness / 2 + slider_tolerance;
    rear_cutout_thickness = dice_dimensions.y + wall_thickness * 2 + slider_tolerance;
    cutout_angle = 90- atan(rear_cutout_len / rear_cutout_height);

    difference(){
    cube([rear_cutout_len, rear_cutout_thickness, rear_cutout_height]);

    translate([0, 0, -slider_tolerance])
    rotate([90, 90 - cutout_angle / 2, 0])
    wedge(
        rear_cutout_thickness * 3, 
        (dice_dimensions.y + wall_thickness * 2 + slider_tolerance) * sqrt(2),
        cutout_angle
    );
    }      
    }
}

module release_mechanism(dice_dimensions, plunger_travel, wall_thickness) {

    travel_support_bottom = [dice_dimensions.x + wall_thickness, wall_thickness, wall_thickness];
    travel_support_back = [plunger_travel, wall_thickness, wall_thickness + dice_dimensions.z + sqrt(2) * plunger_travel / 2];

    cube([plunger_travel, dice_dimensions.y + 2 * wall_thickness, wall_thickness]);

    cube(travel_support_bottom);
    translate([0, wall_thickness + dice_dimensions.y, 0]) cube(travel_support_bottom); 

    translate([dice_dimensions.x, 0, 0]) cube(travel_support_back);
    translate([dice_dimensions.x, wall_thickness + dice_dimensions.y, 0]) cube(travel_support_back);

    translate([dice_dimensions.x, 0, dice_dimensions.z + wall_thickness]) {
            cube([plunger_travel, dice_dimensions.y + wall_thickness * 2, plunger_travel]);
    }
}

//release_mechanism([14.5, 14.5, 14.5], 4.5, 3);

//release_sider([14.5, 14.5, 14.5], 5, 3);