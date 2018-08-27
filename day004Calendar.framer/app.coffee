# 在bg1、bg2、bg3和bg4组成的集合中，设置透明度过渡的动画
for bg,index in [bg1,bg2,bg3,bg4]
	original=bg.frame                 # 每个bg的位置和长宽值赋值给original
	bg.opacity=0
	bg.animate
		opacity:1
		options: 
			delay: 0.3 + (index*0.1)  # 动画延时设置

# 在图层days的子图层组成的集合中，设置透明度和垂直位置的过渡动画
for day,index in days.children
	original=day.frame
	day.opacity=0
	day.y=original.y+5
	day.animate
		opacity:1
		y:original.y
		options:
			delay:index*0.4

# 在图层rows的子图层组成的集合中，设置垂直位置、宽度和透明度的过渡动画
for row,index in rows.children
	original=row.frame
	row.y +=100
	row.width=0
	row.opacity=0
	row.animate
		y: original.y
		width: original.width
		opacity: 1
		options: 
			delay: 0.2+(0.1*index)