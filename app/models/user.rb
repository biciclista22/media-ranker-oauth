class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true

  def from_auth_hash(provider, auth_hash)
    user = new
    user.provider = provider
    user.id = auth_hash['uid']
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.username = auth_hash['info']['username']
    user.save
    return user
  end
  
end
