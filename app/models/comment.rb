class Comment < PrimaryRecord
  belongs_to :lite_stuff

  has_many :reactions
end
