class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def index
    @plans = Plan.order(created_at: :desc).all
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
  end
  
  def create
    
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      flash[:success] = 'プランを登録しました。'
      redirect_to @plan
    else
      @plans = current_user.plans.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'プランの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
    @plan = Plan.find(params[:id])

    if @plan.update(plan_params)
      flash[:success] = 'プラン は正常に更新されました'
      redirect_to @plan
    else
      flash.now[:danger] = 'プラン は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    flash[:success] = 'プランを削除しました。'
    redirect_to user_path(current_user)
  end
  
  def plan_params
    params.require(:plan).permit(:title, :address, :content, :money, :status, :friendly_id)
  end
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end
  end
end
