# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# https://github.com/google/google-api-ruby-client/blob/master/samples/cli/lib/samples/gmail.rb

require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'mail'

class GmailService

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  CLIENT_SECRETS_PATH = 'client_secret.json'.freeze
  CREDENTIALS_PATH = 'token.yaml'.freeze
  SCOPE = Google::Apis::GmailV1::AUTH_SCOPE

  def initialize
    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)

    @authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    @user_id = 'default'

    # Initialize the API
    @service = Google::Apis::GmailV1::GmailService.new
    @service.authorization = authorize
  end

  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    credentials = @authorizer.get_credentials(@user_id)
    if credentials.nil?
      url = @authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
           "resulting code after authorization:\n" + url
      code = STDIN.gets
      credentials = @authorizer.get_and_store_credentials_from_code(
        user_id: @user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def create_draft()
    mail = Mail.new 
    mail.from     = "devtogetherchi@gmail.com"
    mail.to       = "mercedesrbernard@gmail.com"
    # mail.cc       = params[:email][:cc]
    # mail.bcc      = params[:email][:bcc]
    mail.subject  = "Test"
    mail.body     =  "Test body"

    draft = Google::Apis::GmailV1::Draft.new
    message = Google::Apis::GmailV1::Message.new
    message.raw = mail.to_s
    draft.message = message
    draft_response = @service.create_user_draft("me", draft)
  end

end