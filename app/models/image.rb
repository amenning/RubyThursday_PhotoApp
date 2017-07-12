class Image < ApplicationRecord
  belongs_to :album

  has_attached_file :album_image,
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['aws_access_key_id'],
      secret_access_key: ENV['aws_secret_access_key'],
      bucket: "amenning-album-image-#{Rails.env}"
    },
    s3_region: 'us-east-2',
    path: "image/:attachment/:id/:style/:filename",
    url: ":s3_domain_url",
    styles: {
      small: '100x100#',
      feed: '500'
    },
    default_url: '400x400.png'

  validates_attachment_content_type :album_image, content_type: /\Aimage\/.*\Z/
end
