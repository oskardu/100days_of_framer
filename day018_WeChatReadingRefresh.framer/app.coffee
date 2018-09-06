scroll=new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	parent: frame1                # 使其父级为frame1
	contentInset:                 # 滚动内容到滚动框的距离
		top: 58


content.parent=scroll.content     # 将content加入滚动框


scroll.sendToBack()               # 使滚动内容置于header和footer下层


book_icon.sendToBack()            # 使book_icon置于滚动内容的下层
book_icon2.sendToBack()           # 使book_icon2置于最下层


# 创建content1的两个状态，刷新成功后切换
content1.states.show=
	opacity: 1
	animationOptions:
		time:0.01
content1.states.hide=
	opacity: 0
	animationOptions:
		time:0.01


# 使book_icon内的线的初始宽度为0
for rectangle in [rectangle1,rectangle2,rectangle3,rectangle4,rectangle5,rectangle6]
	rectangle.width=0

# 加载动画第一阶段,以3-2-1-6-5-4的顺序进行动画。
animation2_3=new Animation rectangle2_3,
	width:0
	x: 16
	options:
		time:0.5
		curve:Bezier.ease

animation2_2=new Animation rectangle2_2,
	width:0
	x: 16
	options:
		delay:0.05
		time:0.5
		curve:Bezier.ease

animation2_1=new Animation rectangle2_1,
	width:0
	x: 16
	options:
		delay:0.1
		time:0.5
		curve:Bezier.ease

animation2_6=new Animation rectangle2_6,
	width:0
	x: 37
	options:
		delay:0.15
		time:0.5
		curve:Bezier.ease

animation2_5=new Animation rectangle2_5,
	width:0
	x: 37
	options:
		delay:0.2
		time:0.5
		curve:Bezier.ease

animation2_4=new Animation rectangle2_4,
	width:0
	x: 37
	options:
		delay:0.25
		time:0.5
		curve:Bezier.ease


# 加载动画第二阶段，以1-2-3-4-5-6的顺序进行动画
animation2_1_1=new Animation rectangle2_1,
	width:10
	options:
		time:0.5
		curve:Bezier.ease

animation2_2_1=new Animation rectangle2_2,
	width:10
	options:
		delay:0.05
		time:0.5
		curve:Bezier.ease

animation2_3_1=new Animation rectangle2_3,
	width:10
	options:
		delay:0.1
		time:0.5
		curve:Bezier.ease

animation2_4_1=new Animation rectangle2_4,
	width:10
	options:
		delay:0.15
		time:0.5
		curve:Bezier.ease

animation2_5_1=new Animation rectangle2_5,
	width:10
	options:
		delay:0.2
		time:0.5
		curve:Bezier.ease

animation2_6_1=new Animation rectangle2_6,
	width:10
	options:
		delay:0.25
		time:0.5
		curve:Bezier.ease


# animation2_3开始时，其他线的动画也开始
animation2_3.onAnimationStart ->
	animation2_2.start()
	animation2_1.start()
	animation2_6.start()
	animation2_5.start()
	animation2_4.start()


# animation2_1_1开始时，其他线的动画也开始
animation2_1_1.onAnimationStart ->
	animation2_2_1.start()
	animation2_3_1.start()
	animation2_4_1.start()
	animation2_5_1.start()
	animation2_6_1.start()


# 加载动画第一阶段结束后，使线的位置回到初始值，以便第二阶段的动画不会错位（因为线在设计模式中设置的pin为left）
animation2_4.onAnimationEnd ->
	rectangle2_3.x=6
	rectangle2_2.x=6
	rectangle2_1.x=6
	rectangle2_6.x=27
	rectangle2_5.x=27
	rectangle2_4.x=27
	animation2_1_1.start()



# 当滚动内容超过112，松手后使其回到固定位置的动画
animationA=new Animation content,
	y: 58
	options:
		time:0.3
		curve:Bezier.ease

# 加载动画结束后，滚动内容回到初始位置
animationB=new Animation content,
	y:0
	options:
		time:0.1
		curve:Bezier.ease


# 滚动时，book_icon位置改变，其中线的宽度改变。limit为true，只在限定范围内改变位置和宽度。
scroll.onMove ->
#	print scroll.content.y
#	print book_icon.y
	book_icon.y=Utils.modulate(scroll.content.y,[58,112],[15,69],true)
	rectangle1.width=Utils.modulate(scroll.content.y,[102,104],[0,10],true)
	rectangle2.width=Utils.modulate(scroll.content.y,[103,105],[0,10],true)
	rectangle3.width=Utils.modulate(scroll.content.y,[104,106],[0,10],true)
	rectangle4.width=Utils.modulate(scroll.content.y,[105,107],[0,10],true)
	rectangle5.width=Utils.modulate(scroll.content.y,[106,108],[0,10],true)
	rectangle6.width=Utils.modulate(scroll.content.y,[107,109],[0,10],true)

	if scroll.content.y>112
		book_icon.opacity=0
		book_icon2.opacity=1
		animationA.start()

# 滚动内容回到固定位置后，加载动画才开始
animationA.onAnimationEnd ->
	animation2_3.start()

# 加载动画结束后，book_icon和book_icon2恢复初始状态，显示新内容，滚动内容回到原位置
animation2_6_1.onAnimationEnd ->
	book_icon.opacity=1
	book_icon2.opacity=0
	content1.stateCycle("show","hide")
	animationB.start()







