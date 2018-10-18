# 临摹设计师Johnyvino的作品：https://www.uplabs.com/posts/material-motion-freekit-principle

# Define and set custom device 
Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 1604
	screenHeight: 1204

# Aware-Move away
frameA=frame1_1.frame
frameB=frame1_2.frame
frameC=frame1_3.frame


# frame1_1展开
frame1_1.states.spread=
	height:160
	options:
		time:0.3

# frame1-1收缩
frame1_1.states.collapse1=
	frame:frameA
	animationOptions:
		time:0.3

# frame1-2展开
frame1_1.states.collapse2=
	y: frameA.y-54
	animationOptions:
		time:0.3

# frame1-3展开
frame1_1.states.collapse3=
	y: frameA.y-108
	animationOptions:
		time:0.3


# frame1-2展开
frame1_2.states.spread=
	height:160
	y: 26
	animationOptions:
		time:0.3


# frame1-2收缩
frame1_2.states.collapse0=
	frame:frameB
	animationOptions:
		time:0.3


# frame1-1展开时
frame1_2.states.collapse1=
	y:frameB.y+108
	animationOptions:
		time:0.3

# frame1-3展开时
frame1_2.states.collapse2=
	y: frameB.y-108
	animationOptions:
		time:0.3

# frame1-3扩展
frame1_3.states.spread=
	height:160
	y:44
	animationOptions:
		time:0.3

# frame1-3收缩
frame1_3.states.collapse0=
	frame:frameC
	animationOptions:
		time:0.3

# frame1-1展开时frame1-3的状态
frame1_3.states.collapse1=
	y: frameC.y+108
	animationOptions:
		time:0.3


# frame1-2展开时frame1-3的状态
frame1_3.states.collapse2=
	y: frameC.y+54
	animationOptions:
		time:0.3




frame1_1.onTap ->
	frame1_1.stateCycle("spread","collapse1")
	frame1_2.stateCycle("collapse1","collapse0")
	frame1_3.stateCycle("collapse1","collapse0")



frame1_2.onTap ->
	frame1_1.stateCycle("collapse2","collapse1")
	frame1_2.stateCycle("spread","collapse0")
	frame1_3.stateCycle("collapse2","collapse0")


frame1_3.onTap ->
	frame1_1.stateCycle("collapse3","collapse1")
	frame1_2.stateCycle("collapse2","collapse0")
	frame1_3.stateCycle("spread","collapse0")

# Creation Choreo-Grid
# fram2-0扩展，以显示其子图层line_circle
animation1=new Animation frame2_0,
	width:212
	height: 212
	x: 494
	options:
		time:0.23




for frame in [frame2_1,frame2_2,frame2_3,frame2_4,frame2_5,frame2_6,frame2_7,frame2_8,frame2_9]
	frame.size=0
	opacity=0



spreadBar.onClick ->
	animation1.start()
	frame2_1.animate
		size:60
		opacity: 1
		options: 
			time: 0.15
			curve: Bezier.easeOut


	frame2_2.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.02
			curve: Bezier.easeOut
	frame2_4.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.02
			curve: Bezier.easeOut

	frame2_3.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.04
			curve: Bezier.easeOut
	frame2_5.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.04
			curve: Bezier.easeOut
	frame2_7.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.04
			curve: Bezier.easeOut



	frame2_6.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.06
			curve: Bezier.easeOut
	frame2_8.animate
		size:60
		opacity: 1
		options: 
			time:0.15
			delay: 0.06
			curve: Bezier.easeOut



	frame2_9.animate
		size:60
		opacity: 1
		options: 
			time: 0.15
			delay: 0.08
			curve: Bezier.easeOut

# Surface connection-creation
frame3_2.states.spread=
	size:200
	animationOptions:
		time:0.3

frame3_2.states.hide=
	size:0
	animationOptions:
		time:0.3


frame3_1.onTap ->
	frame3_2.stateCycle("spread","hide")

# Creation Choreo-List
for frame in [frame4_1,frame4_2,frame4_3,frame4_4]
	frame.opacity=0

animation2=new Animation frame4_0,
	height:229
	options:
		time:0.3
		curve: Bezier.easeOut

Utils.delay 1,->
	animation2.start()
	frame4_1.animate
		opacity: 1
		options: 
			time: 0.3
			curve: Bezier.easeOut

Utils.delay 1.05,->
	frame4_2.animate
		opacity: 1
		options: 
			time: 0.3
			curve: Bezier.easeOut

Utils.delay 1.1,->
	frame4_3.animate
		opacity: 1
		options: 
			time: 0.3
			curve: Bezier.easeOut


Utils.delay 1.15,->
	frame4_4.animate
		opacity: 1
		options: 
			time: 0.3
			curve: Bezier.easeOut











