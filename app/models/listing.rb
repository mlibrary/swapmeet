class Listing
  attr_accessor :id, :newspaper, :title, :body

  def publish
    newspaper.add_listing(self)
  end
end
