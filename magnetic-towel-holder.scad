include <scad-utils/morphology.scad>
include <scad-utils/mirror.scad>

$fn=60;

BODY_X = 50;
BODY_Y = 50;
BODY_Z = 15;
MAGNET_D=10.5;

module baseShape(args) {
  rounding(r=5)
  square(size=[BODY_X, BODY_Y], center=true);
}

module body(args) {
  difference() {
    // base
    linear_extrude(height=BODY_Z, center=!true, convexity=10, twist=0)
    baseShape();

    // inner space
    translate([-5, 0, 0])
    hull() {
      // top
      translate([-BODY_X/8, 0, 2])
      linear_extrude(height=1, center=!true, convexity=10, twist=0)
      hull() {
        mirror_x()
        translate([BODY_X/3, 0, 0])
        circle(d=1);
      }

      // bottom
      translate([0, 0, BODY_Z-1])
      linear_extrude(height=1, center=!true, convexity=10, twist=0)
      hull() {
        translate([BODY_X/3.5, 0, 0])
        circle(d=5);

        mirror_y()
        translate([-(BODY_X/2), BODY_Y/3.5-5, 0])
        circle(d=5);
      }
    }

    // magnets & screws
    mirror_y()
    translate([-(BODY_X/2-MAGNET_D/2-2), BODY_Y/2-MAGNET_D/2-2, -0.01]){
      cylinder(d=MAGNET_D, h=2.7, center=!true);
      cylinder(d=1.5, h=10, center=!true);
    }
    translate([BODY_X/2-MAGNET_D/2-2, 0, -0.01]){
      cylinder(d=MAGNET_D, h=2.7, center=!true);
      cylinder(d=1.5, h=10, center=!true);
    }
  }
}

module frontPanelA(args) {
  translate([0, 0, BODY_Z-1])
  linear_extrude(height=1, center=!true, convexity=10, twist=0)
  difference() {
    intersection() {
      baseShape();

      union() {
        mirror_y()
        translate([0, BODY_Y/2+3/2, 0])
        resize([BODY_Y*1.3, BODY_Y])
        circle(d=BODY_Y);

        translate([BODY_Y/2, 0, 0])
        square(size=[BODY_X, BODY_Y], center=true);
      }
    }
    translate([-BODY_X/2.5, 0, 0])
    hull() {
      mirror_x()
      translate([BODY_X/2, 0, 0])
      circle(d=3);
    }
  }
}

module frontPanelB(args) {
  translate([0, 0, BODY_Z-1.5])
  linear_extrude(height=1.5, center=!true, convexity=10, twist=0)
  difference() {
    baseShape();

    translate([-(BODY_X/2), 0, 0])
    circle(d=15);

    translate([-BODY_X/2.5, 0, 0])
    hull() {
      mirror_x()
      translate([BODY_X/2, 0, 0])
      circle(d=3);
    }
  }
}


module frontPanelC(args) {
  translate([0, 0, BODY_Z-1.5])
  linear_extrude(height=1.5, center=!true, convexity=10, twist=0)
  difference() {
    baseShape();

    hull() {
      mirror_y()
      translate([-(BODY_X/2), BODY_Y/3.5-5, 0])
      circle(d=3);

      translate([-(BODY_X/2)+10, 0, 0])
      circle(d=3);

    }

    translate([-BODY_X/2.5, 0, 0])
    hull() {
      mirror_x()
      translate([BODY_X/2, 0, 0])
      circle(d=3);
    }
  }
}

body();
frontPanelA();
/* frontPanelB(); */
/* frontPanelC(); */
