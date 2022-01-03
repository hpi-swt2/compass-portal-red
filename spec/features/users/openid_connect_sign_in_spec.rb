require 'rails_helper'

describe 'Sign In Page', type: :feature do
  it 'has an OpenID Connect button' do
    visit new_user_session_path
    expect(page).to have_css("#openid_connect-signin:enabled")
  end

  context 'with HPI OpenID Connect' do
    context 'with valid credentials' do
      before do
        OmniAuth.config.mock_auth[:openid_connect] = OmniAuth::AuthHash.new(
          provider: 'openid_connect',
          uid: '123545',
          info: {
            first_name: 'First',
            last_name: 'Last',
            email: 'first.last@student.hpi.de'
          }
        )
        visit new_user_session_path
      end

      context 'successful login' do
        before do
          find('#openid_connect-signin').click
        end

        it 'shows a logout link' do
          expect(page).to have_link(nil, href: destroy_user_session_path)
        end

        it 'shows a success flash message' do
          expect(page).to have_css('.alert-success')
        end
      end
    end

    context 'with invalid credentials' do
      before do
        # https://github.com/omniauth/omniauth/wiki/Integration-Testing#mocking-failure
        OmniAuth.config.mock_auth[:openid_connect] = :invalid_credentials
        visit new_user_session_path
      end

      context 'unsuccessful login' do
        before(:all) do
          @omniauth_logger = OmniAuth.config.logger
          # By default, OmniAuth will log to STDOUT
          # https://github.com/omniauth/omniauth#logging
          OmniAuth.config.logger = Rails.logger
        end

        before do
          find('#openid_connect-signin').click
        end

        after(:all) do
          OmniAuth.config.logger = @omniauth_logger
        end

        it 'shows a logout link' do
          expect(page).not_to have_link(nil, href: destroy_user_session_path)
        end

        it 'shows a danger flash message' do
          expect(page).to have_css('.alert-danger')
        end

      end
    end
  end
end
