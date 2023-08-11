module roundedRect(size, radius, center=false)
{
    x = size[0];
    y = size[1];
    z = size[2];
	
		dx = center ? x/2 : 0;
		dy = center ? y/2 : 0;
		dz = center ? z/2 : 0;
	
	translate([dx, dy, -dz])
    linear_extrude(height=z)
	hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([radius, radius, 0])
        circle(r=radius);
		
        translate([x - radius, radius, 0])
        circle(r=radius);
		
        translate([radius, y - radius, 0])
        circle(r=radius);
		
        translate([x - radius, y - radius, 0])
        circle(r=radius);
    }
}