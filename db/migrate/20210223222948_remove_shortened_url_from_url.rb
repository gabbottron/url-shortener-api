class RemoveShortenedUrlFromUrl < ActiveRecord::Migration[6.0]
  def change
    remove_column :urls, :shortened_url
  end
end
