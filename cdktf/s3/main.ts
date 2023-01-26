// Copyright (c) HashiCorp, Inc
// SPDX-License-Identifier: MPL-2.0
import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // define resources here
    new AwsProvider(this, "AWS", {
      region: "us-west-1",
    });

    new S3Bucket(this, "mybucket", {
      bucketPrefix: "cdktf-demo",
      //bucket: "uermz32145",
    });
  }
}

const app = new App();
new MyStack(app, "s3");
app.synth();
