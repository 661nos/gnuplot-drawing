reset
set term pdfcairo enhanced size 4in, 4in
set angles radians
set key right top
set noxtics
set noztics
set noytics
set noborder
set nogrid

set parametric

set term gif animate optimize delay 1 size 720,720
set output 'bishop.gif'

set isosamples 30,30
set hidden3d
set view equal xyz
set title "bishop"

set xlabel ""
set ylabel ""
set zlabel ""

set xrange [-5:5]
set yrange [-5:5]
set zrange [0:10]

set urange [0:2*pi]
set vrange [0:2*pi]

set view 75,0,1,1

cname1 = 0x000000
cname2 = 0xffffff

umton(u, m, n) = u / (2 * pi) * (n - m) + m
vmton(v, m, n) = umton(v, m, n)

uton(u, n) = umton(u, 0, n)
vton(v, n) = uton(v, n)

unp(u, n, p) = umton(u, n, n + p)
vnp(v, n, p) = unp(v, n, p)

max(x, y) = (x > y) ? x : y
min(x, y) = (x < y) ? x : y

r1(v) = 2 + 0.5 * sin(vton(v, pi))
r1_1(v, a) = a + 0.25 * sin(vton(v, pi))
r1_1_1(v, a, r) = a + r * sin(vton(v, pi))
r2(v) = 2*exp(-8*vton(v, 1)**2)
r3(v) = 1.5 - 1 * vton(v, 1)
r3atob(v, a, b) = a - (a - b) * vton(v, 1)
r4(v, a, h) = max(0, (h**2 - a**2)/(2*a)*cos(vton(v, pi/2)))
r5(v, a) = a * (1 - vton(v, 1) **2)

the(u, v) = umton(u, -pi + acos(vton(v, 1)), pi - acos(vton(v, 1)))
the_1(v) = -pi + acos(vton(v, 1))
the2(u, v) = umton(u, pi - acos(min(vton(v, 1) + 0.25, 1)), pi + acos(min(vton(v, 1) + 0.25, 1)))
the2_1(v) = pi - acos(min(vton(v, 1) + 0.25, 1))


splot r1(v) * cos(u), r1(v) * sin(u), vton(v, 1) title "" lc rgbcolor cname1 ,vton(v, 2) * cos(u), vton(v, 2) * sin(u), 0 title "" lc rgbcolor cname1, r2(v) * cos(u), r2(v) * sin(u), vmton(v, 1, 6) title "" lc rgbcolor cname1, r3(v) * cos(u), r3(v) * sin(u), vmton(v, 1, 5.5) title "" lc rgbcolor cname1, r1_1(v, 1.3) * cos(u), r1_1(v, 1.3) * sin(u), vnp(v, 1.8, 0.5) title "" lc rgbcolor cname1, vton(v, 1.05) * cos(u), vton(v, 1.05) * sin(u), 5 title "" lc rgbcolor cname1, r1_1_1(v, 1.05, 0.2) * cos(u), r1_1_1(v, 1.05, 0.2) * sin(u), vnp(v, 5, 0.4) title "" lc rgbcolor cname1, r3atob(v, 1.05, 0.8) * cos(u), r3atob(v, 1.05, 0.8) * sin(u), vnp(v, 5.4, 0.6) title "" lc rgbcolor cname1, r4(v, 1, 2) * cos(the(u, v)), r4(v, 1, 2) * sin(the(u, v)), vnp(v, 6.5, 2) title "" lc rgbcolor cname1, r4(v, 1, 2) * cos(the_1(v)), r4(v, 1, 2) * sin(the_1(v))*umton(u, -1, 1), vnp(v, 6.5, 2) title "" lc rgbcolor cname2, r4(v, 1, 2) * cos(the2(u, v)), r4(v, 1, 2) * sin(the2(u, v)), vnp(v, 6.5, 2) title "" lc rgbcolor cname1, r4(v, 1, 2) * cos(the2_1(v)), r4(v, 1, 2) * sin(the2_1(v))*umton(u, -1, 1), max(7, vnp(v, 6.5, 2)) title "" lc rgbcolor cname2, r4(v, 1, 2) * cos(u), r4(v, 1, 2) * sin(u), vnp(v, 6.5, -2) title "" lc rgbcolor cname1, r5(v, 0.5) * cos(u), r5(v, 0.5) * sin(u), vnp(v, 8.5, 0.5) title "" lc rgbcolor cname1, r5(v, 0.5) * cos(u), r5(v, 0.5) * sin(u), vnp(v, 8.5, -0.5) title "" lc rgbcolor cname1

do for [i = 0:90 ]{
	set view 75,360 - 4*i,1,1
	replot
}


set out

replot
