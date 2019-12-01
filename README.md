
for details, see the s3-static-hosting project page.

use with a `terraform.tfvars` something like this:

```
zone_name = "example.com"
bucket_name = "examplebucket"
alias_names = [
	"example.com",
	"www.example.com"
]

files = [
	{
		name = "logo.png"
		content_type = "image/png"
	},
	{
		name = "index.html"
		content_type = "text/html"
	}
]
```

