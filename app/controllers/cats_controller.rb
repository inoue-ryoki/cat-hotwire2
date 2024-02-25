class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

  # GET /cats
  def index
    # `Cat.ransack`でCatに対してransackを使う
    # params[:q]には検索フォームで指定した検索条件が入る
    @search = Cat.ransack(params[:q])

    # デフォルトのソートをid降順にする
    @search.sorts = 'id desc' if @search.sorts.empty?

    # `@search.result`で検索結果となる@catsを取得する
    # 検索結果に対してはkaminariのpageメソッドをチェーンできる
    @cats = @search.result.page(params[:page])
  end

  # GET /cats/1
  def show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
  end

  # GET /cats/1/edit
  def edit
  end

  # POST /cats
  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to @cat, notice: "ねこを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cats/1
  def update
    if @cat.update(cat_params)
      flash.now.notice = "ねこを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cats/1
  def destroy
    @cat.destroy
    flash.now.notice = "ねこを削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cat_params
      params.require(:cat).permit(:name, :age)
    end
end
