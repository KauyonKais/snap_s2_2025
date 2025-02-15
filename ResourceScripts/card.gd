class_name Card
extends Resource

enum Type {MAJOR, WANDS, CUPS, SWORDS, PENTACLES}

@export_group("Card Attributes")
@export var id:String
@export var type:Type
@export var value:int
