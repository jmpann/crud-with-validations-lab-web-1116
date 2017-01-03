class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  validates :artist_name, presence: true
  validates :release_year, presence: true, :numericality => {:less_than_or_equal_to => Time.now.year}, :if => :released?
  validate :artist_release_year_exist

  def released?
    released
  end

  def artist_release_year_exist
    if Song.where(artist_name: artist_name).where(release_year: release_year).where(title: title).any?
      errors.add(:title, "cannot be relased twice in one year")
    end
  end



end
