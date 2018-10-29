# dribble:https://dribbble.com/chuanhudu
# uplabs:https://www.uplabs.com/oskar
# github:https://github.com/oskardu
# wechat:kcufuoyd



audio= new Audio("sounds/Ashtar%20Command%20-%20Deadman's%20Gun.mp3")
audio2 = new Audio("sounds/Ada%20Ruth%20Habershon,Charles%20Hutchinson%20Gabriel,Courtnee%20Draper%20-%20Will%20the%20Circle%20Be%20Unbroken%20(Full%20version).mp3")

# 控制音乐播放和暂停
pause_icon.onTap ->
	audio.pause()
	play_icon.opacity=1
	pause_icon.opacity=0
	pause_icon.sendToBack()
# 	animationProcessingCircle.stop()
# 	animationProcessingWhite.stop()

play_icon.onTap ->
	audio.play()
	play_icon.opacity=0
	pause_icon.opacity=1
	play_icon.sendToBack()
# 	animationProcessingCircle.start()
# 	animationProcessingWhite.start()


# 点击「喜欢」按钮
like_clicked.scale=0.5

animationLike_clicked=new Animation like_clicked,
	scale:1
	animationOptions=
		time:0.3

animationLike_icon=new Animation like_icon,
	scale:1
	animationOptions=
		time:0.3

like_icon.onTap ->
	like_icon.opacity=0
	like_icon.scale=0.5
	like_clicked.opacity=1
	animationLike_clicked.start()
	like_icon.sendToBack()

like_clicked.onTap ->
	like_clicked.opacity=0
	like_clicked.scale=0.5
	like_icon.opacity=1
	animationLike_icon.start()
	like_clicked.sendToBack()


# 点击评论按钮弹出评论页
animationA=new Animation commentPage,
	y:310
	options:
		time:0.1


animationB=animationA.reverse()

comment_icon.onTap ->
	animationA.start()
	page.scrollHorizontal=false
	for item in [play_icon,backwords_icon,back15,forward15,like_icon,comment_icon,like_icon,speed_button]
		item.ignoreEvents=true

close_icon.onTap ->
	animationB.start()
	page.scrollHorizontal=true
	for item in [play_icon,backwords_icon,back15,forward15,like_icon,comment_icon,like_icon,speed_button]
		item.ignoreEvents=false

# 评论页内容可滑动
scroll=new ScrollComponent
	parent: comment_contentBox
	size: comment_contentBox.size
	scrollHorizontal: false

comment_content.parent=scroll.content





# 点击倍速按钮弹出倍速选择页
animationSpeedPage=new Animation speedPage,
	y:394
	options:
		time:0.1


animationSpeedPage2=animationSpeedPage.reverse()

speed_button.onTap ->
	animationSpeedPage.start()
	arrowDown.rotation=180
	page.scrollHorizontal=false
	for item in [play_icon,backwords_icon,back15,forward15,like_icon,comment_icon,like_icon]
		item.ignoreEvents=true


close_icon3.onTap ->
	animationSpeedPage2.start()
	arrowDown.rotation=0
	page.scrollHorizontal=true
	for item in [play_icon,backwords_icon,back15,forward15,like_icon,comment_icon,like_icon]
		item.ignoreEvents=false


# 点击切换倍速（点击后改变一个属性为「selected」之前把前一个属性还原为「default」）
curText=text3_1
for item in [text1_1,text2_1,text3_1,text4_1,text5_1,text6_1]
	item.states.default=
		color:"rgba(255,255,255,0.5)"
	item.states.selected=
		color:"white"
	item.onTap ->
		curText.stateSwitch("default")
		this.stateSwitch("selected")
		curText=this

curSpeed=speed3
for item in [speed1,speed2,speed3,speed4,speed5,speed6]
	item.states.default=
		backgroundColor:"rgba(255,255,255,0)"
	item.states.selected=
		backgroundColor:"rgba(255,255,255,0.2)"
	item.onTap ->
		curSpeed.stateSwitch("default")
		this.stateSwitch("selected")
		curSpeed=this

# 使text的点击区域（高度）与背景一致
text1_1.lineHeight=3
text2_1.lineHeight=3
text3_1.lineHeight=3
text4_1.lineHeight=3
text5_1.lineHeight=3
text6_1.lineHeight=3

# 变速
speed1.onTap ->
	audio.playbackRate=0.5

speed2.onTap ->
	audio.playbackRate=0.75

speed3.onTap ->
	audio.playbackRate=1

speed4.onTap ->
	audio.playbackRate=1.25

speed5.onTap ->
	audio.playbackRate=1.5

speed6.onTap ->
	audio.playbackRate=1.75












# 点击播放列表弹出
animationListPage=new Animation listPage,
	y:310
	options:
		time:0.1

animationListPage2=animationListPage.reverse()

list_icon.onTap ->
	animationListPage.start()
	page.scrollHorizontal=false
	speed_button.ignoreEvents=true

close_icon2.onTap ->
	animationListPage2.start()
	page.scrollHorizontal=true
	speed_button.ignoreEvents=false

scrollList=new ScrollComponent
	parent: listContent
	size: listContent.size
	scrollHorizontal: false

listContent2.parent=scrollList.content

# 进度滑块
slider=new SliderComponent
	width: 257
	height: 4
	x: 59
	y: 581
	borderRadius: 10
	backgroundColor: "rgba(255,255,255,0.5)"
	min: 0
	max: 255
	parent: bg

slider.fill.backgroundColor="white"

slider.knob.width=20
slider.knob.height=20
slider.knob.shadowColor="rgba(0,0,0,0)"

sliderCircle=new Layer
	parent: slider.knob
	size: 6
	backgroundColor: "#AD2526"
	borderRadius: 10

