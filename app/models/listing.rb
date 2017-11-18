class Listing
  attr_accessor :id, :newspaper, :title, :body

  def initialize(id: nil, title: '', body: '')
    @id = id
    @title = title
    @body = body
  end

  def publish
    newspaper.add_listing(self)
  end

  def to_h
    {
        id: id,
        title: title,
        body: body
    }
  end

  def ==(other)
    to_h == other.to_h
  end
end
