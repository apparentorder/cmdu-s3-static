
variable bucket_name {}
variable zone_name {}
variable alias_names {}

variable files {
	type = list(object({
		name = string
		content_type = string
	}))
}

