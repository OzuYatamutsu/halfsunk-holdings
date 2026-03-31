class_name Helpers

## Helper functions.

## Rounds to the nearest hundredths place.
static func money_round(x: float) -> float:
    return round(x * 100.0) / 100.0


## Formats a float to currency string (xxxx.xxx -> "$x,xxx.xx")
static func currencyify(raw_number: float, omit_parens=false) -> String:
    var is_negative: bool = (raw_number < 0)
    var number_as_string: String = "%.2f" % [raw_number]
    number_as_string = number_as_string.replace("-", "")
    
    if raw_number < 1000.00 && raw_number > -1000.00:
        if omit_parens:
            return "$%s" % [number_as_string]
        return (
            "($%s)" % [number_as_string] if is_negative
            else "$%s" % [number_as_string]
        )
    
    var output_string: String = ""
    var last_index: int = number_as_string.length() - 4

    # Insert commas as necessary
    for index in range(number_as_string.length()):
        output_string = output_string + number_as_string.substr(index, 1)
        if (last_index - index) % 3 == 0 and index < last_index:
            output_string = output_string + ","

    # Insert negative numbers
    if is_negative and !omit_parens:
        output_string = "($%s)" % [output_string]
    else:
        output_string = "$%s" % [output_string]
    return output_string


## Converts a day + tick_count into a timestamp.
## See GameState for an explanation of timestamp.
static func to_timestamp(day_num: int, tick_count: int) -> int:
    return (day_num * 10000) + tick_count
