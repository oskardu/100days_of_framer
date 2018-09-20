# 创建新滚动组件
scroll=new ScrollComponent
	size: Screen.size
	parent: frame01
	scrollHorizontal: false
	contentInset: 
		top: 40

# 将scrollComponent置于底层
scroll.sendToBack()

# 将卡片内容放入scrollComponent
cards.parent=scroll.content

helper.props=
	rotationX:10
	maxY:scroll.screenFrame.y




scroll.onMove ->
	rotateX=Utils.modulate(scroll.scrollY,[0,-54],[90,0],true)
	gapTop=Utils.modulate(scroll.scrollY,[0,-54],[40,0],true)
	op=Utils.modulate(scroll.scrollY,[0,-54],[0.5,1],true)
	print scroll.scrollY

	helper.props=
		rotationX:rotateX
		maxY:scroll.content.screenFrame.y+gapTop
