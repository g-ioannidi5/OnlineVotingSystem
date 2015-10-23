class AccessCodesController < ApplicationController
  before_action :set_access_code, only: [:show, :edit, :update, :destroy]
  


  # GET /access_codes
  # GET /access_codes.json
  def index
    @title = 'Access Codes'
    if lecturer_signed_in?
      @access_codes = AccessCode.where('lecturer_id = ?', current_lecturer.id)
    else
      flash[:alert] = "You have to to be lecturer to access this page"
      redirect_to root_path
    end
  end

  # GET /access_codes/1
  # GET /access_codes/1.json
  def show
    id = params[:id]
    @title = "Show Access Codes"
    @access_code = AccessCode.where('id = ?', id).first
    if @access_code.lecturer_id == current_lecturer.id
    else
        flash[:alert] = "You don't have permission to access this access code"
      redirect_to root_path
    end
  end

  # GET /access_codes/new
  def new
    @title = "New Access Code"
    if lecturer_signed_in?
      @subjects_for_select = Subject.where("lecturer_id = ?", current_lecturer.id )
      if @subjects_for_select.first == nil
        flash[:alert] = "You have to create a subject first"
        redirect_to root_path
      else
        @access_code = AccessCode.new
      end
    else
      flash[:alert] = "You have to to be lecturer to access this page"
      redirect_to root_path
    end
  end

  # GET /access_codes/1/edit
  def edit
    @title = "Edit Access Code"
    id = params[:id]
    @access_code_edit = AccessCode.where('id = ?', id).first
    if @access_code_edit.lecturer_id == current_lecturer.id
    else
      flash[:alert] = "You don't have permission to edit this access code"
      redirect_to root_path
    end
  end

  # POST /access_codes
  # POST /access_codes.json
  def create
    @access_code = AccessCode.new(access_code_params)
    respond_to do |format|
      if @access_code.save
        format.html { redirect_to @access_code, notice: 'Access code was successfully created.' }
        format.json { render :show, status: :created, location: @access_code }
      else
        format.html { render :new }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_codes/1
  # PATCH/PUT /access_codes/1.json
  def update
    respond_to do |format|
      if @access_code.update(access_code_params)
        format.html { redirect_to @access_code, notice: 'Access code was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_code }
      else
        format.html { render :edit }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_codes/1
  # DELETE /access_codes/1.json
  def destroy
    @access_code.destroy
    respond_to do |format|
      format.html { redirect_to access_codes_url, notice: 'Access code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_access_code
      @access_code = AccessCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_code_params
      params.require(:access_code).permit(:code, :valid_until, :lecturer_id, :subject_id)
    end
end
