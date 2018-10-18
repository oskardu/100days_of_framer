
scroll=new ScrollComponent
	parent: home
	size: Screen.size
	scrollHorizontal: false
	contentInset: 
		top: search.maxY+63


scroll.sendToBack()

animationTime1=0.05
animationTime2=0.05

content.parent=scroll.content


# # 方案一：跟随滑动位置变动
# scroll.onMove ->
# #	print scroll.scrollY
# 	search.width=Utils.modulate(scroll.scrollY,[0,40],[335,40],true)
# 	search_icon.x=Utils.modulate(scroll.scrollY,[0,40],[16,10],true)
# 	search_text.opacity=Utils.modulate(scroll.scrollY,[0,30],[1,0],true)
# 	following_explore_user.x=Utils.modulate(scroll.scrollY,[20,40],[105,20],true)
# 	following_explore_user.y=Utils.modulate(scroll.scrollY,[20,40],[100,53],true)


# 方案二：当内容滚动到某一个点时开始渐变动画
# 搜索框背景动画
animationA=new Animation search,
	width:40
	options:
		time:animationTime1
		curve:Bezier.easeOut

animationA_2=animationA.reverse()



# 搜索图标动画
animationB=new Animation search_icon,
	x:10
	options:
		time:animationTime1
		curve:Bezier.easeOut

animationB_2=animationB.reverse()



# 搜索提示文本动画
animationC=new Animation search_text,
	opacity:0
	options:
		time:0.001
		curve:Bezier.easeOut

animationC_2=animationC.reverse()


# 关注&发现&讲者的动画
animationD=new Animation following_explore_user,
	x:20
	y: 53
	options:
		time:animationTime2
		curve:Bezier.easeOut

animationD_2=animationD.reverse()



scroll.onMove ->
#	print scroll.scrollY
	if scroll.scrollY>20
		animationA.start()
		animationB.start()
		animationC.start()
		animationD.start()
	if scroll.scrollY<20
		animationA_2.start()
		animationB_2.start()
		animationC_2.start()
		animationD_2.start()

# # 方案三：旧的消失，新的出现
# scroll.onMove ->
# 	following_explore_user.opacity=Utils.modulate(scroll.scrollY,[20,24],[1,0],true)
# 	search.opacity=Utils.modulate(scroll.scrollY,[20,24],[1,0],true)
# 	following_explore_user2.opacity=Utils.modulate(scroll.scrollY,[20,24],[0,1],true)
# 	search2.opacity=Utils.modulate(scroll.scrollY,[20,24],[0,1],true)



bottom.states.add
	hide:
		y:812
		animationOptions:
			time:0.1
	show:
		y:729
		animationOptions:
			time:0.1


scroll.onScroll ->
	if scroll.direction is "down"
		bottom.animate "hide"
	if scroll.direction is "up"
		bottom.animate "show"



