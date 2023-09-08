
module base() {
    module screwHoles(height=100) {
        
        for (a=[0:360/6:360]) {
            rotate([0,0,a])
            translate([innerTube/2-wall*2,0,-overlap])
            cylinder(h=height,r=3/2);
        }
    }
    $fn=100;
    // base
    translate([0,0,-overlap])
    difference() {
        cylinder(h=baseHeight, r=baseDia/2);
        translate([0,0,-overlap])
        cylinder(h=baseHeight-wall+overlap, r=baseDia/2-wall);
        translate([0,0,-overlap])
        cylinder(h=baseHeight+overlap*2,r=innerTube/2-wall*3);
        screwHoles(baseHeight+overlap*2);
        
    }
    
    // tube
    translate([0,0,baseHeight])
    difference() {
        cylinder(h=(height+wall)*levels+baseGap, r=innerTube/2);
        translate([0,0,-overlap])
        cylinder(h=(height+wall)*levels+baseGap+overlap*2, r=innerTube/2-wall);
        // separator
        translate([-50,-50,baseGap+(height+wall)*levels/2])
        cube([100,100,overlap]);
        
    }
    
    
    translate([0,0,baseHeight])

    difference() {
        // bottom tube connector
        cylinder(h=wall,r=innerTube/2-wall);
        translate([0,0,-overlap])
        cylinder(h=wall+overlap*2,r=innerTube/2-wall*3);
        screwHoles(wall+overlap*2);
        
        
    }
    translate([0,0,baseHeight+baseGap+(height+wall)*levels/2-wall])

    difference() {
        // tube connector
        cylinder(h=wall*2,r=innerTube/2-wall);
        translate([0,0,-overlap])
        cylinder(h=wall*2+overlap*2,r=innerTube/2-wall*3);
        translate([-50,-50,wall])
        cube([100,100,overlap]);
        screwHoles(wall*2+overlap*2);
        
        
    }
    // lower bearing holder
    translate([0,0,baseHeight+baseGap])
    difference() {
        cylinder(h=height-bearingHeight, r2=innerTube/2+2,r1=innerTube/2);
        translate([0,0,-overlap])
        cylinder(h=100, r=innerTube/2);
    }
    
}