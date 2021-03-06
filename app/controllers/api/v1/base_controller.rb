# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

module Api
  module V1
    # Base Application error
    #
    # All business-logic errors in the application must raise this exception
    # with an explicit error message.
    class ApplicationError < StandardError
      attr_accessor :message

      def initialize(message)
        self.message = message
      end
    end

    # Base APIv1 controller
    #
    # This is the superclass of all APIv1 controllers.
    class BaseController < Api::BaseController
      # Endpoints that don't need authentication must explicitly skip this
      # filter.
      #
      # See https://guides.rubyonrails.org/action_controller_overview.html#filters
      before_action :authenticate_user!

      # Set locale based on user's preference
      before_action :set_locale

      # Endpoints that don't need authorization must explicitly skip this check.
      #
      # See https://github.com/CanCanCommunity/cancancan#lock-it-down
      check_authorization

      # See https://guides.rubyonrails.org/action_controller_overview.html#rescue-from
      rescue_from ApplicationError,
                  with: :application_error
      rescue_from CanCan::AccessDenied,
                  with: :access_denied
      rescue_from ActiveRecord::RecordInvalid,
                  with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound,
                  with: :not_found
      rescue_from ActionController::ParameterMissing,
                  with: :parameter_missing
      rescue_from ActionController::InvalidAuthenticityToken,
                  with: :invalid_authenticity_token

      respond_to :json

      private

      def set_locale
        if user_signed_in?
          I18n.locale = current_user.preference.locale
          return
        end

        I18n.locale = params[:locale] if params[:locale].present?
      end

      def application_error(exception)
        @error = exception.message
        render :error, status: :bad_request
      end

      def access_denied
        @error = translate('errors.messages.forbidden')
        render :error, status: :forbidden
      end

      def record_invalid(exception)
        @error = exception.record.errors
        render :error, status: :bad_request
      end

      def invalid_authenticity_token
        @error = translate('errors.messages.invalid_authenticity_token')
        render :error, status: :forbidden
      end

      def parameter_missing(exception)
        @error = translate('errors.messages.param_missing',
                           param: exception.param)
        render :error, status: :bad_request
      end
    end
  end
end
