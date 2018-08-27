# 开启双指缩放；禁止旋转；禁止缩放旋转
photo.pinchable.enabled=true
photo.rotation.enabled=false
photo.pinchable.rotate=false

# 图片旋转时，禁止绕X轴的3D纵深旋转，设置模糊样式
photo.onScale ->
	photo.rotationX.enabled=false
	photo.blur=Utils.modulate(this.scale,[1,1.5],[8,0])  # 图片在1-1.5倍缩放时，图片的模糊值在8-0之间变换，即随着缩放变大，模糊度变小