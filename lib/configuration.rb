require 'firebase_helper'
module Configuration
  include FirebaseHelper

  def start_support
    set('configuration', { support_active: true }, {})
  end

  def stop_support
    set('configuration', { support_active: false }, {})
  end

  def support_active?
    response = get('configuration/support_active', {})
    response.body
  end
end
