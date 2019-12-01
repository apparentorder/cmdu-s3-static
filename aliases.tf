data aws_route53_zone main {
	name = var.zone_name
}

resource aws_route53_record alias {
	count = length(var.alias_names)
	zone_id = data.aws_route53_zone.main.zone_id
	name = "${element(var.alias_names, count.index)}."
	type = "A"
	alias {
		name = aws_s3_bucket.alias[count.index].website_domain
		zone_id = aws_s3_bucket.alias[count.index].hosted_zone_id
		evaluate_target_health = false
	}
}

resource aws_s3_bucket alias {
	count = length(var.alias_names)
	bucket = element(var.alias_names, count.index)

	acl = "public-read"

	website {
		redirect_all_requests_to = "https://${var.bucket_name}.s3.DUALSTACK.${data.aws_region.current.name}.amazonaws.com/index.html?foo"
	}

	tags = var.dutag
}


