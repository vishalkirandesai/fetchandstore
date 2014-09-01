require 'yaml'

class AmazonUser

  @credentials = YAML.load_file('./config/credentials.yml')

  AMAZON_ACCESS_KEY_ID = @credentials['amazon']['access_key_id']
  AMAZON_SECRET_ACCESS_KEY = @credentials['amazon']['secret_access_key']

  AWS.config(
      :access_key_id => AMAZON_ACCESS_KEY_ID,
      :secret_access_key => AMAZON_SECRET_ACCESS_KEY )
  @s3 = AWS::S3.new

  def self.client()
    @s3
  end

end