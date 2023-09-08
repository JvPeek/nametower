include <tools.scad>
module shelf() {
    translate([0,0,shelfSize[2]/2-overlap*2])
    color([1,1,1])
    difference() {
        cube([shelfSize[0]+shelfWalls*2,shelfSize[1],shelfSize[2]+shelfWalls*2], center=true);
       
        cube([shelfSize[0],shelfSize[1]+overlap*2,shelfSize[2]], center=true);
    }
}


module level(level=1) {
    
    //singleSegment(sides=6, offset=0)
    difference() {
        union() { 
            frame();
            translate([0,0,wall])
            
            nametags();
            translate([0,0,wall+0])
            
            clips();
            translate([0,0,0])
            if (level == 0) {
                baseSkeleton();
            }
            if (level != 0 && level != levels-1) {
                skeleton();
            }
            if (level == levels-1) {
                topSkeleton();
            }
            
        }
        translate([-200,-200,height/2])
        *cube([400,400,200]);
    }
}
module render(render, cutopen=false) {
    difference() {
        

        if (render=="level") {
            level();
        }
        if (render=="baselevel") {
            level(0);
        }
        if (render=="toplevel") {
            //level(levels-1);
            topSkeleton();
        }

        if (render=="tower") {
            shelf();
            union() {
                translate([0,0,baseHeight])
                for (a=[0:levels-1]) {
                    translate([0,0,(height+wall)*a])
                    level(a);
                }
                base();
            }

            
            
        }
        if (render=="base") {
            difference() {
                
                    base();
                
            }
        }

        if (render=="nametag") {
            translate([0,0,-19])
            nametag(name, true);
        }

        if (render=="parts") {
            baseSkeleton();
            translate([sideSize+100,0,0]);
            skeleton();
        }
        if (cutopen) {
            translate([0,0,-overlap])
            cube([shelfSize[0]/2-overlap,shelfSize[1]/2-overlap,shelfSize[2]-overlap*2]);
        }
    }
}
