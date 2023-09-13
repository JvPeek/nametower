slipRingMountingHeight=80;
module base() {
    module screwHoles(height=100) {
        
        for (a=[0:360/6:360]) {
            rotate([0,0,a])
            translate([innerTube/2-wall*2,0,-overlap])
            cylinder(h=height,r=3/2);
        }
    }
    $fn=100;
}

module slipRingMount() {
     difference() {
        cylinder(h=10, r1=innerTube/2,r2=slipRingStatorMountDia/2+wall);
        translate([0,0,-overlap])
        cylinder(h=10+overlap*2, r1=innerTube/2-wall, r2=slipRingStatorDia/2);
   
        
    }
}
