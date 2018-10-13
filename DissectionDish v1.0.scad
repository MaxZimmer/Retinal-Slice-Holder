/*


                 ---  Retinal Slices Disection Dish  ---
                        
            
Designed by L. Zanetti 
A. Koschak lab, University of Innsbruck, Austria

This project is Open Source licensed, released under CERN OHL v1.2         */
                                                                    
                                                                    
                                                                    

// // // // // // // // // // // // // // // // // // // // // // // // // //
/*                             User Parameters                             */

tol = 0.1;              // Printer tolerance
Wall = 2;               // Wall thickness
smoothness = 30;        // Numbers of Facets

sep = 20;                // Lid sep value for visualisation


// // // // // // // // // // // // // // // // // // // // // // // // // //
/*                                Switches                                 */
 
Lid = 1;
Dish = 1;


// // // // // // // // // // // // // // // // // // // // // // // // // //
/*                        Component Parameters                             */

h_pd = 20;                   // Heigh of the Petri Dish
r_pd = 120/2;                // Radius of the Petri Dish
h_sc = 5;                    // Heigh of the slice holders
r_sc = 5/2;                  // Radisus of the slice holders
w_outer = 7.5;                // Width of the Outer Dish (Bubbling thing)
r_outer_pin = 2;             // Radius of the holes connecting the two chambers
r_Bubble_hole =0.5;          // Radius of the bubbling holes in the outer chamber
h_Holder = h_pd - 5*Wall;    // Heigh of the slice holder
r_Holder = 5;                // Radius of the slice holder
pos_Holder = 30;             // Position of the Holder relative to the centre of the dish


// // // // // // // // // // // // // // // // // // // // // // // // // //
/*                                 Modules                                 */


module Petri_Dish(){
difference(){
    cylinder(h=h_pd, r=r_pd, $fn=smoothness);   // Main Body
    
    difference(){
        translate([0,0,Wall])cylinder(h=h_pd-Wall, r=r_pd-Wall, $fn=smoothness); // Outer Dish
        
        difference(){
            union(){
                translate([0,0,Wall])cylinder(h=h_pd-2*Wall, r=r_pd-Wall-w_outer, $fn=smoothness); // Inner Dish
                translate([0,0,h_pd-2*Wall])cylinder(h=Wall, r=r_pd, $fn=smoothness); // Outer ring cover
            }
            
            translate([0,0,Wall])cylinder(h=h_pd-2*Wall, r=r_pd-Wall-w_outer-Wall, $fn=smoothness); // Inner Dish
        }
    }   
}}
    
module Outer_Pin(){
for (i = [0 : 45 : 360]){rotate(i,[0,0,1])translate([r_pd-Wall-w_outer,0,2*Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );}
for (i = [0 : 45 : 360]){rotate(i+22.5,[0,0,1])translate([r_pd-Wall-w_outer,0,Wall+3*r_outer_pin])rotate([0,-90,0])cylinder(h=2*Wall, r=r_outer_pin, $fn= smoothness );}
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

module Holders(){
translate([0,pos_Holder,Wall]) Slice_Holder();
translate([0,-pos_Holder,Wall]) Slice_Holder();
translate([pos_Holder,0,Wall]) Slice_Holder();
translate([-pos_Holder,0,Wall]) Slice_Holder();
}

module Lid(){
    cylinder(h=Wall, r=r_pd, $fn=smoothness); 
    translate([0,0,-Wall+tol])cylinder(h=Wall-tol, r=r_pd-Wall-tol);
}


// // // // // // // // // // // // // // // // // // // // // // // // // //
/*                                  Display                                */

if (Lid==1)translate([0,0,h_pd+sep])Lid();
if (Dish==1){
    difference(){
        Petri_Dish();
        Outer_Pin();
    }
    Bubble_Ring();
    Holders();
}