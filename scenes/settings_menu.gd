extends Control

@onready var MasterVolumeSlider: Slider = get_tree().get_first_node_in_group("MasterVolumeSlider")
@onready var MusicVolumeSlider: Slider = get_tree().get_first_node_in_group("MusicVolumeSlider")
@onready var SfxVolumeSlider: Slider = get_tree().get_first_node_in_group("SfxVolumeSlider")

func _on_main_menu_return_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_mute_master_volume_button_pressed() -> void:
    AudioEngine.adjust_master_volume(0.0)
    create_tween().tween_property(MasterVolumeSlider, "value", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_full_master_volume_button_pressed() -> void:
    AudioEngine.adjust_master_volume(1.0)
    create_tween().tween_property(MasterVolumeSlider, "value", 100.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_mute_music_volume_button_pressed() -> void:
    AudioEngine.adjust_music_volume(0.0)
    create_tween().tween_property(MusicVolumeSlider, "value", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_full_music_volume_button_pressed() -> void:
    AudioEngine.adjust_music_volume(1.0)
    create_tween().tween_property(MusicVolumeSlider, "value", 100.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_mute_sfx_volume_button_pressed() -> void:
    AudioEngine.adjust_sfx_volume(0.0)
    create_tween().tween_property(SfxVolumeSlider, "value", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_full_sfx_volume_button_pressed() -> void:
    AudioEngine.adjust_sfx_volume(1.0)
    create_tween().tween_property(SfxVolumeSlider, "value", 100.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
