$fn=100;

height = 5;
handle_width = 50;

// Create space to allow for the door handle to fit to the door stop.
module door_stop_inner_shape() {
    minkowski() {
        translate([0,-20,0]) cube([handle_width/4,50,height],center=true);
        cylinder(r=5,h=height,center=true);
    }
}

// Main shape of the door stop
//
// This is used to create main shape of the door stop itself.
module door_stop_main_shape() {
    minkowski() {
        cube([handle_width,handle_width/2,1],center=true);
        cylinder(r=20,h=height,center=true);
    }
}

module top_section() {
    difference() {
        door_stop_main_shape();
        door_stop_inner_shape();
    }
}

module handle_strap_hole() {
    minkowski() {
        translate([0,0,0]) cube([handle_width/2 + 5,10,1], center=true);
        cylinder(r=10,h=height,center=true);
    }
}

module main_handle_bracket() {
    difference() {
        top_section();
        handle_strap_hole();
    }
}

// Connecting part to the door brace and the wall knudge
// TODO: Design this so that it's an actual spring
module wall_knudge_spring() {
    translate([0,45,0]) cube([handle_width/2,handle_width,height * 2], center=true);
}

module wall_knudge_base() {
    hull() {
        minkowski() {
            translate([0,handle_width + 10,0]) {
                cube([handle_width * 2,height/2,height/2], center=true);
            }
            cylinder(r=5,h=height,center=true);
        }
        translate([0,handle_width + 20,0]) {
            cube([90,10,height * height], center=true);
        }
    }
}

module wall_knudge() {
    union() {
        wall_knudge_spring();
        wall_knudge_base();        
    }
}

scale([0.5,0.5,0.5]) {
    scale([1,1,3]) main_handle_bracket();
    wall_knudge();
}