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
    cylinder(h = wall, r = baseDia / 2);

    // gear
    difference()
    {
        pulleyCAD(model = "GT2 2mm", teethCount = 140, beltWidth = 12, shaftDiameter = 2, pulleyDiameter = 100,
                  retainerHeight = 0, idlerHeight = 0, baseDiameter = 10, baseHeight = wall-overlap);

        cylinder(h = taperedBearingHeight + overlap * 2, r = taperedBearingDia / 2 + wall * 2);
    }

   // translate([ 0, 0, wall + baseGap ]) baseSkeleton();
   // frame();
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