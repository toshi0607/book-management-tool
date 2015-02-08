require 'net/http'

class BooksController < ApplicationController

  protect_from_forgery except: :isbn_search
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @search = Book.search(params[:q]) 
    @books = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end

  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @form = Form::BookCollection.new
  end

  def isbn_search

    applicationId = '1062746000989149114'

    Net::HTTP.start('app.rakuten.co.jp', 443, use_ssl: true,
      ca_file: Constants::CA_FILE) do |https|
      res = https.get("/services/api/BooksBook/Search/20130522?format=json&isbn=#{ERB::Util.url_encode(params[:isbn])}&applicationId=#{applicationId}&formatVersion=2")
      render :json => res.body
    end
  end

  # tmp/cacert.pem
  # /usr/lib/ssl/certs/ca-certificates.crt

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @form = Form::BookCollection.new(book_collection_params)
    if @form.save
      redirect_to :books, notice: "#{@form.target_books.size}件の書籍を登録しました。"
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :description, :isbn)
  end

  def book_collection_params
    params
      .require(:form_book_collection)
      .permit(books_attributes: Form::Book::REGISTRABLE_ATTRIBUTES)
  end

end
