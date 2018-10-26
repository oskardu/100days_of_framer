# dribble:https://dribbble.com/chuanhudu
# uplabs:https://www.uplabs.com/oskar
# github:https://github.com/oskardu
# wechat:kcufuoyd



layer=new BackgroundLayer
	backgroundColor: "black"

animationMaskTime=0.5

Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 750
	screenHeight: 1624




# 出现&收起评论页
animationA=new Animation commentPage,
	y:344
	options:
		time:0.1


animationB=animationA.reverse()

comment_icon.onTap ->
	animationA.start()
	info.opacity=0
	comment_box1.opacity=0
	touxiang.opacity=0
	fullVideo.opacity=0
	share_icon.opacity=0
	comment_icon.opacity=0
	like_icon.opacity=0
	like_clicked.opacity=0
	animationSharePage2.start() # 分享页消失

close_icon.onTap ->
	animationB.start()
	info.opacity=1
	comment_box1.opacity=1
	touxiang.opacity=1
	fullVideo.opacity=1
	share_icon.opacity=1
	comment_icon.opacity=1
	like_icon.opacity=1
	like_clicked.opacity=1





# 第一个视频
# video = new VideoLayer
# 	width: 457
# 	height: 812
# 	x: -41
# 	backgroundColor: "black"
# 	video: "images/%E6%89%8B%E6%9C%BA%E7%AB%96%E5%B1%8F%E8%A7%86%E9%A2%91.mp4"
# 
# video.parent=frame1
# video.sendToBack()
# 
# video.player.play()


# 第二个视频
# Vertical_Love = new VideoLayer
# 	width: 457
# 	height: 812
# 	x: -41
# 	backgroundColor: "black"
# 	video: "images/Vertical%20Love.mp4"
# 
# Vertical_Love.player.play()
# 
# Vertical_Love.parent=frame1
# Vertical_Love.sendToBack()



# 第三个视频
EPIK_HIGH_BORN_HATER_M_V = new VideoLayer
	width: 457
	height: 812
	x: -41
	backgroundColor: "black"
	video: "images/EPIK%20HIGH%20-%20BORN%20HATER%20M-V.mp4"

EPIK_HIGH_BORN_HATER_M_V.player.play()

EPIK_HIGH_BORN_HATER_M_V.parent=frame1
EPIK_HIGH_BORN_HATER_M_V.sendToBack()


# 第四个视频






# 进度条动画
processing_white.width=0

animationC=new Animation processing_white,
	width:335
	options:
#		time:185
		time:161

animationC.start()

# 评论页内容可滑动
scroll=new ScrollComponent
	parent: comment_contentBox
	size: comment_contentBox.size
	scrollHorizontal: false

comment_content.parent=scroll.content


# 弹出键盘时的遮罩背景出现动画
animationComment_fullscreen_bg=new Animation comment_fullscreen_bg,
	y:0
	animationOptions=
		time:0.3

animationComment_fullscreen_bg2=animationComment_fullscreen_bg.reverse()

# 键盘出现动画
animationKeyboard=new Animation keyboard,
	y:479
	animationOptions=
		time:0.3

animationKeyboard2=animationKeyboard.reverse()

# 点击评论页的「说出你的想法」，弹出键盘
# comment_box2.onTap ->
# 	animationComment_fullscreen_bg.start()
# 	animationKeyboard.start()
# 	video.player.pause()
# 	animationC.stop()
# 
# 
# comment_box1.onTap ->
# 	animationComment_fullscreen_bg.start()
# 	animationKeyboard.start()
# 	video.player.pause()
# 	animationC.stop()
# 
# 
# down_icon.onTap ->
# 	animationComment_fullscreen_bg2.start()
# 	animationKeyboard2.start()
# 	video.player.play()
# 	animationC.start()



comment_box2.onTap ->
	
	animationComment_fullscreen_bg.start()
	animationKeyboard.start()
	EPIK_HIGH_BORN_HATER_M_V.player.pause()
	animationC.stop()


comment_box1.onTap ->
	animationComment_fullscreen_bg.start()
	animationKeyboard.start()
	EPIK_HIGH_BORN_HATER_M_V.player.pause()
	animationC.stop()


down_icon.onTap ->
	animationComment_fullscreen_bg2.start()
	animationKeyboard2.start()
	EPIK_HIGH_BORN_HATER_M_V.player.play()
	animationC.start()






