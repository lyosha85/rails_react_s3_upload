Aws.config.update(region: ENV.fetch('AWS_S3_REGION'),
           credentials: Aws::Credentials.new(
             ENV.fetch('AWS_KEY'),
             ENV.fetch('AWS_SECRET')
           ))
