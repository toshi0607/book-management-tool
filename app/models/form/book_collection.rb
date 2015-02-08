class Form::BookCollection < Form::Base
  DEFAULT_ITEM_COUNT = 5
  attr_accessor :books

  def initialize(attributes = {})
    super attributes
    self.books = DEFAULT_ITEM_COUNT.times.map { Form::Book.new } unless books.present?
  end

  def books_attributes=(attributes)
    self.books = attributes.map do |_, book_attributes|
      Form::Book.new(book_attributes).tap { |v| v.availability = false }
    end
  end

  def valid?
    valid_books = target_books.map(&:valid?).all?
    super && valid_books
  end

  def save
    return false unless valid?
    Book.transaction { target_books.each(&:save!) }
    true
  end

  def target_books
    self.books.select { |v| value_to_boolean(v.register) }
  end
end