# 点击提示语「说出你的想法」输入内容
animationMask1=new Animation mask1,
	width:322
	animationOptions=
		time:animationMaskTime
		curve:Bezier.linear

animationMask2=new Animation mask2,
	width:322
	animationOptions=
		time:animationMaskTime
		curve:Bezier.linear
		delay:animationMaskTime*1

animationMask3=new Animation mask3,
	width:322
	animationOptions=
		time:animationMaskTime
		curve:Bezier.linear
		delay:animationMaskTime*2

animationMask4=new Animation mask4,
	width:322
	animationOptions=
		time:animationMaskTime
		curve:Bezier.linear
		delay:animationMaskTime*3

animationMask5=new Animation mask5,
	width:322
	animationOptions=
		time:animationMaskTime
		curve:Bezier.linear
		delay:animationMaskTime*4

animationMask1.onAnimationStart ->
	animationMask2.start()
	animationMask3.start()
	animationMask4.start()
	animationMask5.start()
	sendButton.backgroundColor="rgba(173, 37, 38, 1)"
	sendButton.borderWidth=0
	text2.color="white"



text1.onTap ->
	text1.opacity=0
	redline1.opacity=0
	animationMask1.start()


text3=new TextLayer
	text:"{number}/500"
	parent: comment_fullscreen_bg
	color: "rgba(255, 255, 255, 0.6)"
	fontSize: 16
	lineHeight: 1.2
	fontWeight: 500
	x: 20
	y: 436
	opacity: 0

# 规定格式为整数
text3.templateFormatter =
	number: (value) ->
		Utils.round(value, 0)

animationText3=new Animation text3,
	template:
		number: 100
	animationOptions=
		time:animationMaskTime*5
		curve:Bezier.linear

animationMask1.onAnimationStart ->
	animationText3.start()
	text4.opacity=0
	text3.opacity=1


# 分享页面动画
animationSharePage=new Animation sharePage,
	y:648
	animationOptions=
		time:0.1

animationSharePage2=animationSharePage.reverse()

share_icon.onTap ->
	animationSharePage.start()

closeTapArea.onTap ->
	animationSharePage2.start()

# 点击关注
# 加号旋转消失动画,旋转45°
animationFollow1=new Animation follow,
	opacity:0
	rotation:45
	options:
		time:0.05

# 「followed」旋转135°
animationFollowed1=new Animation followed,
	opacity:1
	rotation:360
	options:
		time:0.15

follow_bg.onTap ->
		animationFollow1.start()
		animationFollowed1.start()

# # 「followed」旋转消失，旋转45°
# animationFollowed2=new Animation followed,
# 	opacity:0
# 	rotation:405
# 	options:
# 		time:0.1
# 
# # 加号旋转出现
# animationFollow2=new Animation follow,
# 	opacity:1
# 	rotation:180
# 	options:
# 		time:0.3
# 
# follow_bg.onTap ->
# 	if followed.opacity=1
# 		animationFollowed2.start()
# 		animationFollow2.start()

# 双击暂停
# video.onTap ->
# 	pause.opacity=1
# 	video.player.pause()
# 	animationC.stop()
# 
# pause.onTap ->
# 	pause.opacity=0
# 	video.player.play()
# 	animationC.start()


# Vertical_Love.onTap ->
# 	pause.opacity=1
# 	Vertical_Love.player.pause()
# 	animationC.stop()
# 
# pause.onTap ->
# 	pause.opacity=0
# 	Vertical_Love.player.play()
# 	animationC.start()


EPIK_HIGH_BORN_HATER_M_V.onTap ->
	pause.opacity=1
	EPIK_HIGH_BORN_HATER_M_V.player.pause()
	animationC.stop()

pause.onTap ->
	pause.opacity=0
	EPIK_HIGH_BORN_HATER_M_V.player.play()
	animationC.start()



# 点击「喜欢」按钮
like_clicked.scale=0.5

animationLike_clicked=new Animation like_clicked,
	scale:1
	animationOptions=
		time:0.3

animationLike_icon2=new Animation like_icon2,
	scale:1
	animationOptions=
		time:0.3

like_icon2.onTap ->
	like_icon2.opacity=0
	like_icon2.scale=0.5
	like_clicked.opacity=1
	animationLike_clicked.start()
	like_number.text="336"
	like_icon2.sendToBack()


like_clicked.onTap ->
	like_clicked.opacity=0
	like_clicked.scale=0.5
	like_icon2.opacity=1
	animationLike_icon2.start()
	like_number.text="335"
	like_clicked.sendToBack()















