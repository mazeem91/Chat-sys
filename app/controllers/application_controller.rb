class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include SecureRandom
    include ActionController::Serialization
end
