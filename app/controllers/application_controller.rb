class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

    protected
    def check_admin_priv
    if !current_admin
      redirect_to root_path
    end

   end
end
