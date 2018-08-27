# tweening
bg1.opacity=0

animationA=new Animation elem,
	x: 129
	y: 40
	width: 140
	height: 220
	borderRadius:4
	backgroundColor: "white"
	shadowY: 4
	shadowBlur: 20
	options:
		delay:1
		time: 0.3
		curve: Bezier.easeOut


animationB=animationA.reverse()


bg1.states.show=
	opacity: 0.2


animationA.onAnimationStart ->
	bg1.stateCycle()


animationA.onAnimationEnd ->
	animationB.start()


animationB.onAnimationStart ->
	bg1.stateCycle()

animationB.onAnimationEnd ->
	animationA.start()



animationA.start()
















