class ContactFormsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
  end

  def create
    if @contact_form.save
      redirect_to @contact_form
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact_form.update(contact_form_params)
      redirect_to @contact_form
    else
      render 'new'
    end
  end

  def destroy
    contact_form.destroy
    redirect_to contact_forms_path
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:content)
  end
end
