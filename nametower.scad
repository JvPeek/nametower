include <MCAD/stepper.scad>

include <rendering.scad>

include <skeleton.scad>
include <nametags.scad>
include <base.scad>
include <frame.scad>
render="base";
name="s1cc3sT";
sides=6;
sideSize=335-50;
levels=5;
gap=5;
thinWall=1.2;
height=50;
wall=3;
nametagDepth=6;
overlap=0.01;
stripSize=12;
ledDistance=30;
clipHeight=20;
rotationOffset=0;
innerTube=40;
outerTube=62.5;
baseHeight=10;
baseGap=3;
baseDia=150;
bearingHeight=7;
//https://www.kugellager-shop.net/mr-61710-2rs-61710rs-kugellager-62x50x6.html
shelfWalls=20;
shelfSize=[335,390,335];

module nema() {

      translate([0,0,39+1.9])
    rotate([0,180,0])  motor(Nema17, NemaMedium, dualAxis=false);

}

render(render, cutopen=true);
//translate([0,50,0])
//nema();