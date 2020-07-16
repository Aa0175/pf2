class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    if flash[:question_id].present?
      @answer.question_id = flash[:question_id]
      flash[:question_id] = @answer.question_id
    elsif  flash[:answer_id].present?
      @answer.answer_id = flash[:answer_id]
      flash[:answer_id] = @answer.qanswer_id
    else
      redirect_to new_post_path
    end
    @answers = Answer.where(question_id: @answer.question_id)
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        if params[:commit] == "他の選択肢を追加"
          flash[:question_id] =   @answer.question_id
          format.html { redirect_to new_answer_path(@answer), notice: 'Answer was successfully created.' }
        else
          format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
          format.json { render :show, status: :created, location: @answer }
        end
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:question_id, :answer_id, :content)
    end
end
