class Document < ApplicationRecord

  # ensures only files uploaded to expected bucket are processed.
  VALID_DIRECT_UPLOAD_URL_FORMAT = %r{
    \A
    https:\/\/
    #{Rails.application.secrets.aws['s3_bucket_name']}\.s3\.amazonaws\.com\/
    (?<path>uploads\/.+\/(?<filename>.+))
    \z
  }x.freeze

  enum status: { unprocessed: 0, processed: 1 }

  has_attached_file :upload # Paperclip magic

  validates :direct_upload_url, presence: true,
  format: { with: VALID_DIRECT_UPLOAD_URL_FORMAT }

  do_not_validate_attachment_file_type :upload
end
