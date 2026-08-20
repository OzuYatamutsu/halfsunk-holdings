class_name ChatEventParser
extends Node

## The ChatEventParser provides a more convenient
## way of representing and parsing a ChatWindowModal
## as plain text. To use it, create a new .txt
## file, with each event/message represented according
## to the following syntax:
## 
## FROM:<name>;<title>;<pfp_path>
## e.g. FROM;Jinhai Qian;President of Jinhai Holdings;res://components/pfp_jinhai.png
##  Specifies the sender of the chat message.
##
## > <text>
## e.g. > Good morning!
##  Specifies a message received from the sender.
##  Subsequent messages will be sent with (by default) a
##  500ms delay between each message.
##
## < <text>
## e.g. < Hi!
##  Specifies a clickable option to send to the sender.
##  When clicked, advances dialogue by 1 tick.
## 
## < <yes_text>;<no_text>;<path_to_yes_option>;<path_to_no_option>
## e.g. < Sure!;That's no good!;res://events:cm_onboarding_02.txt;res://events:cm_onboarding_03.txt
##  Specifies two clickable options to send to the sender.
##  <path_to_yes_option> loads and continues the specified chatevent if <yes_text> is selected,
##  <path_to_no_option> loads and continues the specified chatevent if <no_text> is selected.
##  These can both be replaced with CLOSE if desired (see below).
##
##  < <text>;CLOSE
##  e.g. Goodbye!;CLOSE
##   Closes the window upon click.

static func load_chatevent_from_file(path: String) -> ChatWindowModal:
    var _chatevent = FileAccess.open(path, FileAccess.READ)
    var _event_lines = []
    if _chatevent == null:
        push_error("failed to open chatevent: " + path + " (does it exist?)")
        return
    while not _chatevent.eof_reached():
        _event_lines.push_back(_chatevent.get_line())
    _chatevent.close()

    # TODO: parse chatevent according to the above rules

    return null  # TODO
