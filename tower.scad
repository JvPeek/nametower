module tower()
{
    $fn = 100;

    translate([ 0, 0, taperedBearingInnerHeight + wall +10])
    towerbase();

}

module towerbase() {

    difference() {
        union() {
            cylinder(wall * 2 + 10, r = taperedBearingInnerDia / 2 + wall);
            cylinder(wall * 2 + 10, r = taperedBearingInnerDia / 2 + wall);
        }

        translate([0,0,-overlap])
        cylinder(10+overlap, r = taperedBearingInnerDia / 2+.1);
        translate([0,0,-overlap*2])
        cylinder(taperedBearingInnerHeight+wall+overlap*4, r = taperedBearingInnerDia / 2 - wall*3);
        
        for (a = [0:360 / 6:360])
        {
            rotate([ 0, 0, a ])
            translate([ 0, taperedBearingInnerDia / 2 - wall * 1.5, -overlap ])
            cylinder(h = 100, r = 1.5);

            rotate([ 0, 0, a ])
            translate([ 0, taperedBearingInnerDia / 2 - wall * 1.5, 10+wall ])
            cylinder(h = 100, r = 3, $fn=6);

        }

    }
}