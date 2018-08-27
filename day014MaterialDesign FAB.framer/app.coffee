fab.center()

# The floating action button icons switch smoothly while in motion.
pen.opacity=0

# 避免圆缩放时边缘模糊
circle.force2d = true
circle2.force2d=true

# 加号旋转消失动画,旋转45°
animationC=new Animation add,
	opacity:0
	rotation:45
	options:
		time:0.1



# 圆圈扩大动画
animationD=new Animation circle,
	scale:2.8
	backgroundColor: "#0055FF"
	opacity: 1
	options:
		time:0.6


# 「pen」旋转135°
animationE=new Animation pen,
	opacity:1
	rotation:360
	options:
		time:0.3


# animationC开始时，animationD和animationE开始
animationC.onAnimationStart ->
	animationD.start()
	animationE.start()

# 1s后，animationC开始
Utils.delay 1,->
	animationC.start()


# 笔旋转消失，旋转45°
animationF=new Animation pen,
	opacity:0
	rotation:405
	options:
		time:0.1

# add旋转出现
animationG=new Animation add,
	opacity:1
	rotation:180
	options:
		time:0.3

animationH=new Animation circle2,
	scale:2.8
	backgroundColor: "#0055FF"
	opacity: 1
	options:
		time:0.6

animationF.onAnimationStart ->
	animationH.start()
	animationG.start()

Utils.delay 2.6,->
	animationF.start()