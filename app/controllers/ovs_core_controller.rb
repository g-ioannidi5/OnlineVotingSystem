class OvsCoreController < ApplicationController
  

 # @title is to define the title so it can be shown at the top of of the browser
  def index
    @title = 'Home'
  end

  def about
    @title = 'About'
  end

  def contact
    @title = 'Contact'
  end

  def vote
    @title = 'Vote'
    if student_signed_in?
    else
      flash[:alert] = "You must be signed in to vote"
      redirect_to new_student_session_path
    end
  end

  def create_poll
    @title = 'Create_poll'
  end

  def history
    @title = 'History'
    @histories = History.where('student = ?', current_student.id )
  end

  def choose_question
    @method = params[:button]
    @title = 'Please Choose'
    if @method == 'lecturer'
      @param = params[:lecturer][:lecturer]
      @polls_to_display = Poll.where('lecturer_id = ?', @param)
    elsif @method == 'subject'
      @param = params[:subject][:subject]
      @polls_to_display = Poll.where('subject_id = ?', @param)
    end
  end
    
    def page_not_found
        @title = 'Page Not Found'
    
    end
    

  private


end