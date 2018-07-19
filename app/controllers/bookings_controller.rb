class BookingsController < ApplicationController
  def order
  	byebug
  end
  def bookingform
    
  end
   def bookinglog startdate,enddate,roomtype_id,hotel_id
	    bookinglog = Bookinglog.where(hotel_id: hotel_id.to_i).first
	    booking = bookinglog.booking[roomtype_id.to_i]
	    booking = booking.sort_by{|a| a[:start]}
	    if startdate >= enddate
   			return booking
   		end
   		if startdate < booking[0][:start]
   			return booking
   		end
	    i = 0
	    while 1
	      if booking[i][:start] == startdate && booking[i][:end] == enddate
	        
	        booking[i][:frequency] = booking[i][:frequency] + 1
	        break

	      elsif booking[i][:start] == startdate && booking[i][:end] > enddate
	        
	        oldfreq = booking[i][:frequency]
	        olddate = booking[i][:end]
	        booking[i][:end] = enddate
	        booking[i][:frequency] = booking[i][:frequency] + 1
	        newObj = {start: enddate,end: olddate,frequency: oldfreq,typename:booking[i][:typename],total:booking[i][:total]}
	        booking.insert(i+1,newObj)
	        break

	      elsif booking[i][:start] == startdate && booking[i][:end] < enddate

	        oldfreq = booking[i][:frequency]
	        olddate = booking[i][:end]
	        booking[i][:frequency] = booking[i][:frequency] + 1
	        startdate = olddate

	      elsif booking[i][:start] < startdate && booking[i][:end] > enddate
	        
	        olddate = booking[i][:end]
	        oldfreq = booking[i][:frequency]
	        booking[i][:end] = startdate
	        newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
	        newObj2 = {start: enddate,end: olddate,frequency: oldfreq,typename:booking[i][:typename],total:booking[i][:total]}
	        booking.insert(i+1,newObj1)
	        i = i + 1
	        booking.insert(i+1,newObj2)
	        break

	      elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] == enddate
	       
	        olddate = booking[i][:end]
	        oldfreq = booking[i][:frequency]
	        booking[i][:end] = startdate
	        newObj1 = {start: startdate,end: enddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
	        booking.insert(i+1,newObj1)
	        break

	      elsif booking[i][:start] < startdate && startdate < booking[i][:end] && booking[i][:end] < enddate
	        
	        olddate = booking[i][:end]
	        oldfreq = booking[i][:frequency]
	        booking[i][:end] = startdate
	        newObj1 = {start: startdate,end: olddate,frequency: oldfreq + 1,typename:booking[i][:typename],total:booking[i][:total]}
	        booking.insert(i+1,newObj1)
	        startdate = olddate
	        i = i + 1

	      end
	      i = i + 1
	      if i == booking.length
	        break
	      end
	    end
	    return booking
   end
  def testing
	    startdate = Date.new(params[:startdate].split('-')[0].to_i,params[:startdate].split('-')[1].to_i,params[:startdate].split('-')[2].to_i)
	    enddate = Date.new(params[:enddate].split('-')[0].to_i,params[:enddate].split('-')[1].to_i,params[:enddate].split('-')[2].to_i)
	    hotel_id = params[:hotel_id].to_i
	    roomtype_id = params[:roomtype_id].to_i
	    booking = bookinglog( startdate ,enddate ,hotel_id ,roomtype_id )
	    book = Bookinglog.where(hotel_id: hotel_id).first
	    book.booking[roomtype_id] = booking
	    puts booking
	    # booking = [{start: Date.today-1,end: Date.today + 36523,frequency: 0,typename: Roomtype.find(roomtype_id).typename,total: Roomtype.find(roomtype_id).rooms}]
	    # puts booking
	    # book.booking[roomtype_id] = booking
	    book.save
	    return redirect_to '/bookings/bookingform'
  end
end
