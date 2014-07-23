class ContactFormsController < ApplicationController
  load_and_authorize_resource :page, find_by: :slug
  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
    @user = User.find(params[:user])
  end

  def create
    if @contact_form.save
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user])
  end

  def update
    if @contact_form.update(contact_form_params)
      redirect_to @page
    else
      render 'new'
    end
  end

  def destroy
    contact_form.destroy
    redirect_to contact_forms_path
  end

  def send_mail
    user = User.find(params[:user])
    sender_email = params[:sender_email]
    questions = @contact_form.questions
    answers = params[:answer]
    title = @contact_form.page.title
    ContactFormMailer.contact_email(user, sender_email, questions, answers, title).deliver
    redirect_to @contact_form.page, notice: t('.question_form_sent')
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:page_id, :user_id, questions_attributes: [:id, :content, :_destroy])
  end
end
