class_name BuySellModal
extends Modal

# "Jinhai Holdings (JINH)"
@onready var TickerLabel: Label = $ModalWindow/InfoContainer/TickerLabel

# "100.24"
@onready var ValueLabel: Label = $ModalWindow/InfoContainer/ValueContainer/ValueLabel

# (up or down symbol)
@onready var UpDownLabel: Label = $ModalWindow/InfoContainer/ValueContainer/UpDownLabel

# "1.64"
@onready var NetChangeValueLabel: Label = $ModalWindow/InfoContainer/ValueContainer/NetChangeValueLabel

# "(+2.64%)"
@onready var NetChangePercentLabel: Label = $ModalWindow/InfoContainer/ValueContainer/NetChangePercentLabel

# Buy/Sell button group
@onready var BuyButton: TextureButton = $ModalWindow/InfoContainer/BuySellButtonGroup/BuyButton
@onready var SellButton: TextureButton = $ModalWindow/InfoContainer/BuySellButtonGroup/SellButton

# Buy/Sell quantity group
@onready var QuantityEdit: TextEdit = $ModalWindow/InfoContainer/QuantitySelector/QuantityEdit
@onready var TickerEdit: TextEdit = $ModalWindow/InfoContainer/QuantitySelector/TickerEdit

# "$12,345.00"
@onready var TransactionValueLabel: Label = $ModalWindow/InfoContainer/TotalInfo/TransactionValueLabel
