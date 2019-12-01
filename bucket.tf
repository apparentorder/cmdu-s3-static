resource aws_s3_bucket main {
	bucket = var.bucket_name
	policy = jsonencode({
		"Version": "2012-10-17",
		"Statement": [
			{
				"Sid": "PublicRead",
				"Effect": "Allow",
				"Principal": "*",
				"Action": ["s3:GetObject"],
				"Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
			}
		]
	})
	tags = var.dutag
}

resource aws_s3_bucket_object s3file {
	count = length(var.files)
	bucket = var.bucket_name

	key = element(var.files, count.index).name
	source = "files/${element(var.files, count.index).name}"
	content_type = element(var.files, count.index).content_type
	etag = filemd5("files/${element(var.files, count.index).name}")

	depends_on = [ aws_s3_bucket.main ]
	tags = var.dutag
}

