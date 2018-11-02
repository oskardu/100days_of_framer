# dribble:https://dribbble.com/chuanhudu
# uplabs:https://www.uplabs.com/oskar
# github:https://github.com/oskardu
# wechat:kcufuoyd


animationTime1=0.05
animationTime2=0.05
searchFadeTime=0.2
spinnerTime=0.3

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
# 	print scroll.scrollY
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
		curve:Bezier.easeOut

animationFollowingExploreUser2=animationFollowingExploreUser.reverse()



animationScroll=new Animation scroll,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationScroll2=animationScroll.reverse()



animationSearcIcon=new Animation search_icon3,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearcIcon2=animationSearcIcon.reverse()


# 搜索
animationSearchText=new Animation search_text3,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchText2=animationSearchText.reverse()


# 搜索2
animationSearchText3=new Animation search_text3_2,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchText4=new Animation search_text3_2,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut



# 搜索框宽度
animationSearch=new Animation search3,
	width:297
	animationOptions=
		time:searchFadeTime

animationSearch2=animationSearch.reverse()


# cursor
animationSearch_cursor=new Animation search_cursor,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearch_cursor2=animationSearch_cursor.reverse()



# 取消按钮
animationSearchCancel=new Animation search_cancel,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchCancel2=animationSearchCancel.reverse()

animationSearchCancel_2=new Animation search_cancel_2,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchCancel_2_2=animationSearchCancel_2.reverse()

# 最近搜索&热门搜索动效
animationRecentSearch=new Animation recentSearch_hot,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationRecentSearch2=animationRecentSearch.reverse()




animationFollowingExploreUser.onAnimationStart ->
	animationScroll.start()
	animationSearcIcon.start()
	animationSearchText.start()
	animationSearch.start()
	animationSearchCancel.start()
	animationRecentSearch.start()
	animationSearchText3.start()
	animationSearch_cursor.start()

animationFollowingExploreUser2.onAnimationStart ->
	animationScroll2.start()
	animationSearcIcon2.start()
	animationSearchText2.start()
	animationSearch2.start()
	animationSearchCancel2.start()
	animationRecentSearch2.start()
	animationSearchText4.start()
	animationSearch_cursor2.start()


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
	recommendSearch01.opacity=0
	recommendSearch02.opacity=0
	recommendSearch03.opacity=0
# 	te.opacity=0
# 	si.opacity=0
# 	la.opacity=0

	search_cancel_2.ignoreEvents=true
	search_cancel4.ignoreEvents=true
	search4.ignoreEvents=true

	scroll.sendToBack()






# 点击「取消」按钮
search_cancel.onTap ->
	animationFollowingExploreUser2.start()
	animationKeyboard2.start()
	scroll.scrollVertical=true
	animationFollowingExploreUser2.onAnimationEnd ->
		search.opacity=1
		search3.opacity=0
# 	search_cursor.x=13

	search_cancel_2.ignoreEvents=true

	animationHotSearch2.start()
	hotSearch.opacity=1

	recommendSearch01.opacity=0
	recommendSearch02.opacity=0
	recommendSearch03.opacity=0
	recommendSearch03_2.opacity=0
	animationRecommendSearch03_2_2.start()
	te.opacity=0
	si.opacity=0
	la.opacity=0



	searchResults.sendToBack()

	recentSearch_hot2.opacity=0

	search.onTap ->
		search_cursor.x=13

# 	bottom.animate "show"

# cursor闪烁动画
animationSearch_cursor3=new Animation search_cursor,
	opacity:0
	animationOptions=
		time:0.2
		delay:0.4
		curve:Bezier.easeOut


animationSearch_cursor4=new Animation search_cursor,
	opacity:1
	animationOptions=
		time:0.2
		delay:0.4
		curve:Bezier.easeOut


animationSearch_cursor3.onAnimationEnd ->
	animationSearch_cursor4.start()

animationSearch_cursor4.onAnimationEnd ->
	animationSearch_cursor3.start()

animationSearch_cursor.onAnimationEnd ->
	animationSearch_cursor3.start()




# 点击清空按钮清除「最近搜索」
animationHotSearch=new Animation hotSearch,
	y:2
	animationOptions=
		time:0.15
		curve:Bezier.easeOut

animationHotSearch2=animationHotSearch.reverse()


animationRecentSearch3=new Animation rencentSearch,
	opacity:0
	animationOptions=
		time:0.15
		curve:Bezier.easeOut

animationRecentSearch4=animationRecentSearch3.reverse()


animationRecentSearch3.onAnimationEnd ->
	animationHotSearch.start()

animationHotSearch2.onAnimationEnd ->
	animationRecentSearch4.start()

clear_icon.onTap ->
	animationRecentSearch3.start()
	recentSearch_hot2.opacity=0


# 搜索过程中即时推荐搜索
animationHotSearch.onAnimationEnd ->
	Utils.delay 1, ->
		te.opacity=1
