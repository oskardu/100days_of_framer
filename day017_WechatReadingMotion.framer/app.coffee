# 微信读书的效果 by OskarDu
# https://dribbble.com/chuanhudu
# https://github.com/oskardu



# 第一行卡片的循环滚动

# 首尾卡片的位置赋值给frame1_0和frame1_6
frame1_0=row1_0.frame
frame1_6=row1_6.frame



# 创建第一轮滚动动画
animation1_1=new Animation row1_1,
	frame:frame1_6
	options:
		time:40
		curve:Bezier.linear


animation1_2=new Animation row1_2,
	frame:frame1_6
	options:
		time:32
		curve:Bezier.linear


animation1_3=new Animation row1_3,
	frame:frame1_6
	options:
		time:24
		curve:Bezier.linear


animation1_4=new Animation row1_4,
	frame:frame1_6
	options:
		time:16
		curve:Bezier.linear


animation1_5=new Animation row1_5,
	frame:frame1_6
	options:
		time:8
		curve:Bezier.linear


animation1_6=new Animation row1_6,
	x: frame1_6.x+1
	y: frame1_6.y
	options:
		time:0.08
		curve:Bezier.linear



# 创建第二轮以及以后的动画
animation1_1_1=new Animation row1_1,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear


animation1_1_2=new Animation row1_2,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear


animation1_1_3=new Animation row1_3,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear


animation1_1_4=new Animation row1_4,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear


animation1_1_5=new Animation row1_5,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear


animation1_1_6=new Animation row1_6,
	frame:frame1_6
	options:
		time:48
		curve:Bezier.linear



# 第一轮动画开始
animation1_1.start()
animation1_2.start()
animation1_3.start()
animation1_4.start()
animation1_5.start()
animation1_6.start()






# 第一轮动画结束后，开始之后轮
animation1_1.onAnimationEnd ->
	row1_1.frame=frame1_0
	animation1_1_1.start()

animation1_2.onAnimationEnd ->
	row1_2.frame=frame1_0
	animation1_1_2.start()

animation1_3.onAnimationEnd ->
	row1_3.frame=frame1_0
	animation1_1_3.start()

animation1_4.onAnimationEnd ->
	row1_4.frame=frame1_0
	animation1_1_4.start()

animation1_5.onAnimationEnd ->
	row1_5.frame=frame1_0
	animation1_1_5.start()

animation1_6.onAnimationEnd ->
	row1_6.frame=frame1_0
	animation1_1_6.start()




# 开始循环
animation1_1_1.onAnimationEnd ->
	row1_1.frame=frame1_0
	animation1_1_1.start()


animation1_1_2.onAnimationEnd ->
	row1_2.frame=frame1_0
	animation1_1_2.start()

animation1_1_3.onAnimationEnd ->
	row1_3.frame=frame1_0
	animation1_1_3.start()


animation1_1_4.onAnimationEnd ->
	row1_4.frame=frame1_0
	animation1_1_4.start()


animation1_1_5.onAnimationEnd ->
	row1_5.frame=frame1_0
	animation1_1_5.start()


animation1_1_6.onAnimationEnd ->
	row1_6.frame=frame1_0
	animation1_1_6.start()























# 第二行卡片的循环滚动

# 首尾卡片的位置赋值给frame1_0和frame1_6
frame2_0=row2_0.frame
frame2_6=row2_6.frame



# 创建第一轮滚动动画
animation2_1=new Animation row2_1,
	frame:frame2_6
	options:
		time:40
		curve:Bezier.linear


animation2_2=new Animation row2_2,
	frame:frame2_6
	options:
		time:32
		curve:Bezier.linear


animation2_3=new Animation row2_3,
	frame:frame2_6
	options:
		time:24
		curve:Bezier.linear


animation2_4=new Animation row2_4,
	frame:frame2_6
	options:
		time:16
		curve:Bezier.linear


animation2_5=new Animation row2_5,
	frame:frame2_6
	options:
		time:8
		curve:Bezier.linear


animation2_6=new Animation row2_6,
	x: frame2_6.x+1
	y: frame2_6.y
	options:
		time:0.08
		curve:Bezier.linear



# 创建第二轮以及以后的动画
animation2_1_1=new Animation row2_1,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear


animation2_1_2=new Animation row2_2,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear


animation2_1_3=new Animation row2_3,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear


animation2_1_4=new Animation row2_4,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear


animation2_1_5=new Animation row2_5,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear


animation2_1_6=new Animation row2_6,
	frame:frame2_6
	options:
		time:48
		curve:Bezier.linear



# 第一轮动画开始
animation2_1.start()
animation2_2.start()
animation2_3.start()
animation2_4.start()
animation2_5.start()
animation2_6.start()






