class_name Helpers
extends Node

## Helper functions.

## Rounds to the nearest hundredths place.
static func money_round(x: float) -> float:
    return round(x * 100.0) / 100.0
