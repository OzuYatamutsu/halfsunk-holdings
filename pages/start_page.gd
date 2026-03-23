# StartPage
extends PageContent

const WORKDAY_OF_WEEK = [
    "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday"
]

@onready var DateLabel: Label = %DateLabel
@onready var CashValueLabel: Label = %CashValue
@onready var SecuritiesValueLabel: Label = %SecuritiesValue
@onready var DebtValueLabel: Label = %DebtValue
@onready var NetWorthValueLabel: Label = %NetWorthValue

func _ready():
    Title = "HOMEPAGE - Bluebird Browser"
    PageHeightY = 1800
    update_scrollable_area()
    populate_data()

func populate_data() -> void:
    _populate_date_label()
    _populate_cash_label()
    _populate_securities_value_label()
    _populate_debt_value_label()
    _populate_networth_value_label()

func _populate_date_label() -> void:
    DateLabel.text = "%s, Day %s" % [
        WORKDAY_OF_WEEK[(GameState.day_count - 1) % 5],
        GameState.day_count
    ]

func _populate_cash_label() -> void:
    CashValueLabel.text = "$%.2f" % GameState.cash

func _populate_securities_value_label() -> void:
    SecuritiesValueLabel.text = "$%.2f" % GameState.portfolio.value()

func _populate_debt_value_label() -> void:
    DebtValueLabel.text = "($%.2f)" % GameState.debt
    DebtValueLabel.add_theme_color_override("font_color", Color(SharedConstants.NEGATIVE_COLOR_CODE))

func _populate_networth_value_label() -> void:
    if (GameState.net_worth < 0.0):
        NetWorthValueLabel.text = "($%.2f)" % GameState.net_worth
        NetWorthValueLabel.add_theme_color_override("font_color", Color(SharedConstants.NEGATIVE_COLOR_CODE))
    else:
        NetWorthValueLabel.text = "$%.2f" % GameState.net_worth
        NetWorthValueLabel.add_theme_color_override("font_color", Color(SharedConstants.POSITIVE_COLOR_CODE))
