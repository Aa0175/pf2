class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    $question_id = params[:question_id] if params[:question_id].present?
    @answers = Answer.where(question_id: $question_id)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    # if $question_id.present?
    #   @answer.question_id = $question_id
    # # elsif $answer_id.present?
    # #   @answer.answer_id = $answer_id
    # else
    #   redirect_to new_post_path, notice: 'エラーが発生しました。もう一度最初からご入力ください。'
    # # end
    # @answers = Answer.where(question_id: @answer.question_id)
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
          format.html { redirect_to new_answer_path, notice: '回答が追加されました。' }
        else
          format.html { redirect_to answers_path, notice: 'Answer was successfully created.' }
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
      params.require(:answer).permit(:question_id, :answer_id, :content, { answer_ids: [] })
    end
end
