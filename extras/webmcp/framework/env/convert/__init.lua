convert._type_symbol_mappings = setmetatable({}, { __mode = "k" })

convert.register_type(atom.boolean,   "boolean")
convert.register_type(atom.string,    "string")
convert.register_type(atom.integer,   "integer")
convert.register_type(atom.number,    "number")
convert.register_type(atom.fraction,  "fraction")
convert.register_type(atom.date,      "date")
convert.register_type(atom.timestamp, "timestamp")
convert.register_type(atom.time,      "time")