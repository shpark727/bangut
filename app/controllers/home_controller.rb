class HomeController < ApplicationController

require 'digest/md5'
require 'digest/sha1'
require 'houston'

	def test
	@d = User.all
	@b= FacebookUser.all
	@c = Token.all
	@term = Term.all	
	@pay_term = PayTerm.all
	@list = WantedBoard.all	
	@univ = UnivCategory.all
	@img = ImagePool.all	
	@fb_user = FacebookUser.all
	@draw = DrawPool.all
	@paylog = PayLog.all
	@item_list = RewardItem.all

			
	end

  def index
	@d = User.all
	@b= FacebookUser.all
	@c = Token.all
	@term = Term.all	
	@pay_term = PayTerm.all
	@list = WantedBoard.all	
	@univ = UnivCategory.all
	@img = ImagePool.all	
	@fb_user = FacebookUser.all
	@draw = DrawPool.all
	@paylog = PayLog.all
	@item_list = RewardItem.all
  end
  
  def signup
    @check = Hash.new
    
    @user = User.new
    @user.email = params[:email]
    @user.password = Digest::MD5.hexdigest(params[:password])
    @user.name = params[:name]
    #@user.created_date = Time.now.in_time_zone('Seoul')
    #@u.profile_img = profile_pool의 id
    if params[:name].blank? 
      @check = {"success":false, "comment":"항목을 빠짐없이 입력해주세요"}
		elsif User.where(name: params[:name]).take.present?
			@check ={"success":false, "comment":"이미 존재하는 이름입니다. 다시 시도해주세요"} 
		elsif User.where(email: params[:email]).take.present?
			@check ={"success":false, "comment":"이미 존재하는 이메일입니다. 다시 시도해주세요"}
    else
      @user.save
      @check= {"success":true, "comment":"가입이 완료되었습니다" }
    end
    
    respond_to do |format|
    	format.json {render json: @check }
			format.html {render html: @check }
    end
  end

  def signin
    @check = Hash.new
    user = User.where(email: params[:email], password: Digest::MD5.hexdigest(params[:password]) ).take
    
    unless user.nil?
			
      mytoken = Token.new
			mytoken.utoken = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Token.exists?(utoken: random_token)
    	end	
		#	@a.utoken = SecureRandom.hex(3)
			mytoken.user_id = user.id
      mytoken.save
			user.user_token = mytoken.utoken
			user.save
      @check={"success":true,"comment":"로그인에 성공하였습니다","token":mytoken.utoken}
			if Device.exists?(user_id: user.id)	
				editDevice = Device.where(user_id: user.id).take
				editDevice.uuid = params[:uuid]
				editDevice.save
			else
				Device.create(user_id: user.id , uuid: params[:uuid] )
			end
    else
      @check = {"success":false,"comment":"로그인에 실패하였습니다. 다시 시도해주세요"}
    end
    
    respond_to do |format|
        format.json { render json: @check }   
				format.html { render html: @check }
      end
  end

  def signout
		token = Token.where(utoken: params[:u_token]).take
			@check = Hash.new
			@check={"success":false, "comment":"로그인 해주세요."}
		if token.nil?
			respond_to do |format|
				format.json { render json: @check }
			end
		else
			token.destroy 
			@check = {"success":true, "comment":"로그아웃 성공"}
			respond_to do |format|
				format.json { render json: @check }
			end
		end
		
  end
  
  def fb_create

  	@check = Hash.new
		@check = {"success":false,"comment":"로그인 실패"}

		face_user = FacebookUser.omniauth(env['omniauth.auth'])
				unless face_user.nil? #  페이스북 계정으로 로그인해 callback 받아온 경우 정상 작동!
						if User.exists?(email: face_user.email) # 이전에 등록한적이 있을 때! 
								user = User.where(email: face_user.email).take
								mytoken = Token.new
								mytoken.utoken = loop do 
									random_token = SecureRandom.urlsafe_base64(nil, false)
									break random_token unless Token.exists?(utoken: random_token)
								end

								mytoken.user_id = user.id
								mytoken.save
								user.user_token = mytoken.utoken 
								user.facebook_token = face_user.oauth_token
								user.save
								@check = {"success":true,"comment":"로그인에 성공하였습니다.","token":user.user_token,"fb_token":user.facebook_token}
						else #페이스북 계정으로 처음 로그인 때!
								user = User.new
								user.email = face_user.email
								user.name = face_user.name
								user.facebook_token = face_user.oauth_token
								user.save
								mytoken = Token.new
									mytoken.utoken = loop do
 			 	 		   		random_token = SecureRandom.urlsafe_base64(nil, false)
     						 		break random_token unless Token.exists?(utoken: random_token)
    							end	
									mytoken.user_id = user.id
     					 		mytoken.save
									user.user_token = mytoken.utoken
									user.save
								@check = {"success":true,"comment":"로그인에 성공하였습니다.","token":user.user_token,"fb_token":user.facebook_token}
								
						end # 
			end # end unless 
	   
    respond_to do |format|
				format.html { render html: @check }
        format.json { render json: @check }   
      end
	
  end

  def fb_destroy
		@check = Hash.new
		token = Token.where(utoken: params[:u_token]).take
		unless token.nil?
			@user = User.find(token.user_id)
			token.destroy 
		
			@check = {"success":true, "comment":"로그아웃되었습니다."}
		#redirect_to "https://www.facebook.com/logout.php?access_token=#{@user.facebook_token}&confirm=#{1}&next=#{"/"}"
		
		else
			@check ={"success":false, "comment":"로그인해주세요."}	
		end
			respond_to do |format|
					format.json {render json: @check }
					format.html {render html: @check }
					end
  end
  
  def user #유저 정보보기
   	@check = Hash.new
		@check = {"success":false, "comment":"로그인해주세요~"}
		token = Token.where(utoken: params[:u_token]).take

		unless token.nil?	
    	user = User.find(token.user_id)
    		unless user.nil?
		 			@check = {"success":true,"token":user.user_token,"user_name":user.name,"user_id":user.email}
    		else
				end
		else
		end

    respond_to do |format|
			format.json {render json: @check }
    end
  end
  
  def edit_user #유저 정보수정
	 	@check = Hash.new
		@check = {"success":false, "comment":"권한이 없습니다"}
		token = Token.where(utoken: params[:u_token]).take
		unless token.nil?
			user = User.find(token.user_id)
    		unless user.nil?
						if User.where(name: params[:name] ).take.present? and params[:name] != user.name
							@check = {"success":false,"comment":"이미 존재하는 이름입니다."}
						else
      				user.name= params[:name]
      				user.save
      				@check = {"success":true, "comment":"이름이 변경되었습니다."}
						end
    		else
    		end 
   	else
		end
		 
    respond_to do |format|
        format.json {render json: @check }
    end
    
  end
  
  def edit_pw_user
    @check = Hash.new
    @check["success"] = false
		token = Token.where(utoken: params[:u_token]).take
		unless token.nil?
			@user = User.find(token.user_id)
    			unless @user.nil?
      				if @user.password == Digest::MD5.hexdigest(params[:password])
        					if params[:new_password] == params[:new_password_confirm]
          						@user.password = Digest::MD5.hexdigest(params[:new_password])
          						@user.save
         						 	@check = { "success":true, "comment":"비밀번호가 변경되었습니다!"}
									else
											@check = { "success":false, "comment":"새로운 비밀번호를 정확하게 입력해주세요."}
        					end
							else
									@check = { "success":false, "comment":"비밀번호가 일치하지 않습니다."}
      				end
					else 
						@check = { "success":false, "comment":"로그인 해주세요!" }
					end
		else
    end

    
    respond_to do |format|
        format.json {render json: @check }
    end
    
  end
  
  def find_pw_user
    @check = Hash.new
    emailaddr = params[:email]
    user = User.where(email: emailaddr).take
    unless u.nil?
      @check = {"success":true, "comment":"변경된 비밀번호를 메일로 보냈습니다. 확인해주세요"}
      temp_password  = SecureRandom.hex(3)
      user.password = Digest::MD5.hexdigest(temp_password)
      user.save
      Pwmailer.findpw_mail(emailaddr,temp_password).deliver_now
    else
      @check={"success":false,"comment":"등록된 이메일이 없습니다. 다시 확인해주세요!"}
    end
    
      respond_to do |format|
        format.json {render json: @check}
      end
    
  end
  
  def terms #이용약관 보기
		last_term = Term.order("created_at").last

 
    respond_to do |format|
				format.json {render json:	last_term}
				format.html {render html: last_term}
      end
      
  end
  
  def terms_write #이용약관 만들기
    newTerm = Term.new
    newTerm.term_code = params[:term_code]
    newTerm.term_content = params[:term_content]
    newTerm.save
    
    redirect_to '/'
  end
	def univ_list

			univ = UnivCategory.select(:id, :univ_code, :univ_name)
			respond_to do |format|
				format.json {render json: univ}
				format.html {render html: univ}
			end
	
	end
  
  def post_list #현상수배 리스트

		
		post = WantedBoard.joins(:user ,:univ_category).select("wanted_board.*, user.name , univ_category.univ_name").order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
		

    respond_to do |format|
      format.json {render json: post}
			format.html {render html: post}
    end
  end
  
  def post_detail #현상수배글 상세보기
		@post = WantedBoard.joins(:user , :univ_category ).select("wanted_board.*, user.name as user_name, univ_category.univ_name").where(id: params[:wanted_board_id]).take
		@comments =  WantedComment.joins(:user).select("wanted_comment.*, user.name as user_name").order('created_at DESC').where(wanted_board_id: params[:wanted_board_id]).all
		if @comments.nil?
			respond_to do |format|
				format.json {render json: @post}
			end
		else
			respond_to do |format|
				format.json {render :json => { :post => @post, :comments =>@comments } }
				end
		end
				
		#if WantedComment.where(wanted_board_id: params[:wanted_board_id]).take.nil?
		#	post = WantedBoard.joins(:user, :univ_category).select("wanted_board.*, user.name, univ_category.univ_name").where(id: params[:wanted_board_id])
	#	else
  #  	post = WantedBoard.joins(:user , :univ_category, :wanted_comments).select("DISTINCT wanted_board.*, user.name, univ_category.univ_name, wanted_comment.*").where(id: params[:wanted_board_id]) #find(params[:wanted_board_id 
  end
	
	def uritest
			a = URI.unescape(params[:kkk])
				respond_to do |format|
    	  format.json {render json: a}
				format.html {render html: a}
     end
	end

			
  
  def post_sort # 학교별,성별,금액별 소팅해서보기
		
		decode_univ = URI.unescape(params[:univ]) 
		unless decode_univ.nil? #univ파라미터 받은경우
				university = UnivCategory.where(:univ_name => decode_univ).take
				univID = university.id
		else
		end
					
		# 대학별, 성별, 현상금순 정렬
		if params[:univ].present? and params[:sex].present? and params[:reward].present? 
				if params[:reward] == 0 #현상수배  내림차순
					@post = WantedBoard.where(:univ_id => univID, :target_gen => params[:sex]).order('reward DESC').paginate(:page => params[:page], :per_page => 5)
				else
					@post = WantedBoard.where(:univ_id => univID , :target_gen => params[:sex]).order('reward ASC').paginate(:page => params[:page], :per_page => 5)
				end
		
		elsif params[:univ].present? and params[:sex].present?
				@post = WantedBoard.where(:univ_id => univID , :target_gen => params[:sex]).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)

		elsif params[:univ].present? and params[:reward].present?
				if params[:reward]==0 #수배금 내림차순
					@post = WantedBoard.where(:univ_id => univID).order('reward DESC').paginate(:page => params[:page], :per_page =>5)
				else
					@post = WantedBoard.where(:univ_id => univID).order('reward ASC').paginate(:page => params[:page], :per_page =>5)
				end

		elsif params[:sex].present? and params[:reward].present?
				if params[:reward] == 0 #수배금 내림차순 
					@post = WantedBoard.where(:target_gen => params[:sex]).order('reward DESC').paginate(:page => params[:page], :per_page =>5)
				else	
					@post = WantedBoard.where(:target_gen => params[:sex]).order('reward ASC').paginate(:page => params[:page], :per_page =>5)
				end
		elsif params[:univ].present?
					@post = WantedBoard.where(:univ_id => univID).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)
		elsif params[:sex].present?
					@post = WantedBoard.where(:target_gen => params[:sex]).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)
		elsif params[:reward].present?
					if params[:reward] == 0
						@post = WantedBoard.all.order('reward DESC').paginate(:page => params[:page], :per_page =>5)
					else 
						@post = WantedBoard.all.order('reward ASC').paginate(:page => params[:page], :per_page =>5)
					end
		else
					@post = WantedBoard.all.order('created_at DESC').paginate(:page => params[:page], :per_page =>5)
		end

		 respond_to do |format|
    	  format.json {render json: @post}
     end

    
  end

  def create_post #현상수배 글쓰기
		token = Token.where(utoken: params[:u_token]).take
		univ = UnivCategory.where(univ_name: params[:univ_name]).take
		pay_log = PayLog.where(pay_key: params[:pay_key]).take

    @check = Hash.new
   	@check = {"success":false} 

   	unless token.nil? 
			user = User.find(token.user_id)
				unless user.nil?
	   	 		newpost = WantedBoard.new
								unless univ.nil?
    							newpost.univ_id = univ.id
								else
								end

					if ( (pay_log.nil?) and (params[:reward]=='0')) 
											
						# 몽타주 크로키  저장  
						myimages = DrawPool.new
						myimages.path = params[:image_file]
						myimages.save!
						# 그 외 정보 
    				newpost.witness_date = params[:witness_date]
   					newpost.is_place_maps = params[:is_place_maps]
						newpost.lat = params[:lat]
						newpost.lon = params[:lon]
    				newpost.target_gen = params[:target_gen]
    				newpost.talk_to = params[:talk_to]
    				newpost.user_id = user.id 
						newpost.reward = "없음"
						#	newpost.draw_img = myimages.path.url
    				newpost.save
						
						unless newpost.new_record?
							myimages.post_id = newpost.id
						  myimages.save
							newpost.draw_img = myimages.path.url
							newpost.save!

     					@check = {"success":true, "comment":"good! 글이 성공적으로 게시되었습니다.","크로키url": myimages.path.url}   				 
						else
      				@check = {"success":false, "comment":"Error2, 다시 시도해주세요"}
						end

					elsif pay_log.nil? 
							@check = {"success":false, "comment":"Error6, 선택한 결제내역이 없습니다."}
					elsif ( pay_log.pay_status == 'success' )
						# 몽타주 크로키  저장  
						item = RewardItem.find(pay_log.item_id)
						myimages = DrawPool.new
						myimages.path = params[:image_file]
						myimages.save!
						# 그 외 정보 
    				newpost.witness_date = params[:witness_date]
   					newpost.is_place_maps = params[:is_place_maps]
						newpost.lat = params[:lat]
						newpost.lon = params[:lon]
    				newpost.target_gen = params[:target_gen]
    				newpost.talk_to = params[:talk_to]
    				newpost.user_id = user.id 
						newpost.reward = item.name
						#	newpost.draw_img = myimages.path.url
    				newpost.save
						
						unless newpost.new_record?
							myimages.post_id = newpost.id
							pay_log.post_id = newpost.id
						  myimages.save
							newpost.draw_img = myimages.path.url
							newpost.save!

     					@check = {"success":true, "comment":"good! 글이 성공적으로 게시되었습니다.","크로키url": myimages.path.url}   				 
						else
      				@check = {"success":false, "comment":"Error2, 다시 시도해주세요"}
						end


					else # pay_log는 있으나, progress 혹은 cancel 된 경우
							@check = {"success":false, "comment":"Error7, 결제가 완료되지 않았습니다."}
					end
						
				else
					@check = {"success":false, "comment":"Error3, 로그인후 시도해주세요."}
				end
		else
			@check = {"success":false, "comment":"Error4, 로그인후 시도해주세요."}
		end
    respond_to do |format|
        format.json {render json: @check }
				format.html {render html: @check }
      end
		
  end

	def pay_result
			
		pay_log = PayLog.where(pay_key: params[:pay_key]).take
		unless pay_log.nil?
			pay_log.imp = params[:imp_uid]
			if params[:imp_success] == "true"
				pay_log.pay_status = "success"
				pay_log.save
			else
				pay_log.pay_status = "cancel"
				pay_log.save
			end
		else
		end

	end
  
  def edit_post #현상수배 수정하기
		token = Token.where(utoken: params[:u_token]).take
  	  @check = Hash.new
    	@check = {"success":"false","comment":"수정 권한이 없습니다."} 
		if token.nil?
		else	
    	user = User.find(token.user_id)
   		edit = WantedBoard.find(params[:wanted_board_id])
			
     	if edit.user_id == user.id 
         	 edit.witness_date = params[:witness_date]
     	  	 edit.is_place_maps = params[:is_place_maps]
           edit.target_gen = params[:target_gen]
					 edit.lat = params[:lat]
					 edit.lon = params[:lon]
           edit.talk_to = params[:talk_to]
           edit.reward = params[:reward]
           edit.save
           @check = { "success":true, "comment":"글 수정이 완료되었습니다."}
    	else
    	end
		end
     respond_to do |format|
              format.json {render json: @check }
							format.html {render html: @check }
            end
        
  end
  
  def delete_post #현상수배 글삭제
    token = Token.where(utoken: params[:u_token]).take
		check = Hash.new
		check = {"success":"fail","comment":"수정 권한이 없습니다."}
		if token.nil?
		else
				user = User.find(token.user_id)
   			delete = WantedBoard.find(params[:wanted_board_id]) 
    
   			if delete.user_id == user.id 
      			delete.destroy
					check = {"success":"success","comment":"글이 삭제 되었습니다."}
    		end
    
 		end
			respond_to do |format|
				format.json { render json: check }
			end
  
	end

  def answer_post #답변 채택 
		token = Token.where(utoken: params[:u_token]).take
		@check = Hash.new
		@check = {"success":false, "comment":"답변채택 권한이 없습니다."}
		if token.nil?
		else
			user = User.find(token.user_id)
			post = WantedBoard.find(params[:wanted_board_id])
			if (post.user_id == user.id) && (post.choosed_id.nil?)	
					post.choosed_id = params[:wanted_reply]
					post.save
					@check = {"success":true, "comment":"답변을 채택하였습니다."}
					#push alarm
					comment_user_id = WantedComment.select(:user_id).where(id: params[:wanted_reply])
					comment_content = WantedComment.select(:content).where(id: params[:wanted_reply])
					comment_device = Device.where(user_id: comment_user_id).take
					unless comment_device.nil? # device token이 없는 경우 . ios simulation
					comment_token = comment_device.uuid
					alarm_push_select(comment_token, comment_content)
					else
					end
			else
				@check ={"success":false, "comment":"채택 권한이 없거나, 이미 답변이 채택되었습니다."}
			end
		end
			respond_to do |format|
				format.json { render json: @check }
				format.html { render html: @check }
			end

  end


	def pay
		token = Token.where(utoken: params[:u_token]).take
		unless token.nil?
			user = User.find(token.user_id)
			item = RewardItem.where(item_code: params[:item_code]).take
			if token.nil? 
				@f = 0
			else
				@f = user.id
			end	
			@a = item.name
			@b = item.price
			@c = params[:pay_key]
			@d = item.id
		else
			@check = Hash.new
			@check = "로그인 해주세요."
			respond_to do |format|
					format.json {render json: @check}
					format.html {render html: @check}
					end
		end
	end
  
  def pay_params  #결재하기
		
    params.require(:pay).permit(:pay_key,:pay_status,:item_id,:user_id,:imp, :merchant, :memo, :tel)

  end

	def pay_refund
		pay = PayLog.find(params[:id])
		pay.pay_status = "request_refund"
		pay.save
		redirect_to '/'
	end

	def admin_refund
		pay = PayLog.find(params[:id])
		pay.pay_status= "refund_success"
		pay.save
		redirect_to '/'
	end
	
	def pay_log
		pay_log = PayLog.where(pay_key: params[:pay_key]).take
		if pay_log.nil?
			pay_log = PayLog.new(pay_params)
			pay_log.save	
		else
		pay_log.pay_status = params[:pay_status]
		pay_log.save
		end
		redirect_to '/'
	end
  
  def pay_term #결재 약관보기
		last_payterm = PayTerm.order("created_at").last

 
    respond_to do |format|
				format.json {render json:	last_payterm}
      end
  
  end

  
  def create_reply #댓글쓰기
		token = Token.where(utoken: params[:u_token]).take
		@check = Hash.new
		if token.nil?
			@check = {"success":false, "comment":"로그인이 필요합니다."}
		else
			user = User.find(token.user_id)

			reply = WantedComment.new
			reply.wanted_board_id = params[:wanted_board_id]
			reply.user_id = user.id
			reply.content = params[:content]
			reply.save		
   		@check = {"success":true, "comment":"댓글이 작성되었습니다."}
			#push alarm
			post_id = params[:wanted_board_id]
			post_user_id = WantedBoard.select(:user_id).where(id: post_id)
			post_content = WantedBoard.select(:talk_to).where(id: post_id)	
			post_device = Device.where(user_id: post_user_id).take
			unless post_device.nil?
				post_token = post_device.uuid
			  alarm_push_comment(post_token , post_content) 
			else
			end
				
			
    end
			respond_to do |format|
				format.json {render json: @check}
				format.html {render html: @check}
				end
  end
  
  def edit_reply #댓글 수정하기
		token = Token.where(utoken: params[:u_token]).take
		@check = Hash.new
		@check = {"success":false,"comment":"권한이 없습니다."}
		if token.nil?
		else
			user = User.find(token.user_id)
			reply = WantedComment.find(params[:reply_id]) 
   		if user.id == reply.user_id
					reply.content = params[:content]
					reply.save
					@check = {"success":true, "comment":"글이 수정되었습니다." }
    	else
    	end
		end
    	respond_to do |format|
				format.json {render json: @check}
			end
    
  end 

  def delete_reply #댓글 삭제하기
		token = Token.where(utoken: params[:u_token]).take
		@check = Hash.new
		@check = {"success":false,"comment":"권한이 없습니다."}
		if token.nil?
		else
			user = User.find(token.user_id)
			reply = WantedComment.find( params[:reply_id])
    	if reply.user_id == user.id
     		 reply.destroy
			@check = {"success":true , "comment":"댓글이 삭제되었습니다."}
    	else
    	end
		end
			respond_to do |format|
				format.json { render json: @check }
			end
    
  end
  
  def mypage_post #내가쓴 글리스트 
		token = Token.where(utoken: params[:u_token]).take
		check= Hash.new
		check ={"success":false, "comment":"로그인 해주세요"}
		if token.nil?
			respond_to do |format|
				format.json {render json: check}
			end
		else
			user = User.find(token.user_id)
			mypost = WantedBoard.joins(:user, :univ_category).select("wanted_board.*, user.name , univ_category.univ_name").where(:user_id => user.id).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)	
		


    respond_to do |format|
        format.json {render json: mypost }
				format.html {render html: mypost }
      end
		end
    
  end
  
  def mypage_reply #내가쓴 댓글리스트
		token = Token.where(utoken: params[:u_token]).take
		check= Hash.new
		check ={"success":false, "comment":"로그인 해주세요"}
		if token.nil?
			respond_to do |format|
				format.json {render json: check}
			end
		else
   		user = User.find(token.user_id) 
    	mycomment = WantedComment.joins(:user, :wanted_board).select("wanted_comment.*, user.name , wanted_board.choosed_id").where(user_id: user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
					if mycomment.nil?
						mycomment = "댓글 내역이 없습니다."
					else
					end
	
	 		respond_to do |format|
 		     format.json {render json: mycomment }
				format.html {render html: mycomment }
 		   end
		end
    
  end

	def pay_list
		@check = Hash.new	
		token = Token.where(utoken: params[:u_token]).take
		if token.nil?	
			@check = {"success":false, "comment":"로그인 해주세요."}
			respond_to do |format|
				format.json {render json: @check }
				end
		else
			pay_log = PayLog.joins(:reward_item).select("pay_log.*, reward_item.name, reward_item.price").where(:user_id => token.user_id).order('id DESC').paginate(:page => params[:page], :per_page => 5)
	
			if pay_log.nil?
					pay_log = "결제 내역이 없습니다"
			else
			end
			respond_to do |format|
				format.json {render json: pay_log }
				end
		end
	end
  
  def notice #공지사항
		notice = Notice.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)

		respond_to do |format|
			format.json {render json: notice}
		end
  end
	
	def item_list
		item = RewardItem.all
			respond_to do |format|
				format.json {render json: item }
				format.html {render html: html }
			end
	end

	def create_notice
		notice = Notice.new
		notice.title  = params[:title]
		notice.content = params[:content]
		notice.save
		redirect_to '/'
	end

	def 

  def versions # 방긋 버전보기 
		@version = AppVersion.last(1)

		respond_to do |format|
			format.json {render json: @version }
		end
  end
  
  def image_upload #이미지 업로드
		token = Token.where(utoken: params[:u_token]).take
		check = Hash.new
		check = {"success":false,"comment":"이미지 업로드에 실패하였습니다.다시 확인해주세요"}
		
		if token.nil?
		else
  		user = User.find(token.user_id) 
			if user.nil?
			else
    		myimages = ImagePool.new
    		myimages.path = params[:image_file]  #이미지 업로드 ~! 
				myimages.user_id = user.id
    		myimages.save
				user.profile_img =myimages.id 
				user.save
				check = {"success":true,"comment":"이미지 업로드에 성공하였습니다.","image_address":myimages.path.url}
			end
		end
			respond_to do |format|
				format.json {render json: check}
				format.html {render html: check}
			end
		
    #myimage.path.url => 이렇게하면 출력! 
  end
  
  def alarm_list #알람리스트
  end
	
	def alarm_push_comment(device_token , post_content) # 내글에 댓글이 달리면 푸시

		apn = Houston::Client.development
		apn.certificate = File.read("apnsdev.pem")		
		token = device_token 
		

		notification = Houston::Notification.new(device: token)
		notification.alert ="내 글에 댓글이 작성되었습니다."
		notification.custom_data={post_content: post_content}
		notification.badge = 1
    notification.sound = "sosumi.aiff"
    notification.content_available = true

		apn.push(notification)
		
	end
  
  def alarm_push_select(device_token, comment_content) # 내 댓글이 채택되면 푸시
		apn = Houston::Client.development
		apn.certificate = File.read("apnsdev.pem")
		token = device_token

		notification = Houston::Notification.new(device: token)
		notification.alert="나의 댓글이 채택되었습니다."
		notification.badge = 1
		notification.custom_data={comment_content: comment_content}
		notification.content_available = true
		apn.push(notification)
  end
  
  def fb_share 
		url = "http://www.facebook.com/sharer.php?u=example.smellthecoffee.co.kr"


		redirect_to url
  end
  
  def tw_share
  end
	
	def privacy_term
	last_term = PrivacyTerm.order("created_at").last

 
    respond_to do |format|
				format.json {render json:	last_term}
				format.html {render html: last_term}
      end

	end


  
  
end
