/*
            Retina Slices Petri Dish whatever
            
Designed by L. Zanneti 
A. koschak lab, University of Innsbruck, Austria
This project is Open Source licensed, released under CERN OHL v1.2


                                                                    */

// // // // // // // // // // // // // //
/*           User Parameters           */

tol = 0.1;              // Printer tolerance
Wall = 2;               // Wall thickness
smoothness = 30;        // Numbers of Facets


// // // // // // // // / // // // //
/*            Switches             */
 
Lid = 10;
Dish = 1;


// // // // // // // // // // // // // // //
/*        Component Parameters            */

h_pd = 20;                // Heigh of the Petri Dish
r_pd = 120/2;             // Radius of the Petri Dish
h_sc = 5;                 // Heigh of the slice holders
r_sc = 5/2;               // Radisus of the slice holders
w_outer = 10;             // Width of the Outer Dish (Bubbling thing)
r_outer_pin = 2;          // Radius of the holes connecting the two chambers
r_Bubble_hole = 1;        // Radius of the bubbling holes in the outer chamber
h_Holder = h_pd - 5*Wall;
r_Holder = 5;


// // // // // // // // // // //
/*           Modules          */


module Petri_Dish(){
difference() {
    cylinder(h=h_pd, r=r_pd, $fn=smoothness);   // Main Body
    difference(){
        translate([0,0,Wall])cylinder(h=h_pd, r=r_pd-Wall, $fn=smoothness); // Outer Dish
        difference(){
            translate([0,0,Wall])cylinder(h=h_pd-2*Wall, r=r_pd-Wall-w_outer, $fn=smoothness); // Inner Dish
            translate([0,0,Wall])cylinder(h=h_pd-2*Wall, r=r_pd-Wall-w_outer-Wall, $fn=smoothness); // Inner Dish
        }
    }   
}
}

    
module Outer_Pin(){
translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,45])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,90])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,135])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,180])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,225])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,270])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,315])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
    
rotate([0,0,22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,45+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,90+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,135+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,180+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,225+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,270+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
rotate([0,0,315+22.5])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );
}

module Bubble_Ring(){
difference (){
    translate([0,0,w_outer/2])rotate_extrude(convexity = 10)translate([r_pd-Wall-w_outer/2,0,0])circle(r=w_outer/2); 
    
    translate([0,0,w_outer/2-Wall])rotate_extrude(convexity = 10)translate([r_pd-Wall-w_outer/2,0,0])circle(r=w_outer/2-Wall);  
    for (i = [0 : 1 : 36]){rotate(i*10,[0,0,1])translate([r_pd-Wall-w_outer/2,0,w_outer/2])rotate([0,45,0])cylinder(h=w_outer/2, r=r_Bubble_hole, $fn=smoothness );}
    for (i = [0 : 1 : 35]){rotate(i*10+5,[0,0,1])translate([r_pd-Wall-w_outer/2,0,w_outer/2])rotate([0,30,0])cylinder(h=w_outer/2, r=r_Bubble_hole, $fn=smoothness );}
}}

module Slice_Holder(){
difference() {
    cylinder(h =h_Holder, r= r_Holder, $fn =smoothness);
    cylinder(h =h_Holder, r= r_Holder-Wall, $fn =smoothness);
    translate([-r_Holder/3,-r_Holder,0])cube([r_Holder*2/3,2*r_Holder,h_Holder/2]);
    translate([-r_Holder,-r_Holder/3,0])cube([r_Holder*2,r_Holder*2/3,h_Holder/2]);
}}

translate([0,r_pd-Wall-w_outer-5*Wall-r_Holder,Wall]) Slice_Holder();
translate([0,-(r_pd-Wall-w_outer-5*Wall-r_Holder),Wall]) Slice_Holder();
translate([r_pd-Wall-w_outer-5*Wall-r_Holder,0,Wall]) Slice_Holder();
translate([-(r_pd-Wall-w_outer-5*Wall-r_Holder),0,Wall]) Slice_Holder();



module Lid(){
    translate([0,0, 40])cylinder(h = 2, d = ypd, $fn= smoothness ); 
    difference () {  
       translate([0,0, 37])cylinder(h = 5, d = ypd-4, $fn= smoothness );
       translate([0,0, 37])cylinder(h = 5, d = ypd-6, $fn= smoothness );
    }
}

if (Lid==1)Lid();
if (Dish==1){
    difference(){
        Petri_Dish();
        Outer_Pin();
    }
    Bubble_Ring();
}