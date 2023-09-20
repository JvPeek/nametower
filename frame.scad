include <tools.scad>
module frame()
{

    linear_extrude(wall) ring(gap = 0, shell = ledDistance);
    translate([ 0, 0, wall ]) difference()
    {
        linear_extrude(height) union()
        {
            // OUTER POSTS
            ring(gap = 10, shell = 7, onlyPosts = true);

            // LIPS
            ring(gap = 16, shell = 2, onlyPosts = true, sideSize = sideSize - nametagDepth * 2 - .5);

            // DIVIDERS
            ring(gap = wall, shell = ledDistance - nametagDepth - .5, onlyPosts = true,
                 sideSize = sideSize - nametagDepth * 2 - .5);

            // BACKWALLS
            ring(gap = 0, shell = wall, sideSize = sideSize - ledDistance * 2 + wall * 2);
        }
        translate([ 0, 0, height / 2 - wall - stripSize / 2 ]) linear_extrude(stripSize) // LED Strip Cutout
            ring(gap = 0, shell = 6, sideSize = sideSize - ledDistance * 2 + wall * 2 + 6 * 2 - .5);

        translate([ 0, 0, height / 2 - clipHeight / 2 ]) linear_extrude(height) // connector spot
            ring(gap = 0, sideSize = sideSize - nametagDepth * 2 - wall * 1.501, shell = 3);

        for (a = [0:360 / sides:360])
        {
            $fn = 10;
            rotate([ 0, 0, a + rotationOffset ]) union()
            {
                rotate([ 90, 0, 0 ]) translate([ 50, 5 - wall, 0 ]) cylinder(sideSize, 1.5);
                rotate([ 90, 0, 0 ]) translate([ -50, 5 - wall, 0 ]) cylinder(sideSize, 1.5);

                rotate([ 90, 0, 0 ]) translate([ 50, height - 5, 0 ]) cylinder(sideSize, 1.5);
                rotate([ 90, 0, 0 ]) translate([ -50, height - 5, 0 ]) cylinder(sideSize, 1.5);
            }
        }
        cutoutSize=[20,6.5];
        translate([0,0,wall+height*.75])
        rotate([ 0, 0, 45 ])

        rotate([0,90,0]) hull()
        {
            $fn=50;
            translate([ 0, -(cutoutSize[0]/2-cutoutSize[1]/2), 0 ]) cylinder(h = 1000, r = cutoutSize[1] / 2);
            translate([ 0, (cutoutSize[0]/2-cutoutSize[1]/2), 0 ]) cylinder(h = 1000, r = cutoutSize[1] / 2);
        }
    }
}

module clips()
{

    translate([ 0, 0, height / 2 - clipHeight / 2 ]) linear_extrude(height / 2 + clipHeight / 2) // connector base
        ring(gap = 19, sideSize = sideSize - nametagDepth * 2 - wall * 1.501 - .25, shell = 2.5, onlyPosts = true);

    translate([ 0, 0, height / 2 - clipHeight / 2 ]) linear_extrude(height / 2) // connector spot
        difference()
    {
        ring(gap = 19, sideSize = sideSize - nametagDepth * 2 - wall * 1.501 + 9, shell = 6, onlyPosts = true);
        ring(gap = 17, sideSize = sideSize - nametagDepth * 2 - wall * 1.5 + 9, shell = 6, onlyPosts = true);
    }
}