include <tools.scad>

include <MCAD/gears.scad>
include <MCAD/stepper.scad>
include <base.scad>
include <frame.scad>
include <nametags.scad>
include <skeleton.scad>
include <tower.scad>

module shelf()
{
    translate([ 0, 0, shelfSize[2] / 2 - overlap * 2 ]) color([ 1, 1, 1 ]) difference()
    {
        cube([ shelfSize[0] + shelfWalls * 2, shelfSize[1], shelfSize[2] + shelfWalls * 2 ], center = true);
        cube([ shelfSize[0], shelfSize[1] + overlap * 2, shelfSize[2] ], center = true);
    }
}

module level(level = 1)
{

    // singleSegment(sides=6, offset=0)
    difference()
    {
        union()
        {
            frame();
            translate([ 0, 0, wall ]) nametags();
            translate([ 0, 0, wall + 0 ]) clips();
            translate([ 0, 0, 0 ]) if (level == 0)
            {
                baseSkeleton();
            }
            if (level == 1)
            {
                skeleton();
            }
            if (level >= 2 && level != levels - 1)
            {
                regularSkeleton();
            }
            if (level == levels - 1)
            {
                topSkeleton();
            }
        }
        translate([ -200, -200, height / 2 ]) * cube([ 400, 400, 200 ]);
    }
}
module render(render, cutopen = false)
{
    difference()
    {

        union()
        {
            displayCheck("shelf") shelf();
            displayCheck("tower") tower();
            displayCheck("base") base();
            for (a = [0:levels - 1])
            {
                translate([ 0, 0, 20 + (height + wall) * a ]) displayCheck(str("level", a)) level(a);
                translate([ 0, 0, 20 + (height + wall) * a ]) displayCheck("levels") level(a);
            }
            displayCheck("nametag") translate([ 0, -sideSize / 1.5, -19 ]) nametag(name, false);
        }

        if (cutopen)
        {
            translate([ 0, 0, -overlap ])
                cube([ shelfSize[0] / 2 - overlap, shelfSize[1] / 2 - overlap, shelfSize[2] - overlap * 2 ]);
        }
    }
}