class QuestionsController < ApplicationController
  include ActionController::Live

  before_action :set_question, only: [:show, :edit, :update, :destroy]


  # GET /questions
  # GET /questions.json
  def index
    @title = 'Questions'
    @access_code = session[:access_code]
    @valid_code = session[:valid_code] 
    if defined?(@valid_code)
      if @valid_code  == "valid"
        @questions = Question.where('access_code = ?', @access_code)
      elsif lecturer_signed_in?
        @questions = Question.where('lecturer_id = ?', current_lecturer.id)
      else
        flash[:alert] = "You have to be lecturer or have a valid code to access this page"
        redirect_to enter_access_code_question_path
      end
    elsif lecturer_signed_in?
      @questions = Question.where('lecturer_id = ?', current_lecturer.id)
    else
      flash[:alert] = "You have to be lecturer or have a valid code to access this page"
      redirect_to enter_access_code_question_path
    end
  end


  # GET /questions/1
  # GET /questions/1.json
  def show
     @title = 'Show Question'
  end

  def enter_access_code_question
    @title = 'Enter Access Code'
  end

  # GET /questions/new
  def new
    @title = 'New Question'
    @access_code2 = session[:access_code] 
    @valid_code = session[:valid_code]
    @access_code = AccessCode.where("code = ? AND valid_until >= ?", @access_code2,  Date.today).first
    if defined?(@valid_code)
      if @valid_code  == "valid"
        @polls_for_select = Poll.where("access_code = ?", @access_code2 )
        if @polls_for_select.first == nil
          flash[:alert] = "You have to create a poll first"
          redirect_to root_path
        else
          @question = Question.new
        end
      elsif lecturer_signed_in?
        @polls_for_select = Poll.where("lecturer_id = ?", current_lecturer.id )
        if @polls_for_select.first == nil
          flash[:alert] = "You have to create a poll first"
          redirect_to root_path
        else
          @question = Question.new
        end
      else
        flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
        redirect_to root_path
      end
    elsif lecturer_signed_in?
      @polls_for_select = Poll.where("lecturer_id = ?", current_lecturer.id )
      if @polls_for_select.first == nil
        redirect_to root_path
      else
        @question = Question.new
      end
    else
      flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
      redirect_to root_path
    end
  end



  # GET /questions/1/edit
  def edit
    @title = 'Edit Question'
    @access_code2 = session[:access_code] 
    @valid_code = session[:valid_code] 
    if defined?(@valid_code)
      if(@valid_code == "valid")
        if @access_code2 == @question.poll.access_code
          @polls_for_select = Poll.where("access_code = ?", @access_code2)
          @access_code = AccessCode.where("code = ?", @access_code2).first
        else
          flash[:alert] = "You don't have permission to edit this question"
          redirect_to root_path
        end
      elsif lecturer_signed_in?
        if @question.poll.lecturer_id == current_lecturer.id || @question.poll.access_code_lecturer == current_lecturer.id
          @polls_for_select = Poll.where("lecturer_id = ?", current_lecturer.id )
        else
          flash[:alert] = "You don't have permission to edit this question"
          redirect_to root_path
        end
      else
        flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
        redirect_to root_path
      end
    elsif @question.poll.lecturer_id == current_lecturer.id || @question.poll.access_code_lecturer == current_lecturer.id
      @polls_for_select = Poll.where("lecturer_id = ?", current_lecturer.id )
    else
      flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
      redirect_to root_path
    end
  end

  def final_page
    @title = "Final Page"

  end

  def view_responses
    @title = "Results"
    @data = []
    @labels = []
    @responses = []
    require 'lazy_high_charts'
    question_id = params[:question_param]
    poll_id = params[:poll_param]
    @poll_questions = Question.where('poll_id  = ?', poll_id)
    @questions = Question.where('id  = ?', question_id).first
    if student_signed_in?
      @students = Student.where('id = ?', current_student.id).first
    end
    @response1 = @questions.response1.to_i
    @response2 = @questions.response2.to_i
    @response3 = @questions.response3.to_i
    @response4 = @questions.response4.to_i
    @response5 = @questions.response5.to_i
    @response6 = @questions.response6.to_i
    @label1 = @questions.answer1
    @label2 = @questions.answer2
    @label3 = @questions.answer3
    @label4 = @questions.answer4
    @label5 = @questions.answer5
    @label6 = @questions.answer6

    if @label1 != ""
      @data.push([@label1,   @response1])
      @labels.push(@label1)
      @responses.push(@response1)
    end
    if @label2 != ""
      @data.push([@label2,   @response2])
      @labels.push(@label2)
      @responses.push(@response2)
    end
    if @label3 != ""
      @data.push([@label3,   @response3])
      @labels.push(@label3)
      @responses.push(@response3)
    end
    if @label4 != ""
      @data.push([@label4,   @response4])
      @labels.push(@label4)
      @responses.push(@response4)
    end
    if @label5 != ""
      @data.push([@label5,   @response5])
      @labels.push(@label5)
      @responses.push(@response5)
    end
  if @label6 != ""
      @data.push([@label6,   @response6])
      @labels.push(@label6)
      @responses.push(@response6)
    end

if @questions.chart_style == "Bar Chart"
  @chart = LazyHighCharts::HighChart.new('column') do |f|
           f.series(:name=>'Answer',:data=> @data)      
           f.title({ :text=>"Answer"})
           f.legend({:align => 'right', 
                    :x => -100, 
                    :verticalAlign=>'top',
                    :y=>20,
                    :floating=>"true",
                    :backgroundColor=>'#FFFFFF',
                    :borderColor=>'#CCC',
                    :borderWidth=>1,
                    :shadow=>"false"
                    })
           f.options[:chart][:defaultSeriesType] = "column"
           f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Answers"}, :categories => ["1","2","3","4","5","6",]}
           f.options[:yAxis][:title] = {:text=>"Responses"}
           
            
        end

