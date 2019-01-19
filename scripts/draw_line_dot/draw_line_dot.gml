///@function draw_line_dot(x1,y1,x2,y2,solid_length,gap_length)
var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var xlen = x2 - x1;
var ylen = y2 - y1;
var len = point_distance(x1,y1,x2,y2);
var i = 0;
var i2 = i;
while(i < len){
    i2 = min(i + argument4, len);
    draw_line(x1+xlen*(i/len),y1+ylen*(i/len),x1+xlen*(i2/len),y1+ylen*(i2/len));
    i = i2 + argument5;
}