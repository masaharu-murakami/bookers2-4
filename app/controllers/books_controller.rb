class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, only: [:edit, :update]


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id # 誰が投稿したの

   if @book.save
     flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id) # 投稿詳細画面へ

   else
      @books = Book.all
      @user = current_user
      render action: :index
   end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:success]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    
    
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all

    @user = @book.user
    # 本の投稿者が誰なのか
    @booknew = Book.new

    @book_comment = BookComment.new

  end

  def destroy
     @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    end
end
