class BooksController < ApplicationController
    before_action :authenticate_user!

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id]) #book_commentsのidを見つける
    # @book_comment = BookComment.new
    # @book_comments = @book.book_comments #showのeachに使う
    @user = @book.user
    @book_new = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book.id)
# redirect_to "/books/#{@book.id}"
    else
      @books = Book.all
    flash[:notice] = ' errors prohibited this obj from being saved:'
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.update(book_params)
    flash[:notice] = "You have creatad book successfully."
    redirect_to  book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
      if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to '/books'
      end
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

  def ensure_current_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
    redirect_to books_path
    end
  end
end
