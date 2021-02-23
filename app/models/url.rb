class Url < ApplicationRecord
  belongs_to :user

  validates :original_url, presence: { message: "Must provide original_url to redirect to!" }

  validate :original_url_valid

  validates :slug, uniqueness: true

  before_validation :check_slug

  private

  @@string_length = 8

  # NOTE: Currently if the slug is generated and happens
  #       to randomly conflict, the database will reject
  #       it and the request will fail. This is a low
  #       frequency even and due to time limitations
  #       I am not regenerating in a loop. The user
  #       can submit another API request.
  def generate_slug
    rand(36**@@string_length).to_s(36)
  end

  def check_slug
    if !self.slug? or self.slug.length < 1
      self.slug = generate_slug
    end
  end

  def valid_url?
    uri = URI.parse(original_url)
    return false if uri.host == nil

    return true
  rescue URI::InvalidURIError
    false
  end

  def original_url_valid
    unless valid_url?
      errors.add(:original_url, "The original_url supplied appears invalid! Note: Protocol is required!")
    end  
  end
end
