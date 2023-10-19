
require_relative '../book'


describe Book do
  let(:book) { Book.new("Sample Title", "Sample Author") }

  it "should have a title" do
    expect(book.title).to eq("Sample Title")
  end

  it "should have an author" do
    expect(book.author).to eq("Sample Author")
  end

  it "should be available by default" do
    expect(book.available).to be true
  end

  it "should be able to change availability" do
    book.available = false
    expect(book.available).to be false
  end


end
