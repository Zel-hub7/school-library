class Book
  attr_accessor :title, :author, :available

  def initialize(title, author, available = true)
    @title = title
    @author = author
    @available = available
  end

  def add_rental(date, person)
    rental = Rental.new(date, self, person)
    @rentals << rental
  end
end
