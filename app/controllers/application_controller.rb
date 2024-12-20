class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    include ApplicationHelper
    
    def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = 'Please log in.'
        redirect_to login_url
        end
    end
    
    def admin_user
        unless current_user.admin?
        flash[:danger] = 'You are not an admin.'
        redirect_to root_url
        end
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
end
