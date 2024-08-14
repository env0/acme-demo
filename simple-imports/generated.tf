# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "aws-cloudtrail-logs-244172364962-cacdf19f"
# resource "aws_s3_bucket_policy" "s_3_bucket_policy_r9o" {
#   bucket = "aws-cloudtrail-logs-244172364962-cacdf19f"
#   policy = "{\"Statement\":[{\"Action\":\"s3:GetBucketAcl\",\"Condition\":{\"StringEquals\":{\"AWS:SourceArn\":\"arn:aws:cloudtrail:us-east-1:244172364962:trail/cloudcompass-events\"}},\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::aws-cloudtrail-logs-244172364962-cacdf19f\",\"Sid\":\"AWSCloudTrailAclCheck20150319-20789836-624f-4a9d-bf83-51d5a09567b6\"},{\"Action\":\"s3:PutObject\",\"Condition\":{\"StringEquals\":{\"AWS:SourceArn\":\"arn:aws:cloudtrail:us-east-1:244172364962:trail/cloudcompass-events\",\"s3:x-amz-acl\":\"bucket-owner-full-control\"}},\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::aws-cloudtrail-logs-244172364962-cacdf19f/AWSLogs/244172364962/*\",\"Sid\":\"AWSCloudTrailWrite20150319-94f01702-84e4-4dc7-8862-4ea91d0e451b\"},{\"Action\":[\"s3:GetBucketLocation\",\"s3:GetObject\",\"s3:ListBucket\"],\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::913128560467:role/env0-cloud-scanner\"},\"Resource\":[\"arn:aws:s3:::aws-cloudtrail-logs-244172364962-cacdf19f\",\"arn:aws:s3:::aws-cloudtrail-logs-244172364962-cacdf19f/*\"],\"Sid\":\"AllowEnv0ToReadCloudTrailEvents\"}],\"Version\":\"2012-10-17\"}"
# }
