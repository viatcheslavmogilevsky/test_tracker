module ApplicationHelper
	def find_username_by_id(id)
  		User.find(id).name
  	end
end
