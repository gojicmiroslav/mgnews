module ApplicationHelper
	def flash_class(type)
		case type
  		when 'notice'
  			'alert alert-success'
  		when 'alert'
  			'alert alert-danger'
  		else	
  			type
  		end
	end
end
