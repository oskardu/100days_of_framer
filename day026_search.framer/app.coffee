# dribble:https://dribbble.com/chuanhudu
# uplabs:https://www.uplabs.com/oskar
# github:https://github.com/oskardu
# wechat:kcufuoyd

animationTime1=0.05
animationTime2=0.05
searchFadeTime=0.1

scroll=new ScrollComponent
	parent: home
	size: Screen.size
	scrollHorizontal: false
	contentInset: 
		top: search.maxY+63


scroll.sendToBack()

content.parent=scroll.content


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
		animationA.onAnimationEnd ->
	if scroll.scrollY<20
		animationA_2.start()
		animationB_2.start()
		animationC_2.start()
		animationD_2.start()
		animationA_2.onAnimationEnd ->




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



# 点击长条搜索按钮时
animationFollowingExploreUser=new Animation following_explore_user,
	opacity:0
	animationOptions=
		time:searchFadeTime

animationFollowingExploreUser2=animationFollowingExploreUser.reverse()



animationScroll=new Animation scroll,
	opacity:0
	animationOptions=
		time:searchFadeTime

animationScroll2=animationScroll.reverse()



animationSearcIcon=new Animation search_icon3,
	opacity:0
	animationOptions=
		time:searchFadeTime

animationSearcIcon2=animationSearcIcon.reverse()


# 搜索
animationSearchText=new Animation search_text3,
	opacity:0
	animationOptions=
		time:searchFadeTime

animationSearchText2=animationSearchText.reverse()


# 搜索2
animationSearchText3=new Animation search_text3_2,
	opacity:1
	animationOptions=
		time:searchFadeTime

animationSearchText4=new Animation search_text3_2,
	opacity:0
	animationOptions=
		time:searchFadeTime




# 搜索框宽度
animationSearch=new Animation search3,
	width:297
	animationOptions=
		time:searchFadeTime

animationSearch2=animationSearch.reverse()



# 取消按钮
animationSearchCancel=new Animation search_cancel,
	opacity:1
	animationOptions=
		time:searchFadeTime

animationSearchCancel2=animationSearchCancel.reverse()



# 最近搜索&热门搜索动效
animationRecentSearch=new Animation recentSearch_hot,
	opacity:1
	animationOptions=
		time:searchFadeTime

animationRecentSearch2=animationRecentSearch.reverse()




animationFollowingExploreUser.onAnimationStart ->
	animationScroll.start()
	animationSearcIcon.start()
	animationSearchText.start()
	animationSearch.start()
	animationSearchCancel.start()
	animationRecentSearch.start()
	animationSearchText3.start()


animationFollowingExploreUser2.onAnimationStart ->
	animationScroll2.start()
	animationSearcIcon2.start()
	animationSearchText2.start()
	animationSearch2.start()
	animationSearchCancel2.start()
	animationRecentSearch2.start()
	animationSearchText4.start()


# 弹出键盘
animationKeyboard=new Animation keyboard,
	y:479
	animationOptions=
		time:0.3

animationKeyboard2=animationKeyboard.reverse()




search.onTap ->
	animationFollowingExploreUser.start()
	animationKeyboard.start()
	scroll.scrollVertical=false
	search.opacity=0
	search3.opacity=1



search_cancel.onTap ->
	animationFollowingExploreUser2.start()
	animationKeyboard2.start()
	scroll.scrollVertical=true
	animationFollowingExploreUser2.onAnimationEnd ->
		search.opacity=1
		search3.opacity=0




# cursor闪烁动画




















