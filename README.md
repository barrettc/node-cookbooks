node-cookbooks
=============

AWS cookbooks for node.js/mongodb/rabbitmq/cassandra servers

General Instructions
--------------------
1. Create a SSH keypair
2. Go to CloudFormation and run VPC-NAT.template
3. Create a VPC endpoint and add routes for private subnets.
4. Configure a S3 bucket for the app with the following policy:

        {
          "Version": "2012-10-17",
          "Id": "Policy1415115909152",
          "Statement": [
            {
              "Sid": "Access-to-specific-VPC-only",
              "Principal": "*",
              "Action": "s3:*",
              "Effect": "Allow",
              "Resource": [
                "arn:aws:s3:::awesome_bucket",
                "arn:aws:s3:::awesome_bucket/*"
              ],
              "Condition": {
                "StringEquals": {
                  "aws:sourceVpc": "vpc-abc123"
                }
              }
            }
          ]
        }
5. Go to CloudFormation and run app.template with subnet and VPC values from the output of the VPC-NAT.template execution
