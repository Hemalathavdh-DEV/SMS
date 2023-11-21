class PostRequestOnlyConstraint
  def matches?(request)
    !request.post?
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #SMS Routes
  namespace :api do
    namespace :v1 do
      scope :sms do
        post "/inbound" => "sms#inbound_sms"
        post "/outbound" => "sms#outbound_sms"
        match '*path', to: 'application#method_not_allowed', via: :all, constraints: PostRequestOnlyConstraint.new
      end
    end
  end
end
