class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  
  
  @access_codes = @@access_codes = AccessCode.where("code  = ? AND valid_until >= ?", @access_code,  Date.today).first

  # GET /polls
  # GET /polls.json
  def index
    @title = 'Polls'
    @access_code = session[:access_code]
    @valid_code = session[:valid_code] 
    if defined?(@valid_code)
      if @valid_code  == "valid"
        @polls = Poll.where('access_code = ?', @access_code)
      elsif lecturer_signed_in?
        @polls = Poll.where('lecturer_id = ? OR access_code_lecturer = ?', current_lecturer.id, current_lecturer.id)
      else
        flash[:alert] = "You have to be lecturer or have a valid code to access this page"
        redirect_to enter_access_code_path
      end
    elsif lecturer_signed_in?
      @polls = Poll.where('lecturer_id = ? OR access_code_lecturer = ?', current_lecturer.id, current_lecturer.id)
    else
      flash[:alert] = "You have to be lecturer or have a valid code to access this page"
      redirect_to enter_access_code_path
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @title = 'Show Poll'
    @access_code2 = session[:access_code]
    @valid_code = session[:valid_code]
    if defined?(@valid_code)
      if @valid_code == "valid"
          if @poll.access_code == @access_code2 
            @access_code = AccessCode.where("code = ? AND valid_until >= ?", @access_code,  Date.today).first
          else
            flash[:alert] = "You don't have access to this poll"
            redirect_to questions_path
          end
      elsif lecturer_signed_in?
        if @poll.lecturer_id == current_lecturer.id || @poll.access_code_lecturer == current_lecturer.id
        else
          flash[:alert] = "You don't have access to this poll"
          redirect_to poll_path
        end
      else
          flash[:alert] = "Please sign in first"
          redirect_to root_path
      end
   elsif lecturer_signed_in
        if @poll.lecturer_id == current_lecturer.id || @poll.access_code_lecturer == current_lecturer.id
        else
          flash[:alert] = "You don't have access to this poll"
          redirect_to poll_path
        end
      else
          flash[:alert] = "Please sign in first"
          redirect_to root_path
      end
  end

  def enter_access_code
    @title = 'Enter Access Code'
    @@access_codes = 1
  end

  # GET /polls/new
  def new
    @title = 'New Poll'
    @access_code2 = session[:access_code] 
    @valid_code = session[:valid_code]
    @access_codes = Poll.where("access_code = ?", @access_code2).first
    @access_code =  AccessCode.where("code = ? AND valid_until >= ?", @access_code2, Date.today).first
    if defined?(@valid_code)
      if @valid_code == "valid"
          if @access_codes == nil
            @subjects_for_select = Subject.where("subject = ?", @access_code.subject)
            if @subjects_for_select == nil
                flash[:alert] = "Your lecturer has to create a subject first"
                redirect_to root_path
            else
                @poll = Poll.new
            end
          else
              flash[:alert] = "Each Access code must be used only once"
                redirect_to polls_path
          end
      elsif lecturer_signed_in?
        @subjects_for_select = Subject.where("lecturer_id = ?", current_lecturer.id )
        if @subjects_for_select.first == nil
          flash[:alert] = "You have to create a subject first"
          redirect_to root_path
        else
          @poll = Poll.new
        end
      else
        flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
        redirect_to root_path
      end
    elsif lecturer_signed_in?
      @subjects_for_select = Subject.where("lecturer_id = ?", current_lecturer.id )
      if @subjects_for_select.first == nil
        flash[:alert] = "You have to create a subject first"
        redirect_to root_path
      else
        @poll = Poll.new
      end
    else
      flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
      redirect_to root_path
    end
  end

  # GET /polls/1/edit
  def edit
    @title = 'Edit Poll'
    id = params[:id]
    @poll = Poll.where('id = ?',id).first 
    @access_code2 = session[:access_code] 
    @valid_code = session[:valid_code] 
    if defined?(@valid_code)
      if @valid_code == 'valid'
        if @access_code2 == @poll.access_code
          @access_code = AccessCode.where("code = ?", @access_code2).first
        else
          flash[:alert] = "You don't have permission to edit this poll"
          redirect_to questions_path
        end
      elsif lecturer_signed_in?
        if @poll.lecturer_id == current_lecturer.id || @poll.access_code_lecturer == current_lecturer.id
        else
          flash[:alert] = "You don't have permission to edit this poll"
          redirect_to root_path
        end
      else
        flash[:alert] = "You have to to be lecturer or have a valid code to access this page"
        redirect_to root_path
      end
    elsif @poll.lecturer_id == current_lecturer.id || @poll.access_code_lecturer == current_lecturer.id
    else
      flash[:alert] = "You don't have permission to edit this poll"
      redirect_to root_path
    end
  end


  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def check_code
    @access_codes_param = params[:code][:code]
   @access_codes = AccessCode.where("code = ? AND valid_until >= ?", @access_codes_param,  Date.today).first
    if @access_codes != nil
     session[:valid_code] = "valid"
     session[:access_code]  = @access_codes.code 
     redirect_to polls_path
    else
      @access_codes = 1
      session[:valid_code] = "invalid"
      session[:access_code]  = []
      flash[:alert] = "Invalid Access Code"
      redirect_to root_path
    end
  end



  def poll_questions
    poll_id = params[:poll_param]
    @questions = Question.where("poll_id = ?", poll_id)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:name, :lecturer_id, :poll_date, :access_code, :access_code_lecturer, :subject_id)
    end
end
