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

require './services/base_google_service'
require 'google/apis/gmail_v1'
require 'mail'

class GmailService < BaseGoogleService
  SCOPE = Google::Apis::GmailV1::AUTH_SCOPE

  def initialize
    super(scope: SCOPE)
    # Initialize the API
    @service = Google::Apis::GmailV1::GmailService.new
    @service.authorization = authorize()
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