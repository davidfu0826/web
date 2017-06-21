require 'rails_helper'

RSpec.describe('Sabbatical officers', type: :request) do
  let(:user) { create(:user, :admin) }

  it('creates a sabbatical officer and redirects to the edit page') do
    sign_in(user)
    get(new_sabbatical_officer_path)
    expect(response).to render_template(:new)
    attributes = FactoryGirl.attributes_for(:sabbatical_officer,
                                            name: 'Cornelius Fudge',
                                            email: 'fudge@magic.io')

    post(sabbatical_officers_path, params: { sabbatical_officer: attributes })

    expect(response).to \
      redirect_to(edit_sabbatical_officer_path(assigns(:sabbatical_officer)))
    follow_redirect!

    expect(response).to render_template(:edit)
    expect(response.body).to include(t('sabbatical_officers.create.success'))
    expect(response.body).to include('Cornelius Fudge')
    expect(response.body).to include('fudge@magic.io')
  end

  it('renders new if trying to create with invalid attributes') do
    sign_in(user)
    get(new_sabbatical_officer_path)
    expect(response).to render_template(:new)
    attributes = FactoryGirl.attributes_for(:sabbatical_officer,
                                            name: nil)

    post(sabbatical_officers_path, params: { sabbatical_officer: attributes })

    expect(response).to render_template(:new)
    expect(response).to have_http_status(422)
    expect(response.body).to include(t('errors.messages.blank'))
  end

  it('updates sabbatical officer and returns to edit page') do
    sign_in(user)
    sabbatical = create(:sabbatical_officer, name: 'Harry Potter')
    get(sabbatical_officers_path)
    expect(response).to render_template(:index)
    expect(response.body).to include(sabbatical.name)

    get(edit_sabbatical_officer_path(sabbatical))
    expect(response).to render_template(:edit)
    expect(response.body).to include(t('sabbatical_officers.edit.title'))
    expect(response.body).to include(sabbatical.name)

    patch(sabbatical_officer_path(sabbatical),
          params: { sabbatical_officer: { name: 'Cornelius Fudge' } })
    expect(response).to redirect_to(edit_sabbatical_officer_path(sabbatical))
    follow_redirect!
    expect(response.body).to include('Cornelius Fudge')
  end

  it('destroys sabbatical officer and returns to index') do
    sign_in(user)
    sabbatical = create(:sabbatical_officer)

    get(edit_sabbatical_officer_path(sabbatical))

    delete(sabbatical_officer_path(sabbatical))
    expect(response).to redirect_to(sabbatical_officers_path)
    follow_redirect!
    expect(response.body).to include(t('sabbatical_officers.destroy.success'))
  end
end