sliderCircle.center()


slider.on "change:value", ->
#	print this.value
	audio.fastSeek(this.value)
#	text.fontSize=12
	if this.value<9
		text.text="00:0"+ Utils.round(this.value, 0) 
	if this.value>9 and this.value<=59
		text.text="00:"+ Utils.round(this.value, 0) 
	if this.value>59 and this.value<69
		text.text="01:0"+Utils.round(this.value-60, 0)
	if this.value>69 and this.value<=119
		text.text="01:"+Utils.round(this.value-60, 0)
	if this.value>120 and this.value<129
		text.text="02:0"+Utils.round(this.value-120, 0)
	if this.value>129 and this.value<=179
		text.text="02:"+Utils.round(this.value-120, 0)
	if this.value>180 and this.value<189
		text.text="03:0"+Utils.round(this.value-180, 0)
	if this.value>189 and this.value<=239
		text.text="03:"+Utils.round(this.value-180, 0)
	if this.value>240 and this.value<249
		text.text="04:0"+Utils.round(this.value-240, 0)
	if this.value>249 and this.value<=299
		text.text="04:"+Utils.round(this.value-240, 0)


# 快进&快退15秒
forward15.onTap ->
	slider.value=slider.value+15

back15.onTap ->
	slider.value=slider.value-15


slider.value=audio.currentTime

# 切换播放音频
page=new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false
	opacity: 1
	parent: frame01

page.placeBefore(bg2)

page.animationOptions =
	curve: Spring(damping: 100)
	time: 0.3

cover1.parent=page.content
cover2.parent=page.content

cover2.x=cover2.x-97




# 音频title走马灯
animationAudioTitle2_1=new Animation audioTitle2_1,
	x:-476
	animationOptions=
		time:16
		curve:Bezier.linear

animationAudioTitle2_2=new Animation audioTitle2_2,
	x:-476
	animationOptions=
		time:1.73319328*16
		curve:Bezier.linear

animationAudioTitle2_3=new Animation audioTitle2_1,
	x:-476
	animationOptions=
		time:1.4638655*16
		curve:Bezier.linear

animationAudioTitle2_4=new Animation audioTitle2_2,
	x:-476
	animationOptions=
		time:1.4638655*16
		curve:Bezier.linear

animationAudioTitle2_1.onAnimationEnd ->
	audioTitle2_1.x=222
	animationAudioTitle2_3.start()

animationAudioTitle2_2.onAnimationEnd ->
	audioTitle2_2.x=222
	animationAudioTitle2_4.start()

animationAudioTitle2_3.onAnimationEnd ->
	audioTitle2_1.x=222
	animationAudioTitle2_3.start()

animationAudioTitle2_4.onAnimationEnd ->
	audioTitle2_2.x=222
	animationAudioTitle2_4.start()







# 下一首&上一首
forward_icon.onTap ->
	page.snapToNextPage()
	bg2.animate
		opacity: 1

backwords_icon.onTap ->
	page.snapToPreviousPage()
	bg2.animate
		opacity: 0




page.on "change:currentPage", ->
	if page.currentPage is cover2
		audioTitle2_1.x=0
		audioTitle2_2.x=353
		audioTitle2_1.opacity=1
		audioTitle2_2.opacity=1
		animationAudioTitle2_1.start()
		animationAudioTitle2_2.start()

		audioTitle1.animate
			opacity: 0
			options: 
				time: 0.001
		bg2.animate
			opacity: 1

		audio2.play()
		audio.pause()
		play_icon.opacity=0
		pause_icon.opacity=1


# 播放列表状态改变
		listText2.width=283
		listText2.color="rgba(255,255,255,0.87)"
		listText1.color="rgba(255,255,255,0.5)"
		listText3_7.y=120
		listSound_icon.y=listText2.y


	if page.currentPage is cover1
		audioTitle2_1.animate
			opacity: 0
			options: 
				time: 0.001
		audioTitle2_2.animate
			opacity: 0
			options: 
				time: 0.001
		audioTitle1.animate
			opacity: 1
			options: 
				time: 0.1
		bg2.animate
			opacity: 0

		audio.play()
		audio2.pause()
		play_icon.opacity=0
		pause_icon.opacity=1

# 播放列表状态改变
		listText2.width=335
		listText2.color="rgba(255,255,255,0.5)"
		listText1.color="rgba(255,255,255,0.87)"
		listText3_7.y=102
		listSound_icon.y=listText1.y


# 点击播放列表时状态改变

listText2.onTap ->
	listText2.width=283
	listText2.color="rgba(255,255,255,0.87)"
	listText1.color="rgba(255,255,255,0.5)"
	listText3_7.y=120
	listSound_icon.y=listText2.y
	page.snapToPage(cover2,false)
	audio2.play()
	audio.pause()



listText2_2.onTap ->
	listText2.width=283
	listText2.color="rgba(255,255,255,0.87)"
	listText1.color="rgba(255,255,255,0.5)"
	listText3_7.y=120
	listSound_icon.y=listText2.y
	page.snapToPage(cover2,false)
	audio2.play()
	audio.pause()


listText1.onTap ->
	listText2.width=335
	listText2.color="rgba(255,255,255,0.5)"
	listText1.color="rgba(255,255,255,0.87)"
	listText3_7.y=102
	listSound_icon.y=listText1.y
	page.snapToPage(cover1,false)
	audio.play()
	audio2.pause()


listText1_2.onTap ->
	listText2.width=335
	listText2.color="rgba(255,255,255,0.5)"
	listText1.color="rgba(255,255,255,0.87)"
	listText3_7.y=102
	listSound_icon.y=listText1.y
	page.snapToPage(cover1,false)
	audio.play()
	audio2.pause()


# 下载




