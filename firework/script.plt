reset
set term pdfcairo enhanced size 4in, 4in
#set angles degrees
set angles radians
#set logscale x
#set logscale y
set key right top
#set zeroaxis
set noxtics
set noytics
set noztics
set noborder

set parametric

set term gif animate optimize delay 1 size 480,480
set output 'firework.gif'

set isosamples 30,30
set hidden3d
set view equal xyz
set title "firework" textcolor "white"

imax = 40
xmax = 10
xmin = 0
ymax = 10
ymin = 0
zmax = 15
zmin = -1
xc = (xmax + xmin)/2
yc = (ymax + ymin)/2

set xlabel ""
set ylabel ""
set zlabel ""

set xrange [xmin:xmax]
set yrange [ymin:ymax]
set zrange [zmin:zmax]

set urange [0:2*pi]
set vrange [0:2*pi]

cname1 = 0x000000
ship = 0x000000
fire1 = 0xffffff
sky = 0x000066
watar = 0x000020
cname2 = 0xffffff

set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgbcolor sky behind

umton(u, m, n) = u / (2 * pi) * (n - m) + m
vmton(v, m, n) = umton(v, m, n)

uton(u, n) = umton(u, 0, n)
vton(v, n) = vmton(v, 0, n)

unp(u, n, p) = umton(u, n, n + p)
vnp(v, n, p) = unp(v, n, p)

max(x, y) = (x > y) ? x : y
min(x, y) = (x < y) ? x : y

#a:place
#b:velocity
#g:gravity
#dt

set view 80, 45, 1.25,1
	

ax = xc
ay = yc
az = 0
bx = 0
by = 0
bz = 2
g = 0
dt = 0.1

calca(a, b, dt_) = a + b * dt_
calcb(b, g_, dt_) = calca(b, -g_, dt_)

do for [i = 0:imax - 1]{
	splot umton(u, xmin, xmax),umton(v, xmin, xmax), sin(uton(u, xmax*4))*cos(vton(v, xmax*3))/10 title "" lc rgbcolor watar, umton(u, xmin, xmax),umton(v, xmin, xmax), sin(uton(u, xmax*4)+i*2*pi/imax)*cos(vton(v, xmax*3))/10 title "" lc rgbcolor watar,0.2 * cos(uton(u, pi)) + xc, vton(v, -1) + yc, 0.2 * (1 - sin(uton(u, pi))) title "" with points ps 0.1 lc rgbcolor ship, 0.2 * cos(uton(u, pi)) * vmton(v, 1, 0) + xc, vton(v, 1) + yc, 0.2 * (1 - sin(uton(u, pi))) * vmton(v, 1, 0) title "" with points ps 0.1 lc rgbcolor ship,umton(u, -0.25, 0.25) + xc, vmton(v, -1, 0) + yc, -abs(umton(u, -0.2, 0.2)) + 0.4 title "" with points ps 0.1 lc rgbcolor ship, ax, ay, az title "" with points pt 7 ps (1.5*i/imax) lc rgbcolor fire1
	ax = calca(ax, bx, dt)
	ay = calca(ay, by, dt)
	az = calca(az, bz, dt)
	bz = calcb(bz, g, dt)
	set view 80,i * 3 + 45, 1.25,1
	#replot

}

g = 0.5
frN = 25
#1,6,8,5,5
array fx[frN]
array fy[frN]
array fz[frN]
array gx[frN]
array gy[frN]
array gz[frN]

array fire[frN]

do for[i = 1:frN]{
	fx[i] = ax
	fy[i] = ay
	fz[i] = az
}
gx[1] = 0
gy[1] = 0
gz[1] = 2
fire[1] = 0xff0000
phi = rand(0)

do for[i = 1:6]{
	gx[i + 1] = cos(2*pi*i/6 + 0.1 * (rand(0) - 0.5)) 
	gy[i + 1] = sin(2*pi*i/6 + 0.1 * (rand(0) - 0.5))
	gz[i + 1] = 1.5
	fire[i + 1] = 0xf03232
}
do for[i = 1:8]{
	gx[i + 7] = cos(2*pi*i/8 + 0.1 * (rand(0) - 0.5))*1.7
	gy[i + 7] = sin(2*pi*i/8 + 0.1 * (rand(0) - 0.5))*1.7
	gz[i + 7] = 0.8
	fire[i + 7] = 0xfa8072
}
do for[i = 1:5]{
	gx[i + 15] = cos(2*pi*i/5 + 0.1 * (rand(0) - 0.5))*1.5
	gy[i + 15] = sin(2*pi*i/5 + 0.1 * (rand(0) - 0.5))*1.5
	gz[i + 15] = -0.4
	fire[i + 15] = 0xffff00
}
do for[i = 1:5]{
	gx[i + 20] = cos(2*pi*i/5 + 0.1 * (rand(0) - 0.5))*0.8 
	gy[i + 20] = sin(2*pi*i/5 + 0.1 * (rand(0) - 0.5))*0.8
	gz[i + 20] = -1.2
	fire[i + 20] = 0xadd8e6
}


g(x) = 0.5* x * (1 + 0.01*x**2)**(-1)
f(i) = (g(i) > 0.5 ? g(i) : 0)

do for [i = 0:imax * 2 - 1]{
	splot umton(u, xmin, xmax),umton(v, xmin, xmax), sin(uton(u, xmax*4))*cos(vton(v, xmax*3))/10 title "" lc rgbcolor watar, umton(u, xmin, xmax),umton(v, xmin, xmax), sin(uton(u, xmax*4)+i*2*pi/imax)*cos(vton(v, xmax*3))/10 title "" lc rgbcolor watar,0.2 * cos(uton(u, pi)) + xc, vton(v, -1) + yc, 0.2 * (1 - sin(uton(u, pi))) title "" with points ps 0.1 lc rgbcolor ship, 0.2 * cos(uton(u, pi)) * vmton(v, 1, 0) + xc, vton(v, 1) + yc, 0.2 * (1 - sin(uton(u, pi))) * vmton(v, 1, 0) title "" with points ps 0.1 lc rgbcolor ship,umton(u, -0.25, 0.25) + xc, vmton(v, -1, 0) + yc, -abs(umton(u, -0.2, 0.2)) + 0.4 title "" with points ps 0.1 lc rgbcolor ship,for [j = 1 : frN] fx[j], fy[j], fz[j] title"" with points ps f(i) + 0.5 * (rand(0) - 0.5) pt (floor(rand(0)*100)%18 + 1) lc rgbcolor (f(i) < 0.8 ? sky : fire[j])
	do for[j = 1 : frN]{
		fx[j] = calca(fx[j], gx[j], dt)+ 0.1 * (rand(0) - 0.5)
		fy[j] = calca(fy[j], gy[j], dt)+ 0.1 * (rand(0) - 0.5)
		fz[j] = calca(fz[j], gz[j], dt)+ 0.1 * (rand(0) - 0.5)
		gz[j] = calcb(gz[j], g, dt)+ 0.1 * (rand(0) - 0.5)
	}
	set view 80, (45 + 120 + i * 3)%360, 1.25,1
}



set out