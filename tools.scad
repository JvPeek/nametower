module displayCheck(needle, haystack=renderList) {
    results = search([needle], haystack,0);
    
    if (len(results[0]) > 0) {
        children();
    }
}

module spreadEverywhere(offset=0) {
    for(a=[0:360/sides:360]) {
        rotate([0,0,a+offset])
        children();
    }
}

module singleSegment(sides=sides, offset=0) {
    intersection() {
        
        children();
        linear_extrude(1000)
        rotate([0,0,offset])
        hull() {
            square([overlap,overlap]);
            
            translate([sideSize*2,0,0])
            square([overlap,overlap]);
            
            rotate([0,0,360/sides])
            translate([sideSize*2,0,0])
            square([overlap,overlap]);
        }
    }
}


module ring(gap=gap, empty=true, shell=thinWall, sideSize=sideSize, onlyPosts=false) {
    if (onlyPosts) {
        intersection() {
            
            for (a=[0:360/sides:360]) {
                rotate([0,0,a+(360/(sides*2))])
                translate([-gap/2,-sideSize])
                square([gap,sideSize+10]);
            }
            difference() {
                circle(r=sideSize/2, $fn=sides);
                circle(r=sideSize/2-shell, $fn=sides);
            }
        }
        
    } else {
            
        difference() {
            circle(r=sideSize/2, $fn=sides);
            if (empty) {
                circle(r=sideSize/2-shell, $fn=sides);
            }
            if (gap > 0) {
                
                for (a=[0:360/sides:360]) {
                    rotate([0,0,a+(360/(sides*2))])
                    translate([-gap/2,-sideSize])
                    square([gap,sideSize]);
                }
            }
        }
    }
}