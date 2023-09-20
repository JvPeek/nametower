include <tools.scad>
module nametags() {
        
    difference() {
        linear_extrude(height)
        ring(gap=10.2, shell=nametagDepth);

        translate([0,0,wall-overlap])
        linear_extrude(height+overlap*2-wall*2)
        ring(gap=10.2+wall*2, sideSize=sideSize-thinWall, empty=false);
    }
    
}


module nametag(name="JvPeek", limitHeight=false) {
    $fn=10;
    module thisText(offset=0) {
        mirror([1,0])
        difference() {
            offset(offset) 
            text(name, font = "raustila", size=20, halign = "center", valign = "center");
            
            text(name, font = "raustila", size=20, halign = "center", valign = "center");
            
        }    
        
    }
  
    difference() {
        rotate([-90,0,0])
        translate([0,-sideSize/2,-height/2])
        singleSegment(sides=6, offset=360/6)
        nametags();
        
        if (limitHeight) {
            linear_extrude(21)
            resize([0,height-wall*4], auto=true)
            thisText(.1);
        }
        if (!limitHeight) {
            linear_extrude(21)
            resize([120,0], auto=true)
            thisText(.1);
        }
    }

}