# 		animationSearch_cursor3.stop()
# 		animationSearch_cursor4.stop()
# 		search_cursor.opacity=0
		search_text3_2.opacity=0
		hotSearch.opacity=0
		recommendSearch01.opacity=1
		search_cursor.x=35


	Utils.delay 1.2, ->
		si.opacity=1
		recommendSearch01.opacity=0
		recommendSearch02.opacity=1
		search_cursor.x=51


	Utils.delay 1.4, ->
		la.opacity=1
		recommendSearch01.opacity=0
		recommendSearch02.opacity=0
		recommendSearch03.opacity=1
		search_cursor.x=67



# # spinner动画
# animationCicle1=new Animation circle1,
# 	point:path1
# 	animationOptions=
# 		time:spinnerTime
# # 		delay:0.2
# 		curve:Spring(1)
# 
# animationCicle2=new Animation circle2,
# 	x:0
# 	animationOptions=
# 		time:spinnerTime
# 		curve:Spring(1)
# 
# 
# animationCicle1_2=new Animation circle1,
# 	point:path2
# 	animationOptions=
# 		time:spinnerTime
# # 		delay:0.2
# 		curve:Spring(1)
# 
# animationCicle3=new Animation circle3,
# 	x:24
# 	animationOptions=
# 		time:spinnerTime
# 		curve:Spring(1)
# 
# animationCicle1.onAnimationStart ->
# 	animationCicle2.start()
# 
# animationCicle1_2.onAnimationStart ->
# 	animationCicle3.start()
# 
# animationCicle1.onAnimationEnd ->
# 	animationCicle1_2.start()
# 
# animationCicle1_2.onAnimationEnd ->
# 	circle1.x=0
# 	circle2.x=24
# 	circle3.x=48
# 	animationCicle1.start()


# spinner2动画
animationSpinner2=new Animation spinner2,
	rotation:360*10
	animationOptions=
		time:10
		repeat:200
		curve:Bezier.linear








# 点击键盘中的「搜索」按钮
search_button.onTapStart ->
	search_button.backgroundColor="white"
	search_button_text.color="black"

search_button.onTapEnd ->
	search_button.backgroundColor="#3478F6"
	search_button_text.color="white"


animationSearch3=new Animation search3,
	x:48
	animationOptions=
		time:0.2
		curve:Bezier.easeOut

animationSearch3_2=animationSearch3.reverse()




animationRecentSearch_hot=new Animation recentSearch_hot,
	x:-332
	animationOptions=
		time:0.2
		curve:Bezier.easeIn

animationRecentSearch_hot2=animationRecentSearch_hot.reverse()



animationRecommendSearch03=new Animation recommendSearch03,
	x:-129
	animationOptions=
		time:0.3
		curve:Bezier.easeOut

animationRecommendSearch03_2=new Animation recommendSearch03,
	x:20
	animationOptions=
		time:0.3
		curve:Bezier.easeOut


# 搜索结果页再次进入输入搜索项，然后点击取消，此时再点击返回按钮时。搜索推荐内容进入画面
animationRecommendSearch03_2_1=new Animation recommendSearch03_2,
	x:20
	animationOptions=
		time:0.3
		curve:Bezier.easeOut

animationRecommendSearch03_2_2=new Animation recommendSearch03_2,
	x:-129
	animationOptions=
		time:0.3
		curve:Bezier.easeOut

animationSearchBack=new Animation search_back,
	opacity:1
	animationOptions=
		time:0.2
		curve:Bezier.easeOut

animationSearchBack2=animationSearchBack.reverse()


animationSearch3.onAnimationStart ->
	animationRecentSearch_hot.start()
	animationSearchBack.start()
	animationRecommendSearch03.start()



animationSearch3_2.onAnimationStart ->
	animationRecentSearch_hot2.start()
	animationSearchBack2.start()
	animationRecommendSearch03_2.start()


# 搜索结果从上往下进入画面
animationSearchResults=new Animation searchResults,
	y:104
	animationOptions=
		time:0.2
		curve:Bezier.easeOut

# 搜索结果向右飞出去
animationSearchResults2=new Animation searchResults,
	x:375
	opacity: 0
	animationOptions=
		time:0.3
		curve:Bezier.easeOut



searchResults.sendToBack()

