class_name Quest

var quest_id: String
var title: String
var description: String
var objectives: Array = []
var rewards: Dictionary = {}
var status: String = "Not Started"  # Possible values: "Not Started", "In Progress", "Completed"