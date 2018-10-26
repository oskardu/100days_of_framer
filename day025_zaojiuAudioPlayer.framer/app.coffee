# dribble:https://dribbble.com/chuanhudu
# uplabs:https://www.uplabs.com/oskar
# github:https://github.com/oskardu
# wechat:kcufuoyd



audio= new Audio("sounds/Ashtar%20Command%20-%20Deadman's%20Gun.mp3")

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


# # 进度条动画
# processing_white.width=0
# processing_circle.x=47
# 
# animationProcessingCircle=new Animation processing_circle,
# 	x:304
# 	animationOptions=
# 		time:255
# 		curve:Bezier.linear
# 
# animationProcessingWhite=new Animation processing_white,
# 	width:257
# 	animationOptions=
# 		time:255
# 		curve:Bezier.linear


# 点击评论按钮弹出评论页
animationA=new Animation commentPage,
	y:310
	options:
		time:0.1


animationB=animationA.reverse()

comment_icon.onTap ->
	animationA.start()

close_icon.onTap ->
	animationB.start()

# 评论页内容可滑动
scroll=new ScrollComponent
	parent: comment_contentBox
	size: comment_contentBox.size
	scrollHorizontal: false

comment_content.parent=scroll.content



# 点击播放列表弹出
animationListPage=new Animation listPage,
	y:310
	options:
		time:0.1

animationListPage2=animationListPage.reverse()

list_icon.onTap ->
	animationListPage.start()

close_icon2.onTap ->
	animationListPage2.start()

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