animationHotSearch.onAnimationEnd ->
	Utils.delay 1.4, ->
		search_button.onTap ->
		# 	spinner.opacity=1
		# 	animationCicle1.start()
			spinner2.opacity=1
			animationSpinner2.restart()
			animationSearch3.start()
			animationSearchCancel2.start()
			animationKeyboard2.start()
			bottom.animate "hide"
			search_cursor.x=13
			search_cursor.opacity=0
			animationSearch_cursor3.stop()
			animationSearch_cursor4.stop()
		
		
			Utils.delay 1, ->
				spinner2.opacity=0
				searchResults.opacity=1
				searchResults.x=16
				searchResults.y=53
				animationSearchResults.start()
				for item in [rec1,rec2,rec3,rec4,rec5,rec6,rec7,rec8]
					item.animate
						opacity: 0
						options: 
							time: 0.4
							curve: Bezier.easeOut
				for item in [headPhoto1,headPhoto2,headPhoto3,headPhoto4,headPhoto5,headPhoto6,headPhoto7,headPhoto8,headPhoto9]
					item.animate
						opacity: 0
						options: 
							time: 0.1
							curve: Bezier.easeOut


# 搜索结果返回页面
search_back.onTap ->
	spinner2.opacity=0
	animationSearch3_2.start()
	animationSearchCancel.start()
	animationSearchResults2.start()
	animationKeyboard.start()
	animationSearch_cursor.start()
	search_cursor.x=67

	recommendSearch03_2.opacity=1
	animationRecommendSearch03_2_1.start()

	search_cancel_2.ignoreEvents=true


scroll2=new ScrollComponent
	width: searchResults.width
	height: 759-50
	parent: searchResults
	scrollHorizontal: false

scroll2.sendToBack()
results_content.parent=scroll2.content



# 搜索结果出来之后再次点击搜索框
animationSearchResults.onAnimationEnd ->
	search.onTap ->
		spinner2.opacity=0
		animationSearch3_2.start()
		animationSearchCancel.start()
		animationKeyboard.start()
		animationSearch_cursor.start()
		search_cursor.x=67


		search_cancel_2.ignoreEvents=false


		searchResults.animate
			opacity: 0
			options: 
				time: 0.2
				curve: Bezier.easeOut

		recentSearch_hot2.animate
			opacity: 1
			options: 
				time: 0.3
				curve: Bezier.easeOut


	search_cancel_2.onTap ->
		spinner2.opacity=0
		animationSearch3.start()
		animationSearchCancel2.start()
		animationSearchCancel_2_2.start()
		animationKeyboard2.start()
		animationSearch_cursor3.stop()
		animationSearch_cursor4.stop()
		search_cursor.opacity=0
# 		search_cursor.x=67

		search_cancel_2.ignoreEvents=true

		searchResults.animate
			opacity: 1
			options: 
				time: 0.2
				curve: Bezier.easeOut

		recentSearch_hot2.animate
			opacity: 0
			options: 
				time: 0.1
				curve: Bezier.easeOut




# 点击圆形搜索
animationSearch4_1=new Animation search4,
	width:297
	x: 20
	animationOptions=
		time:0.2
		curve:Bezier.easeOut

animationSearch4_2=new Animation search4,
	width:40
	x: 315
	animationOptions=
		time:0.2
		curve:Bezier.easeOut

animationSearcIcon4_1=new Animation search_icon4,
	opacity:0
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearcIcon4_2=animationSearcIcon4_1.reverse()


animationSearchText4_1=new Animation search_text4,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchText4_2=animationSearchText4_1.reverse()


animationSearchCancel4_1=new Animation search_cancel4,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearchCancel4_2=animationSearchCancel4_1.reverse()



# cursor4闪烁动画
animationSearch_cursor4_1=new Animation search_cursor4,
	opacity:0
	animationOptions=
		time:0.2
		delay:0.4
		curve:Bezier.easeOut


animationSearch_cursor4_2=new Animation search_cursor4,
	opacity:1
	animationOptions=
		time:0.2
		delay:0.4
		curve:Bezier.easeOut


animationSearch_cursor4_3=new Animation search_cursor4,
	opacity:1
	animationOptions=
		time:searchFadeTime
		curve:Bezier.easeOut

animationSearch_cursor4_1.onAnimationEnd ->
	animationSearch_cursor4_2.start()

animationSearch_cursor4_2.onAnimationEnd ->
	animationSearch_cursor4_1.start()

animationSearch_cursor4_3.onAnimationEnd ->
	animationSearch_cursor4_1.start()

search4.onTap ->
	animationSearch4_1.start()
	animationSearcIcon4_1.start()
	animationSearchText4_1.start()
	animationSearch_cursor4_3.start()
	animationSearchCancel4_1.start()
	animationKeyboard.start()
	animationFollowingExploreUser.start()

	search_cancel4.ignoreEvents=false

	search.opacity=0

search_cancel4.onTap ->
	animationSearch4_2.start()
	animationSearcIcon4_2.start()
	animationSearchText4_2.start()
	animationSearchCancel4_2.start()
	animationSearch_cursor4_1.stop()
	animationSearch_cursor4_2.stop()
	search_cursor4.opacity=0
	animationKeyboard2.start()
	animationFollowingExploreUser2.start()

	search.opacity=1

# 	bottom.animate "show"



animationA.onAnimationEnd ->
	search4.opacity=1


animationA_2.onAnimationStart ->
	search4.opacity=0


