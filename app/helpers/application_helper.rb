module ApplicationHelper
    require 'date'
    def format_date(date_str)
        begin
            date_obj = DateTime.parse date_str
            return date_obj.strftime("%a, %d %b %Y %H:%M:%S")
          rescue ArgumentError => e 
            return 'Wrong Date format'
          end
      end

end
