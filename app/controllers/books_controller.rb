class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :check_book_user, only: [:edit, :update]

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @bookn = Book.new
    @books = Book.all
    @user = current_user
  end

# 投稿データの保存
def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

  if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@bookn.id)
  else
    @books = Book.all
    @user = current_user
    render "books/index"
  end
end

  def new
      @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book)
    else
      render "books/edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id, :opinion)
  end

  def check_book_user
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end

end
