class ChildAnniversariesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @child_anniversaries = current_user.child_anniversaries.desc_order.paginate(page: params[:page])
  end

  def show
    @child_anniversary = ChildAnniversary.find(params[:id])
  end

  def new
    @child_anniversary = ChildAnniversary.new
  end

  def edit
    @child_anniversary = ChildAnniversary.find(params[:id])
  end

  def update
    @child_anniversary = ChildAnniversary.find(params[:id])
    if @child_anniversary.update(child_anniversary_params)
      flash[:success] = "記念日情報が更新されました"
      redirect_to child_anniversaries_path
    else
      render 'edit'
    end
  end

  def create
    @child_anniversary = current_user.child_anniversaries.build(child_anniversary_params)
    if @child_anniversary.save
      flash[:success] = "記念日登録"
      redirect_to child_anniversary_path(@child_anniversary)
    else
      render 'new'
    end
  end

  def destroy
    @child_anniversary = ChildAnniversary.find(params[:id])
    if current_user.admin? || current_user?(@child_anniversary.user)
      @child_anniversary.destroy
      flash[:success] = "記念日を削除しました"
      redirect_to root_url
    else
      flash[:danger] = "他人の記念日は削除できません"
      redirect_to root_url
    end
  end

  private

  def child_anniversary_params
    params.require(:child_anniversary).permit(:name, :date, :description)
  end

  def correct_user
    @child_anniversary = current_user.child_anniversaries.find_by(id: params[:id])
    redirect_to root_url if @child_anniversary.nil?
  end
end