else

  @chart = LazyHighCharts::HighChart.new('pie') do |f|
    f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
    series = {
             :type=> 'pie',
             :name=> 'Answers',
             :data=> @data
    }
    f.series(series)
    f.options[:title][:text] = @questions.question
    f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
    f.plot_options(:pie=>{
      :allowPointSelect=>true, 
      :cursor=>"pointer" , 
      :dataLabels=>{
        :enabled=>true,
        :color=>"black",
        :style=>{
          :font=>"13px Trebuchet MS, Verdana, sans-serif"
        }
      }
    })
  end
end
  @total_responses = @questions.total_responses.to_i
end


  def submit_answer
    radio = params[:radio]
    poll_param = params[:current_poll]
    question_param = params[:question_param]
    @position = params[:current_position]
    @questions = Question.where('poll_id  = ?', poll_param)
    @responses = Question.where('id = ?',question_param).first   
    @students = Student.where('id = ?', current_student.id).first
    @history = PollHistory.where(:student => current_student.id, :question_id => question_param).first
    if @responses.status == 0 || @responses.status == nil
      flash[:alert] = "The question poll is closed"
      redirect_to action: "show", id: question_param
    elsif @responses.status == 1 || @responses.status == nil
      if @history != nil
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        flash[:alert] = "You have already answered this question"
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == '1'
        @answer = @responses.answer1
        @responses.update_attributes(response1: @responses.response1.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == '2'
        @answer = @responses.answer2
        @responses.update_attributes(response2: @responses.response2.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == "3"
        @answer = @responses.answer3
        @responses.update_attributes(response3: @responses.response3.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == "4"
        @answer = @responses.answer4
        @responses.update_attributes(response4: @responses.response4.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == "5"
        @answer = @responses.answer5
        @responses.update_attributes(response5: @responses.response5.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      elsif radio == "6"
        @answer = @responses.answer6
        @responses.update_attributes(response6: @responses.response6.to_i + 1)
        @responses.update_attributes(total_responses: @responses.total_responses.to_i + 1)
        @students.update_attributes(current_question: @students.current_question.to_i + 1)
        PollHistory.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        History.create(:poll_id => poll_param, :question_id => question_param, :student => current_student.id, :answer => @answer)
        redirect_to action: 'view_responses', :question_param => question_param, :poll_param => poll_param
      end
    end 
  end

  def view_questions
    @status = params[:button]
    if @status == "first"
      poll_id = params[:poll][:poll_id]
      @questions = Question.where("poll_id  = ?", poll_id)
      @question = Question.where("poll_id  = ?", poll_id).first
      @students = Student.where("id = ?", current_student.id).first 
      @current_question = 0
      @students.update_attributes(current_question: @current_question)
      @title = "View Questions"
        if @question == nil
            flash[:alert] = "No available questions in this poll"  
            redirect_to vote_path
        else
            redirect_to action: "show", id: @questions.first.id
        end
    elsif @status == "Next"
      poll_id = params[:poll_param]
      @questions = Question.where("poll_id = ?", poll_id)
      @students = Student.where("id = ?", current_student.id).first
      redirect_to action: 'show', id: @questions[@students.current_question.to_i].id
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_code_question
    @access_code_param = params[:code_question][:code_question]
    @access_codes_question = AccessCode.where("code = ? AND valid_until >= ?", @access_code_param,  Date.today).first
    if @access_codes_question != nil
      session[:valid_code] = "valid"
      session[:access_code]  = @access_codes_question.code
      redirect_to questions_path
    else
      @access_codes_question = 1
      session[:valid_code] = "invalid"
      session[:access_code]  = []
      flash[:alert] = "Invalid Access Code"
      redirect_to root_path
    end
  end

  def enable_question
    @status = 0
    status = params[:button]
    question_id = params[:question_param]
    @question = Question.where('id = ?',question_id).first
    @histories = PollHistory.where('question_id = ?', question_id)
    if status == 'Activate'
      @question.update_attributes(status: @status + 1)
      flash[:notice] = "The question poll is now open"
      redirect_to action: "show", id: question_id
    elsif status == 'Activate_index'
      @question.update_attributes(status: @status + 1)
      flash[:notice] = "The question poll is now open"
      redirect_to questions_path
    elsif status == 'Deactivate'
      flash[:notice] = "The question poll is now close"
      @question.update_attributes(status: @status)
      redirect_to action: "show", id: question_id
    elsif status == 'Deactivate_index'
      flash[:notice] = "The question poll is now close"
      @question.update_attributes(status: @status)
      redirect_to questions_path
    elsif status == 'Reset'
      flash[:notice] = "The question poll is now reset"
      @question.update_attributes(response1: @status)
      @question.update_attributes(response2: @status)
      @question.update_attributes(response3: @status)
      @question.update_attributes(response4: @status)
      @question.update_attributes(response5: @status)
      @question.update_attributes(response6: @status)
      @question.update_attributes(total_responses: @status)
      @histories.each do |history|
        history.destroy
      end
      redirect_to action: "show", id: question_id
    elsif status == "Enable"
      flash[:notice] = "The chart can now be downloaded"
      @question.update_attributes(downloadable: @status)
      redirect_to action: "show", id: question_id
    elsif status == "Disable"
      flash[:notice] = "The chart cannot now be downloaded"
      @question.update_attributes(downloadable: @status + 1)
      redirect_to action: "show", id: question_id
   
    end
  end


  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :answer1, :answer2, :answer3, :answer4, :answer5, :answer6, :poll_id, :lecturer_id, :access_code, :chart_style)
    end
  end
