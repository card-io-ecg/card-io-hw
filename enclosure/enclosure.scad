include <rounded_rect.scad>

$fn = 50;

/* Set to false if you want to render the box */
design = false; // draw the box or the PCB and the part cutouts
drawBoard = false; // draw the board on top of the box in !design
fullHeight = true; // display flat overlays or the full height cutouts

flatCutout = design && !fullHeight;

boardThickness = 0.8;
nominalBoardWidth = 85;
nominalBoardHeight = 55;

partMaskHeight =       flatCutout ? 0.1 : 1.5;
highPartMaskHeight =   flatCutout ? 0.1 : 2;
frontendMaskHeight =   flatCutout ? 0.1 : 3;
espMaskHeight =        flatCutout ? 0.1 : 3;
espPcbMaskHeight =     flatCutout ? 0.1 : 1.2;
batteryMaskHeight =    flatCutout ? 0.1 : 3;
usbHeight =            flatCutout ? 1   : 3.4;

wallThickness = 0.6;
wallHeight = 3.4;
edgeRounding = 1;
cornerRadius = 1.4;

boxWidth = nominalBoardWidth;
boxHeight = nominalBoardHeight;

module boardAndParts()
{
    /* Display */
    color("blue")
    translate([29, 24.6, -partMaskHeight])
    cube([27.8, 20, partMaskHeight]);
    translate([29, 16, 0])
    cube([27.8, 15, partMaskHeight]);
    //*/

    /* USB port body */
    color("purple")
    translate([36, -0.2, 0])
    cube([9.5, 9, usbHeight]);
    //*/

    /* Battery */
    translate([4, 6, 0])
    cube([10, 7, batteryMaskHeight]);
    translate([19, 6, 0])
    cube([10, 7, batteryMaskHeight]);
    translate([0.6, 10, 0])
    cube([32.4, 43, batteryMaskHeight]);
    //*/

    /* Battery protection */
    translate([8, 1, 0])
    cube([21, 5, highPartMaskHeight]);
    //*/

    /* Battery charger */
    translate([29, 1, 0])
    cube([5, 12, partMaskHeight]);
    //*/

    /* PSU */
    color("purple")
    translate([32, 7.5, 0])
    cube([23, 9, highPartMaskHeight]);
    //*/

    /* ===== MCU ===== */
    translate([60, 1.2, 0])
    cube([27, 18.8, espPcbMaskHeight]);
    translate([59, 1.6, 0])
    cube([20, 18.8, espMaskHeight]);
    /* MCU pads */
    color("purple")
    translate([56.8, 0.6, 0])
    cube([25.2, 20.8, partMaskHeight]);
    //*/
    /* MCU others */
    // XTAL32K
    translate([64, 21, 0])
    cube([6, 7, partMaskHeight]);
    // reset resistor / bypass caps
    translate([72.5, 21, 0])
    cube([6.5, 8, partMaskHeight]);
    // I2C resistors
    color("purple")
    translate([50, 2.5, 0])
    cube([5, 5, partMaskHeight]);
    //*/

    /* ===== Analog frontend ===== */
    translate([49, 30, 0])
    cube([33.5, 24, frontendMaskHeight]);
    /* AFE pads */
    color("purple")
    translate([46, 47, 0])
    cube([3, 6.3, partMaskHeight]);
    color("purple")
    translate([80.5, 36.5, 0])
    cube([3, 6.3, partMaskHeight]);
    color("purple")
    translate([63, 28, 0])
    cube([18.7, 3, partMaskHeight]);
    //*/
}

if (!design)
{
    rotate([180, 0, 0])
    union() {
        translate([0, 0, - wallHeight - wallThickness])
        difference()
        {
            /* ===== Shell ===== */
            difference()
            {
                /* Box */
                translate([wallThickness, wallThickness, 0])
                minkowski()
                {
                    roundedRect([boxWidth-2*wallThickness, boxHeight-2*wallThickness, wallHeight], cornerRadius, false);
                    sphere(wallThickness);
                }
                    
                /* cut the bottom half */
                translate([-boxWidth, -boxHeight, -wallHeight])
                cube([3 * boxWidth, 3 * boxHeight, wallHeight]);
            }

            boardAndParts();
        }
        
        if (drawBoard) {
            color("green")
            translate([0, 0, -wallHeight -wallThickness - boardThickness])
            import("main_board.stl");
        }
    }
}
else
{
    color("green")
    translate([0, 0, -boardThickness])
    import("main_board.stl");
    boardAndParts();
}
