"""
注意若两个窗口重叠，则精灵无法进入另一个窗口，
因为在交界处精灵既处于子窗口也处于主窗口,
这时将窗口移开即可。
"""
extends Window

var main_win:Rect2
var sub_win:Rect2
var can_in_main:bool=true
@onready var icon: Sprite2D = %Icon

func _ready() -> void:
	change_window_size()
	#将子窗口独立
	self.get_viewport().set_embedding_subwindows(false)
	#背景透明，别忘勾选像素级透明
	get_viewport().transparent =true
	get_viewport().transparent_bg = true
	#窗口置顶
	get_viewport().always_on_top = true
	#设置图片位置
	icon.position=self.size/2
	
	#主窗口调整
	get_tree().get_root().get_viewport().transparent =true
	get_tree().get_root().get_viewport().transparent_bg = true
	get_tree().get_root().get_viewport().always_on_top = true
	
	
	
	

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("space"):
		#remove_child(icon)
	#判断节点是否在场景
	if  is_instance_valid(icon):
		#此处记录sprite的全屏位置
		var global_pos = Vector2i(get_viewport().get_window().position+Vector2i(icon.position)) if can_in_main else  Vector2i(get_tree().get_root().get_viewport().get_window().position+Vector2i(icon.position)) 
		#此处记录主窗口的尺寸
		main_win=Rect2(get_tree().get_root().position, get_tree().get_root().size)
		#此处记录子窗口的尺寸
		sub_win=Rect2(get_viewport().get_window().position,get_viewport().get_window().size)
		#判断是否处于主窗口
		if can_in_main && main_win.has_point(global_pos):
			#将节点保存
			Global.sprite=icon
			#移除此节点
			remove_child(icon)
			#重新添加
			get_tree().get_root().add_child(Global.sprite)
			#重新设置位置
			Global.sprite.position=(global_pos-get_tree().get_root().get_viewport().get_window().position)
			can_in_main=false
			
		if not can_in_main && sub_win.has_point(global_pos):
			#printt(sub_win,global_pos)
			#将节点保存
			Global.sprite=icon
			#移除此节点
			get_tree().get_root().remove_child(icon)
			#重新添加
			self.add_child(Global.sprite)
			#重新设置位置
			Global.sprite.position=(global_pos-get_viewport().get_window().position)
			can_in_main=true

		pass

func change_window_size():
	#调节屏幕大小
	var window_list=DisplayServer.get_window_list()
	var set_size=Vector2i(600,300)
	DisplayServer.window_set_size(set_size,window_list[0])
