class_name ObjectPool
extends Node

@export var size = 0
var _available_pool: Array[Poolable] = []
var _in_use_pool: Array[Poolable] = []

func _init(prototype: Poolable, initial_size: int) -> void:
    for i in initial_size:
        _available_pool.append(prototype.new())

func acquire_object() -> Poolable:
    var object: Poolable = _available_pool.pop_back()
    _in_use_pool.append(object)
    
    object.on_acquire()
    return object

func release_object(object: Poolable) -> void:
    assert(object in _in_use_pool, "tried to free an object not from this pool!")
    
    _in_use_pool.erase(object)
    _available_pool.push_back(object)
    object.on_release()
