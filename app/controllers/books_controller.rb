require 'net/http'

class BooksController < ApplicationController

  protect_from_forgery except: :isbn_search
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @search = Book.search(params[:q]) 
    books = @search.result

    respond_to do |format|
      format.html do
        @books = books.page(params[:page]).order(:id)
      end
      format.json { render json: books }
    end
  end

  def show
  end

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

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def create
    @form = Form::BookCollection.new(book_collection_params)
    if @form.save
      redirect_to :books, notice: "#{@form.target_books.size}件の書籍情報を登録しました。"
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      @book = Book.find_by(id: params[:id])
      if @book.update!(book_params)
        format.html { redirect_to @book, notice: '書籍情報を更新しました。' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: '書籍情報を削除しました。' }
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
    params.require(:book).permit(:title, :description, :isbn, :genre, :memo)
  end

  def book_collection_params
    params
      .require(:form_book_collection)
      .permit(books_attributes: Form::Book::REGISTRABLE_ATTRIBUTES)
  end
end
