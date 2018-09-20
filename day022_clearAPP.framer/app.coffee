# 创建新滚动组件
scroll=new ScrollComponent
	size: Screen.size
	parent: frame01
	scrollHorizontal: false
	contentInset: 
		top: 40

# 将scrollComponent置于底层
scroll.sendToBack()
helper.sendToBack()

# 将卡片内容放入scrollComponent
cards.parent=scroll.content

helper.props=
#	rotationX:10
	maxY:scroll.screenFrame.y
#	scale:0.95




scroll.onMove ->
	rotateX=Utils.modulate(scroll.scrollY,[0,-54],[90,0],true)
	gapTop=Utils.modulate(scroll.scrollY,[0,-54],[28,0],true)
	scaling=Utils.modulate(scroll.scrollY,[0,-54],[0.96,1],true)
	op=Utils.modulate(scroll.scrollY,[0,-54],[0.5,1],true)

#	print helper.maxY
#	print scroll.scrollY
#	print scroll.content.screenFrame.y


	helper.props=
		rotationX:rotateX
		maxY:scroll.content.screenFrame.y+gapTop
#		scale:scaling
		opacity:op



























