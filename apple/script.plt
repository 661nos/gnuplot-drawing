reset
set term pdfcairo enhanced size 3in, 3in
set angles radians
set key right top
set noxtics
set noztics
set noytics
set noborder
set nogrid

set parametric

set term gif animate optimize delay 10 size 480,480
set output 'apple.gif'

set isosamples 70,60
set hidden3d
set title "apple"

set xlabel ""
set ylabel ""
set zlabel ""

set xrange [-3:3]
set yrange [-3:3]
set zrange [-4:2]

#set trange [0:2*pi]
set urange [0:2*pi]
set vrange [0:pi]

#set view 3+45*2,0
set view 75,0,1,1


#splot sqrt(cos(v))*cos(v/2),(u-pi)/50,1+sqrt(cos(v))*sin(v/2) title "" lc "green",sqrt(cos(v))*cos(v/2),(u-pi)/100,1-sqrt(cos(v))*sin(v/2) title "" lc "green",sqrt(cos(v))*cos(v/2),pi/100,1+sqrt(cos(v))*sin(v/2)*(u-pi)/(pi) title "" lc "green",sqrt(cos(v))*cos(v/2),-pi/50,1+sqrt(cos(v))*sin(v/2)*(u-pi)/(pi) title "" lc "green",0.15*cos(u),0.15*sin(u), v/2 title "" lc "brown",2*(1-0.75*cos(v))*cos(u)*sin(v),2*(1-0.75*cos(v))*sin(u)*sin(v),2*(1-cos(v))*cos(v) title "" lc "red"
splot sqrt(cos(v-pi/2))*cos(v-pi/2),0,1+sqrt(cos(v-pi/2))*sin(v-pi/2)*(u-pi)/(2*pi) title "" lc "green",0.15*cos(u),0.15*sin(u), v/2 title "" lc "brown",2*(1-0.75*cos(v))*cos(u)*sin(v),2*(1-0.75*cos(v))*sin(u)*sin(v),2*(1-cos(v))*cos(v) title "" lc "red"

do for [i = 0:90 ]{
	#a = i *0.4*pi
   	#set view 60,4*i
	set view 30+abs(i-45),4*i,1,1
	replot
}

#set output "a.pdf"

set out

replot
