class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    mount_uploader :image, ImageUploader
end