# 第一轮动画结束后，开始之后轮
animation2_1.onAnimationEnd ->
	row2_1.frame=frame2_0
	animation2_1_1.start()

animation2_2.onAnimationEnd ->
	row2_2.frame=frame2_0
	animation2_1_2.start()

animation2_3.onAnimationEnd ->
	row2_3.frame=frame2_0
	animation2_1_3.start()

animation2_4.onAnimationEnd ->
	row2_4.frame=frame2_0
	animation2_1_4.start()

animation2_5.onAnimationEnd ->
	row2_5.frame=frame2_0
	animation2_1_5.start()

animation2_6.onAnimationEnd ->
	row2_6.frame=frame2_0
	animation2_1_6.start()




# 开始循环
animation2_1_1.onAnimationEnd ->
	row2_1.frame=frame2_0
	animation2_1_1.start()


animation2_1_2.onAnimationEnd ->
	row2_2.frame=frame2_0
	animation2_1_2.start()

animation2_1_3.onAnimationEnd ->
	row2_3.frame=frame2_0
	animation2_1_3.start()


animation2_1_4.onAnimationEnd ->
	row2_4.frame=frame2_0
	animation2_1_4.start()


animation2_1_5.onAnimationEnd ->
	row2_5.frame=frame2_0
	animation2_1_5.start()


animation2_1_6.onAnimationEnd ->
	row2_6.frame=frame2_0
	animation2_1_6.start()

# 第三行卡片的循环滚动

# 首尾卡片的位置赋值给frame1_0和frame1_6
frame3_0=row3_0.frame
frame3_6=row3_6.frame



# 创建第一轮滚动动画
animation3_1=new Animation row3_1,
	frame:frame3_6
	options:
		time:40
		curve:Bezier.linear


animation3_2=new Animation row3_2,
	frame:frame3_6
	options:
		time:32
		curve:Bezier.linear


animation3_3=new Animation row3_3,
	frame:frame3_6
	options:
		time:24
		curve:Bezier.linear


animation3_4=new Animation row3_4,
	frame:frame3_6
	options:
		time:16
		curve:Bezier.linear


animation3_5=new Animation row3_5,
	frame:frame3_6
	options:
		time:8
		curve:Bezier.linear


animation3_6=new Animation row3_6,
	x: frame3_6.x+1
	y: frame3_6.y
	options:
		time:0.08
		curve:Bezier.linear



# 创建第二轮以及以后的动画
animation3_1_1=new Animation row3_1,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear


animation3_1_2=new Animation row3_2,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear


animation3_1_3=new Animation row3_3,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear


animation3_1_4=new Animation row3_4,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear


animation3_1_5=new Animation row3_5,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear


animation3_1_6=new Animation row3_6,
	frame:frame3_6
	options:
		time:48
		curve:Bezier.linear



# 第一轮动画开始
animation3_1.start()
animation3_2.start()
animation3_3.start()
animation3_4.start()
animation3_5.start()
animation3_6.start()






# 第一轮动画结束后，开始之后轮
animation3_1.onAnimationEnd ->
	row3_1.frame=frame3_0
	animation3_1_1.start()

animation3_2.onAnimationEnd ->
	row3_2.frame=frame3_0
	animation3_1_2.start()

animation3_3.onAnimationEnd ->
	row3_3.frame=frame3_0
	animation3_1_3.start()

animation3_4.onAnimationEnd ->
	row3_4.frame=frame3_0
	animation3_1_4.start()

animation3_5.onAnimationEnd ->
	row3_5.frame=frame3_0
	animation3_1_5.start()

animation3_6.onAnimationEnd ->
	row3_6.frame=frame3_0
	animation3_1_6.start()




# 开始循环
animation3_1_1.onAnimationEnd ->
	row3_1.frame=frame3_0
	animation3_1_1.start()


animation3_1_2.onAnimationEnd ->
	row3_2.frame=frame3_0
	animation3_1_2.start()

animation3_1_3.onAnimationEnd ->
	row3_3.frame=frame3_0
	animation3_1_3.start()


animation3_1_4.onAnimationEnd ->
	row3_4.frame=frame3_0
	animation3_1_4.start()


animation3_1_5.onAnimationEnd ->
	row3_5.frame=frame3_0
	animation3_1_5.start()


animation3_1_6.onAnimationEnd ->
	row3_6.frame=frame3_0
	animation3_1_6.start()

# 创建pageComponent，使其大小位置和page2一致
page=new PageComponent
	frame: page2.frame
	scrollVertical: false

# page不做遮罩，page框架外的内容也显示
page.clip=false


# 将几个page添加进pageComponent
page.addPage(page0)
page.addPage(page1)
page.addPage(page2)
page.addPage(page3)
page.addPage(page4)

# 立即切换到page2（本周推荐页），animate:false，不带动画直接切换
page.snapToPage(page2,false)















