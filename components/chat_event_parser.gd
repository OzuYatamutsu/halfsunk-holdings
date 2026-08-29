class_name ChatEventParser
extends Node


## The ChatEventParser provides a more convenient
## way of representing and parsing a ChatWindowModal
## as plain text. To use it, create a new .txt
## file, with each event/message represented according
## to the following syntax:
## 
## FROM;<name>;<title>;<pfp_path>
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


const DELIMITER: String = ";"
const DEFAULT_MESSAGE_DELAY_SECS: float = 0.5


static func load_chatevent_from_file(path: String) -> ChatMessageEvent:
    var _chatevent = FileAccess.open(path, FileAccess.READ)
    var _event_lines: Array[String] = []
    if _chatevent == null:
        push_error("failed to open chatevent: " + path + " (does it exist?)")
        return
    while not _chatevent.eof_reached():
        var _line = _chatevent.get_line().strip_edges()
        if !_line.is_empty():
            _event_lines.push_back(_line)
    _chatevent.close()

    # The first line in the txt file is assumed to be the FROM command
    var chatevent: ChatMessageEvent = _parse_header(_event_lines.pop_front())
    
    # Parse remaining lines
    for line in _event_lines:
        chatevent = _parse_line(line, chatevent)
    return chatevent


static func _parse_header(_header_raw: String) -> ChatMessageEvent:
    assert(_header_raw.begins_with("FROM;"), "error, malformed chat message!")
    var header: PackedStringArray = _header_raw.trim_prefix("FROM;").split(DELIMITER)
    return ChatMessageEvent.CreateChatEvent(header[0].strip_edges(), header[1].strip_edges(), header[2].strip_edges())


static func _parse_line(line: String, chatevent: ChatMessageEvent) -> ChatMessageEvent:
    var message: String = line.strip_edges()

    if line.begins_with(">") and !line.contains(DELIMITER):
        message = message.trim_prefix(">")
        chatevent.Commands.append(
            _add_message_delegate.bind(message, chatevent)
        )
    elif line.begins_with("<") and !line.contains(DELIMITER):
        message = message.trim_prefix("<")
        chatevent.Commands.append(
            _player_advance_delegate.bind(message, chatevent)
        )
        chatevent.Commands.append(
            _player_advance_delegate_response.bind(message, chatevent)
        )
    elif line.begins_with("<") and line.count(DELIMITER) == 3:
        var args = message.trim_prefix("<").strip_edges().split(DELIMITER)
        chatevent.Commands.append(
            _player_choice_delegate_helper.bind(args[0], args[1], args[2], args[3], chatevent)
        )
    elif line.begins_with("<") and line.count(DELIMITER) == 1 and line.ends_with("CLOSE"):
        message = message.trim_prefix("<")
        chatevent.Commands.append(
            _player_close_delegate.bind(message, chatevent)
        )
    else:
        assert(false, "Error parsing chatevent line! " + line)
    return chatevent


static func _add_message_delegate(message: String, chatevent: ChatMessageEvent) -> void:
    chatevent.ButtonOptions = ["(...)"]
    chatevent.add_message("%TS/" + message.strip_edges())
    chatevent.update_button_options()
    await chatevent.wait_secs(DEFAULT_MESSAGE_DELAY_SECS)
    chatevent.advance.emit()


static func _player_advance_delegate(message: String, chatevent: ChatMessageEvent) -> void:
    chatevent.YesAction = chatevent.advance.emit
    chatevent.ButtonOptions = [message.strip_edges().replace(";CLOSE", "")]
    chatevent.update_button_options()


static func _player_advance_delegate_response(message: String, chatevent: ChatMessageEvent) -> void:
    chatevent.add_message("%TS/" + message.strip_edges(), true)
    chatevent.advance.emit()


static func _player_select_delegate(message_yes: String, message_no: String, yes_path: String, no_path: String, chatevent: ChatMessageEvent) -> void:
    chatevent.ButtonOptions = [message_yes, message_no]

    if yes_path == "CLOSE":
        chatevent.YesAction = chatevent.close_window
    else:
        chatevent.YesAction = _player_choice_delegate_helper.bind(
            message_yes, 
            ChatEventParser.load_chatevent_from_file.bind(yes_path),
            chatevent
        )
    if no_path == "CLOSE":
        chatevent.NoAction = chatevent.close_window
    else:
        chatevent.NoAction = _player_choice_delegate_helper.bind(
            message_no, 
            ChatEventParser.load_chatevent_from_file.bind(no_path),
            chatevent
        )

    chatevent.update_button_options()


static func _player_choice_delegate_helper(message: String, action: Callable, chatevent: ChatMessageEvent) -> void:
    chatevent.add_message(message.strip_edges())
    action.call()


static func _player_close_delegate(message: String, chatevent: ChatMessageEvent) -> void:
    chatevent.YesAction = chatevent.close_window
    chatevent.ButtonOptions = [message.strip_edges().replace(";CLOSE", "")]
    chatevent.update_button_options()
