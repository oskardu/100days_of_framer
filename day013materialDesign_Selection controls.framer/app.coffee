# Selection controls have a duration of 100ms.

# 选中1
smallcircle.opacity=0
bigcircle2.opacity=0


# 小圆扩大，改变颜色
animationA=new Animation smallcircle,
	width:10
	height: 10
	backgroundColor: "#0055FF"
	options:
		time:0.1
		curve:Bezier.easeOut

# 外圈改变颜色和透明度（作为子图层的小圆的透明度也跟着改变）
animationB=new Animation bigcircle,
	borderColor:"#0055FF"
	opacity: 1
	options:
		time:0.1
		curve:Bezier.easeOut

# 涟漪圆改变颜色，变大
animationC=new Animation bigcircle2,
	backgroundColor:"#0055FF"
	scale: 2
	options:
		time:0.1
		curve:Bezier.easeOut


# 涟漪圆透明度变为0
animationD=new Animation bigcircle2,
	opacity:0
	options:
		time:0.1
		curve:Bezier.easeOut

animationA.onAnimationStart ->
	animationB.start()
	animationC.start()


Utils.delay 1,->
	smallcircle.opacity=1
	bigcircle2.opacity=0.1
	animationA.start()

Utils.delay 1.1,->
	animationD.start()


animationE=new Animation smallcircle,
	width:2
	height: 2
	backgroundColor: "#000"
	options:
		time:0.1
		curve:Bezier.easeOut

animationF=new Animation bigcircle,
	borderColor:"#000"
	opacity: 0.54
	options:
		time:0.1
		curve:Bezier.easeOut


animationE.onAnimationEnd ->
	smallcircle.opacity=0

animationG=new Animation bigcircle2,
	scale: 2
	options:
		time:0.1
		curve:Bezier.easeOut

Utils.delay 2.2,->
	bigcircle2.size=26
	bigcircle2.backgroundColor="#bdbdbd"
	bigcircle2.opacity=0.1
	animationE.start()
	animationF.start()
	animationG.start()


Utils.delay 2.3,->
	animationD.start()

# checkbox
bigcircle3.opacity=0

# checkbox的边框厚度变化
animation1=new Animation checkbox,
	borderColor:"#0055FF"
	borderWidth:10
	options:
		time:0.1


# 涟漪圆改变颜色，变大
animation2=new Animation bigcircle3,
	backgroundColor:"#0055FF"
	scale: 2
	options:
		time:0.1
		curve:Bezier.easeOut


# 涟漪圆透明度变为0
animation3=new Animation bigcircle3,
	opacity:0
	options:
		time:0.1
		curve:Bezier.easeOut


animation4=animation1.reverse()

animation5=new Animation bigcircle3,
	scale: 2
	options:
		time:0.1
		curve:Bezier.easeOut

animation6=new Animation bigcircle3,
	opacity:0
	options:
		time:0.1

animation1.onAnimationStart ->
	bigcircle3.opacity=0.1
	animation2.start()


Utils.delay 1,->
	animation1.start()


Utils.delay 1.1,->
	animation3.start()


Utils.delay 2.2,->
	bigcircle3.scale=1
	bigcircle3.opacity=0.1
	bigcircle3.backgroundColor="#BDBDBD"
	animation4.start()
	animation5.start()

Utils.delay 2.3,->
	animation6.start()


# 开关
animate1=new Animation knob,
	x:20
	backgroundColor: "#0055FF"
	options:
		time:0.1
		curve:Bezier.easeOut

animate2=new Animation bigcircle4,
	scale:1.5
	backgroundColor: "#0055FF"
	options:
		time:0.1
		curve:Bezier.easeOut


animate3=new Animation track,
	opacity:0.5
	backgroundColor:"#0055FF"
	options:
		time:0.1
		curve:Bezier.easeOut


animate4=new Animation bigcircle4,
	opacity:0
	options:
		time:0.1
		curve:Bezier.easeOut


animate5=animate1.reverse()
animate6=animate3.reverse()

animate7=new Animation bigcircle4,
	scale:1.5
	options:
		time:0.1
		curve:Bezier.easeOut


animate1.onAnimationStart ->
	animate2.start()
	animate3.start()


Utils.delay 1,->
	animate1.start()


Utils.delay 1.2,->
	animate4.start()


Utils.delay 2.2,->
	bigcircle4.scale=1
	bigcircle4.opacity=0.1
	bigcircle4.backgroundColor="#BDBDBD"
	animate5.start()
	animate6.start()
	animate7.start()


Utils.delay 2.3,->
	animate4.start()





