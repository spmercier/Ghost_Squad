Rails.application.config.middleware.use OmniAuth::Builder do
	provider :fitbit, '17e009f76e454acda410d3dbeb59d047','1db1d74a7ecb4e97aa426fa42126edd1'
end