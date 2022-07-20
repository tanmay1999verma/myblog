class ArticlesController < ApplicationController
  before_action :authenticate_user!
  def index
    @article = Article.new
    if current_user.has_role? :admin
      @articles = Article.all.order('created_at DESC')
      @user = User.all
    else
      @articles=Article.where(user_id: current_user.id) .or(Article.where(status: :public)).order('created_at DESC')
    end
  end
  def show
    @article = Article.find(params[:id])
    @blog = @article
  end

  def create
    @article = Article.new(article_params)
    @article.user_id =current_user.id
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    if @article.destroy!
      flash[:success] ="deleted successful"
    else
       flash[:success] ="deleted Unsuccessful"
    end
    redirect_to root_path, status: :see_other
  end

  def report
    @article = Article.all
     respond_to do |format|
      format.html
      format.csv { send_data @article.to_csv3 }
      # format.xls { send_data @article.to_csv3(col_sep: "\t") }
      format.xlsx
     end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
