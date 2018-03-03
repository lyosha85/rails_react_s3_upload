# @note It is important to have a single source of truth (Rails) for
# content-type, as clients may return mismatched content-types versus what
# Rails deduces, resulting in s3 signature errors.
#
class GenerateUploadUrl
  attr_reader :content_type, :filename, :url
  # @example
  #   generate_upload_url_service = GenerateUploadUrl.new(filename)
  #   generate_upload_url_service.call
  #
  # @param filename [String]

  def initialize(filename)
    @filename = filename
    @contnet_type = MIME::Types.type_for(filename).first.content_type
  end

  # @return [Boolean] if generation successful
  def call
    obj = AWS::S3.new
                 .buckets[ENV.fetch['AWS_S3_BUCKET']]
                 .objects[]

    @url = obj.url_for(:write, content_type: @content_type, acl: :public_read)
              .to_s

    true
  end
end
