class BooksController < ApplicationController
  # 本の感想の投稿一覧画面および投稿画面のアクション
  def index
        # 投稿一覧画面のアクション
    @books = Book.all
    @book = Book.new
  end

  # 本の感想の投稿内容の保存
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id), notice:"Book was successfully created."
    else
      @books = Book.all
      render action: :index
    end
  end

  # 詳細ページ
  def show
    @book = Book.find(params[:id])
  end

  # 編集
  def edit
    @book = Book.find(params[:id])
  end

  # 更新
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:"Book was successfully updated."
    else
      @books = Book.all
      render action: :edit
    end
  end

  # 削除
  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to "/books"
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end