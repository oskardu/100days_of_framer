# 四个frame都要设置Clip，只显示frame内部的内容

# All content element are shared
content2.opacity=0

animationA=new Animation frame1,
	height:200
	y: 100
	options:
		time:0.3

frame1.states.spread=
	height:200
	y: 100
	animationOptions:
		time:0.3

frame1.states.fold=
	height: 52
	y: 174
	animationOptions:
		time:0.3

animationC=new Animation content2,
	opacity:1
	options:
		delay:0.05
		time:0.05

animationA.onAnimationStart ->
	animationC.start()

tapArea.onTap ->
	frame1.stateCycle("spread","fold")
	animationC.start()

# Few element are shared
frame=frame2.frame
frame_circle=circle2.frame


frame2.states.spread=
	width:200
	height: 200
	x: 500
	y: 100
	animationOptions:
		time:0.3

frame2.states.fold=
	frame:frame
	animationOptions:
		time:0.3

circle2.states.spread=
	x:523
	y: 162
	animationOptions:
		time:0.3

circle2.states.fold=
	frame:frame_circle
	animationOptions:
		time:0.3

rectangle2.states=
	spread:
		opacity:0
		animationOptions:
			time:0.01
	fold:
		opacity: 1
		animationOptions:
			time:0.01

rectangle2_1.onTap ->
	frame2.stateCycle("spread","fold")
	circle2.stateCycle("spread","fold")
	rectangle2.stateCycle("spread","fold")


# Multiple shared element
frame4=frame3.frame
frame_circle3=circle3.frame


# 框的状态变换
frame3.states.spread=
	size:200
	x: 100
	y: 370
	animationOptions:
		time:0.3

frame3.states.fold=
	frame:frame4
	animationOptions:
		time:0.3


# 中间圆的状态变换，此圆的父级不为frame3，运动不受frame3影响
circle3.states.spread=
	x: 118
	y: 382
	animationOptions:
		time:0.3

circle3.states.fold=
	frame:frame_circle3
	animationOptions:
		time:0.3


# rectangle3的两个状态，消失快，出现慢
rectangle3.states.spread=
	opacity: 1
	animationOptions:
		time:0.3

rectangle3.states.fold=
	opacity: 0
	animationOptions:
		time:0.1


rectangle3_1.states.spread=
	opacity: 0
	animationOptions:
		time:0.1
		
rectangle3_1.states.fold=
	opacity:1
	animationOptions:
		time:0.3



content3_1.states.spread=
	opacity: 0
	animationOptions:
		time:0.1

content3_1.states.fold=
	opacity: 1
	animationOptions:
		time:0.3



content3.states=
	spread:
		opacity:1
		animationOptions:
			time:0.3
	fold:
		opacity: 0
		animationOptions:
			time:0.1



rectangle3_2.onTap ->
	frame3.stateCycle("spread","fold")
	circle3.stateCycle("spread","fold")
	rectangle3.stateCycle("spread","fold")
	rectangle3_1.stateCycle("spread","fold")
	content3_1.stateCycle("spread","fold")
	content3.stateCycle("spread","fold")


# No shared element
frame_final=frame5.frame

frame5.states.spread=
	size:200
	x: 500
	y: 370
	animationOptions:
		time:0.3

frame5.states.fold=
	frame:frame_final
	animationOptions:
		time:0.3


content4.states.spread=
	opacity: 0
	animationOptions:
		time:0.1


content4.states.fold=
	opacity: 1
	animationOptions:
		time:0.3


content4_1.states.spread=
	opacity: 1
	animationOptions:
		time:0.3

content4_1.states.fold=
	opacity: 0
	animationOptions:
		time:0.1

rectangle4.onTap ->
	frame5.stateCycle("spread","fold")
	content4.stateCycle("spread","fold")
	content4_1.stateCycle("spread","fold")







