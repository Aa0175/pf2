class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_attributes, only: [:attributes, :save_attributes]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
   @posts = @user.posts
  end

  def search
    @users = User.where('name LIKE ?', "%#{params[:name]}%" )
    render :index
  end

  def attributes
    @user = User.new
    set_attributes
    if flash[:r_source]
      @r_source = flash[:r_source]
      flash[:r_source] = @r_source
    end
  end

  def save_attributes
    @user = current_user

    @sex = Sex.find_by(id: user_params[:sex]) unless user_params[:sex].nil?
    @birthplace = Birthplace.find_by(id: user_params[:birthplace]) unless user_params[:birthplace].nil?
    @residence = Residence.find_by(id: user_params[:residence]) unless user_params[:residence].nil?
    @housemate = Housemate.find_by(id: user_params[:housemate]) unless user_params[:housemate].nil?

    @user.assign_attributes({ age: user_params[:age], height: user_params[:height], weight: user_params[:weight], job: user_params[:job] })

    if params[:commit] == "次へ"
      if @user.save
        @sex.users << @user unless @sex.nil?
        @birthplace.users << @user unless @birthplace.nil?
        @residence.users << @user unless @residence.nil?
        @housemate.users << @user unless @housemate.nil?
        flash[:notice] == "設定が保存されました"
        redirect_to user_path(@user.id) and return
      else
        redirect_to posts_path, flash[:notice] = "設定が正しく保存されませんでした" and return
      end
    elsif params[:commit] == "スキップ"
      redirect_to user_path(@user.id) and return
    end
  end

  def edit_attributes
    @user = User.find(params[:id])
    set_attributes
  end

  def update_attributes
    @user = current_user

    # その他の値を@userにセット
    @user.assign_attributes({ age: user_params[:age], height: user_params[:height], weight: user_params[:weight], job: user_params[:job] })

    # 中間テーブルを呼び出し
    @user_sex = UserSex.find_by(user_id: @user.id)
    @user_birthplace = UserBirthplace.find_by(user_id: @user.id)
    @user_residence = UserResidence.find_by(user_id: @user.id)
    @user_housemate = UserHousemate.find_by(user_id: @user.id)

    # 各パラメーターに対応する属性の値を呼び出し
    @sex = Sex.find_by(id: user_params[:sex])
    @birthplace = Birthplace.find_by(id: user_params[:birthplace])
    @residence = Residence.find_by(id: user_params[:residence])
    @housemate = Housemate.find_by(id: user_params[:housemate])

    # 各パラメーター更新（後で処理考える）
    if @user_sex.nil?
      @sex.users << @user
    # elsif @user_sex.sex_id == user_params[:sex].to_i
    #   break
    elsif @user_sex.present?
      # 既に@user.sexes等があった場合の処理
      @user_sex = UserSex.find_by(user_id: @user.id)
      @user_sex.sex_id = @sex.id
      @user_sex.save
    end

    if @user_residence.nil?
      @residence.users << @user
    elsif @user_residence.present?
      @user_residence = UserResidence.find_by(user_id: @user.id)
      @user_residence.residence_id = @residence.id
      @user_residence.save
    end

    if @user_birthplace.nil?
      @birthplace.users << @user
    elsif @user_birthplace.present?
      @user_birthplace = UserBirthplace.find_by(user_id: @user.id)
      @user_birthplace.birthplace_id = @birthplace.id
      @user_birthplace.save
    end

    if @user_housemate.nil?
      @housemate.users << @user
    elsif @user_housemate.present?
      @user_housemate = UserHousemate.find_by(user_id: @user.id)
      @user_housemate.housemate_id = @housemate.id
      @user_housemate.save
    end

    @user.save

    flash[:notice] = "更新が完了しました"
    redirect_to user_path(@user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_attributes
      @sex = Sex.all
      @birthplace = Birthplace.all
      @residence = Residence.all
      @housemate = Housemate.all
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:id, :_method, :name, :img, :age, :sex, :height, :weight, :birthplace, :residence, :job, :housemate, :authenticity_token, :commit)
    end
end
