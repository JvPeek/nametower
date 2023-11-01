include <tools/pulley-generator.scad>
slipRingMountingHeight = 80;
module base()
{
    $fn = 100;
    module screwHoles(height = 100)
    {
        for (a = [0:360 / 6:360])
        {
            rotate([ 0, 0, a ]) translate([ innerTube / 2 - wall * 2, 0, -overlap ]) cylinder(h = height, r = 3 / 2);
        }
    }

    // base
    difference() {
        union() {
            cylinder(h = wall, r = baseDia / 2);
            cylinder(taperedBearingInnerHeight+wall, r = taperedBearingInnerDia / 2);
        }
        translate([0,0,-overlap*2])
        cylinder(taperedBearingInnerHeight+wall+overlap*4, r = taperedBearingInnerDia / 2 - wall*3);
        wireOffset=4;
        wireSize=2.5;
        rotate([90,0,0])
        for(a=[-wireOffset:wireOffset:wireOffset]) {
            translate([a,wireSize/2,0])
            hull() {
                cylinder(h=baseDia/2+wall, r=wireSize/2);
                translate([-wireSize/2,-wireSize/2-overlap,0])
                cube([wireSize,overlap,baseDia/2]);
            }
        }
        for (a=[0:360/3:360]) {
            rotate([0,0,a])
            translate([0,baseDia/2-15,-overlap])
            cylinder(h=2, r=19/2);
        }

        for (a=[0:360/6:360]) {
            rotate([0,0,a])
            translate([0,taperedBearingInnerDia / 2 - wall*1.5,-overlap])
            union() {
                cylinder(h=100, r=1.5);
                cylinder(h=5, r=3);
            }
            
        }

    }

    // gear
    difference()
    {
        pulleyCAD(model = "GT2 2mm", teethCount = 140, beltWidth = 12, shaftDiameter = 2, pulleyDiameter = 100,
                  retainerHeight = 0, idlerHeight = 0, baseDiameter = 10, baseHeight = wall - overlap);

        cylinder(h = taperedBearingFullHeight + overlap * 2, r = taperedBearingDia / 2 + wall * 2);
    }



    
}

module slipRingMount()
{
    difference()
    {
        cylinder(h = 10, r1 = innerTube / 2, r2 = slipRingStatorMountDia / 2 + wall);
        translate([ 0, 0, -overlap ])
            cylinder(h = 10 + overlap * 2, r1 = innerTube / 2 - wall, r2 = slipRingStatorDia / 2);
    }
}