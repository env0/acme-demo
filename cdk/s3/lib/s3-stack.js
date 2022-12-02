const cdk = require('aws-cdk-lib');
const s3 = require('aws-cdk-lib/aws-s3');

class S3Stack extends cdk.Stack {
  constructor(scope, id, props) {
    super(scope, id, props);

    new s3.Bucket(this, 'env0-cdk-MyFirstBucket', {
      versioned: true,
      tags: [{key: 'environment', value: 'dev'},
             {key: 'purpose', value: 'demo cdk'}
            ]
    });
  }
}

module.exports = { S3Stack }