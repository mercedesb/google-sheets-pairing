# frozen_string_literal: true

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
  CREDENTIALS_PATH = 'gmail_token.yaml'

  def initialize
    super(scope: SCOPE, credentials_path: CREDENTIALS_PATH)
    # Initialize the API
    @service = Google::Apis::GmailV1::GmailService.new
    @service.authorization = authorize
  end

  def create_draft(to:, from:, subject:, body:)
    mail = Mail.new
    mail.to       = to
    mail.from     = from
    mail.subject  = subject
    mail.content_type = 'text/html; charset=UTF-8'
    mail.body = body
    # mail.cc       = params[:email][:cc]
    # mail.bcc      = params[:email][:bcc]

    draft = Google::Apis::GmailV1::Draft.new
    message = Google::Apis::GmailV1::Message.new
    message.raw = mail.to_s
    draft.message = message
    draft_response = @service.create_user_draft('me', draft)
  end

  def list_drafts
    @drafts_response ||= @service.list_user_drafts('me')
  end

  def drafts
    list_drafts.drafts
  end

  def send_draft(draft)
    @service.send_user_draft('me', draft)
  end

  def user_setting_send_as
    @user_setting_send_as ||= @service.get_user_setting_send_as('me', email_address)
  end

  def signature
    @signature ||= user_setting_send_as.signature
  end

  def user_profile
    @user_profile ||= @service.get_user_profile('me')
  end

  def email_address
    @email_address ||= user_profile.email_address
  end
end
