include <tools.scad>

module skeleton(topNotches = true)
{
    notch = [ 10, wall / 2 ];
    difference()
    {
        union()
        {
            cylinder(h = height + wall, r = outerTube / 2 + wall * 2);

            linear_extrude(height + wall) // outer wall base
                ring(gap = 20, shell = wall, sideSize = sideSize - ledDistance * 2, onlyPosts = true);
            if (topNotches)
            {
                translate([ 0, 0, height + wall ]) linear_extrude(notch[1]) // upper notch
                    ring(gap = notch[0] - .5, shell = wall, sideSize = sideSize - ledDistance * 2, onlyPosts = true);
            }

            linear_extrude(wall) // lower connector arm
                ring(gap = 10, shell = sideSize, sideSize = sideSize - ledDistance * 2, onlyPosts = true);

            linear_extrude(wall + height) // connector arm wall
                ring(gap = 1, shell = sideSize, sideSize = sideSize - ledDistance * 2, onlyPosts = true);

            linear_extrude(wall + height) // connector arm braces
                for (a = [0:sideSize / 8:sideSize - ledDistance * 2])
            {
                ring(gap = 10, shell = wall, sideSize = a, onlyPosts = true);
            }
            translate([ 0, 0, height ]) linear_extrude(wall) // upper connector arm
                ring(gap = 10, shell = sideSize, sideSize = sideSize - ledDistance * 2, onlyPosts = true);
        }
        spreadEverywhere() for (a = [sideSize / 32:sideSize / 8:sideSize - ledDistance * 2 - 20])
        {

            translate([ a / 2, wall / 2 + 1.5, 0 ]) cylinder(h = height + wall + overlap * 2, r = 3 / 2, $fn = 10);
            translate([ a / 2, -wall / 2 - 1.5, 0 ]) cylinder(h = height + wall + overlap * 2, r = 3 / 2, $fn = 10);
        }
        translate([ 0, 0, -overlap ]) linear_extrude(notch[1] + overlap) // lower notch
            ring(gap = notch[0], shell = wall + overlap * 2, sideSize = sideSize - ledDistance * 2 + overlap,
                 onlyPosts = true);
        translate([ 0, 0, wall ]) for (a = [0:360 / sides:360])
        {
            $fn = 10;
            rotate([ 0, 0, a + rotationOffset ]) union()
            {
                holeDistance = 93;
                rotate([ 90, 0, 0 ]) translate([ 50, 5 - wall, holeDistance ]) cylinder(sideSize, 1.5);
                rotate([ 90, 0, 0 ]) translate([ -50, 5 - wall, holeDistance ]) cylinder(sideSize, 1.5);

                rotate([ 90, 0, 0 ]) translate([ 50, height - 5, holeDistance ]) cylinder(sideSize, 1.5);
                rotate([ 90, 0, 0 ]) translate([ -50, height - 5, holeDistance ]) cylinder(sideSize, 1.5);
            }
        }
        translate([ 0, 0, -overlap ]) cylinder(h = height + wall + overlap * 2, r = outerTube / 2, $fn = 100);
    }
}
module baseSkeleton()
{
    intersection()
    {
        skeleton();
        translate([0,0,(height+wall)/1.5])
        difference()
        {
            cylinder(h = (height + wall)/2, r = innerTube + 13, $fn = sides);
            translate([0,0,-overlap])
            cylinder(h = (height + wall)/2+overlap*2 , r = outerTube/2+wall*2, $fn = 100);
        }
    }
    difference()
    {
        union()
        {
            cylinder(h = taperedBearingHeight, r = taperedBearingDia / 2 + wall);
            translate([ 0, 0, taperedBearingHeight ])
                cylinder(h = height + wall - taperedBearingHeight, r1 = taperedBearingDia / 2 + wall, r2 = outerTube / 2 + wall * 2);
        }
        translate([ 0, 0, -overlap ]) cylinder(h = taperedBearingHeight + overlap * 2, r = taperedBearingDia / 2);
        translate([ 0, 0, taperedBearingHeight ])
            cylinder(h = height + wall - taperedBearingHeight + overlap, r = outerTube / 2);
    }

    // difference()
    // {
    //     cylinder(h = height + wall, r = outerTube / 2 + wall * 2);
    //     translate([0,0,-overlap])
    //     cylinder(h = height+overlap*2 + wall, r = outerTube / 2);
    // }
}
module topSkeleton()
{
    skeleton(topNotches = false);
}
module regularSkeleton()
{
    difference()
    {
        skeleton();
        difference()
        {
            cylinder(h = height + wall + overlap * 2, r = sideSize / 2 - 55, $fn = sides);
            cylinder(h = height + wall + overlap * 2, r = innerTube + 13, $fn = sides);
        }
    }
}