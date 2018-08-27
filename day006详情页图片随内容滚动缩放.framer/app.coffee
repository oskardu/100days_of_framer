scroll=new ScrollComponent
	size: Screen.size
	scrollHorizontal: false

content.parent=scroll.content

# 滚动组件滚动时背景图的变化
scroll.onMove ->
	scrollY=scroll.scrollY                              # 将滚动值赋值给scrollY。向下滚动，scrollY小于0，向上则大于0
	contentY=Utils.modulate(scrollY,[0,633],[0,-211])   # scrollY在[0,633]内变动时，对应一个在[0,-211]内的值，将此值赋值给contentY
	if scrollY<0                                        # 若scrollY<0,改变背景图的缩放值
		bg.scale=1-(scrollY/100)
	if scrollY>0                                        # 若scrollY>0,改变背景图的位置
		bg.y=contentY



