require 'rails_helper'

RSpec.describe('Users', type: :request) do
  let(:user) { create(:user, :admin) }

  it('creates a user and redirects to the index page') do
    sign_in(user)
    get(new_user_path)
    expect(response).to render_template(:new)
    attributes = FactoryGirl.attributes_for(:user,
                                            name: 'Cornelius Fudge',
                                            email: 'fudge@magic.io')

    post(users_path, params: { user: attributes })

    expect(response).to redirect_to(users_path)
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response.body).to include(t('users.create.success'))
    expect(response.body).to include('Cornelius Fudge')
    expect(response.body).to include('fudge@magic.io')
  end

  it('renders new if trying to create with invalid attributes') do
    sign_in(user)
    get(new_user_path)
    expect(response).to render_template(:new)
    attributes = FactoryGirl.attributes_for(:user,
                                            name: nil)

    post(users_path, params: { user: attributes })

    expect(response).to render_template(:new)
    expect(response).to have_http_status(422)
    expect(response.body).to include(t('errors.messages.blank'))
  end

  it('updates user and returns to edit page') do
    sign_in(user)
    user = create(:user, name: 'Harry Potter')
    get(users_path)
    expect(response).to render_template(:index)
    expect(response.body).to include(user.name)

    get(edit_user_path(user))
    expect(response).to render_template(:edit)

    patch(user_path(user),
          params: { user: { name: 'Cornelius Fudge' } })
    expect(response).to redirect_to(edit_user_path(user))
    follow_redirect!
    expect(response.body).to include('Cornelius Fudge')
  end

  it('destroys user and returns to index') do
    sign_in(user)
    user = create(:user)

    get(edit_user_path(user))

    delete(user_path(user))
    expect(response).to redirect_to(users_path)
    follow_redirect!
    expect(response.body).to include(t('users.destroy.success'))
  end
end
