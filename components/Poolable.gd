## Extend this class for objects which can be used with ObjectPool.
class_name Poolable
extends Node

## What should happen when the object is acquired from ObjectPool?
##
## (i.e., a call to ObjectPool.acquire())
func on_acquire() -> void:
    pass


## What should happen when the object is released to ObjectPool?
##
## (i.e., a call to ObjectPool.release(this))
func on_release() -> void:
    pass
