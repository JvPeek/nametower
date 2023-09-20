include <options.scad>
include <rendering.scad>

module nema()
{

    translate([ 0, 0, 39 + 1.9 ]) rotate([ 0, 180, 0 ]) motor(Nema17, NemaMedium, dualAxis = false);
}

render(render, cutopen = cutopen);
// translate([0,50,0])
// nema();