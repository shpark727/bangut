class HomeController < ApplicationController

require 'digest/md5'


  def index
	@d = User.all
	@b= FacebookUser.all
	@c = Token.all
	@term = Term.all	
	@list = WantedBoard.all	
	@univ = UnivCategory.all
	
  end
  
  def abcd
    a = DateTime.new(2009,01,01,0,0,0)
    
    @u = User.new
    @u.email = params[:email]
    @u.name = params[:name]
    @u.password = params[:password]
    @u.created_date = Time.now.in_time_zone('Seoul')
    @u.save
		#redirect_to '/'

    
  end

  def signup
    @check = Hash.new
    
    @user = User.new
    @user.email = params[:email]
    @user.password = Digest::MD5.hexdigest(params[:password])
    @user.name = params[:name]
    #@user.created_date = Time.now.in_time_zone('Seoul')
    #@u.profile_img = profile_pool의 id
    if params[:name].blank? ||  User.where(name: params[:name] ).take.present? || User.where(email: params[:email]).take.present? 
      @check = {"success":false, "comment":"이미 존재하는 아이디입니다. 다시 시도해주세요"}
    else
      @user.save
      @check= {"success":true, "comment":"가입이 완료되었습니다" }
    end
    
    respond_to do |format|
    	format.json {render json: @check }
    end
  end

  def signin
    @check = Hash.new
    @user = User.where(email: params[:email], password: Digest::MD5.hexdigest(params[:password]) ).take
    
    unless @user.nil?
			
      @a = Token.new
			@a.utoken = SecureRandom.hex(3)
			@a.user_id = @user.id
      @a.save
			@user.user_token = @a.utoken
			@user.save
      @check={"success":true,"comment":"로그인에 성공하였습니다","token":@a.utoken}
    else
      @check = {"success":false,"comment":"로그인에 실패하였습니다. 다시 시도해주세요"}
    end
    
    respond_to do |format|
        format.json { render json: @check }   
      end
  end

  def signout
		token = Token.where(utoken: params[:u_token]).take
		token.destroy 
    redirect_to '/'
    
  end
  
  def fb_create
	user = FacebookUser.omniauth(env['omniauth.auth'])
	session[:user_id] = user.id
	redirect_to '/'

  end

  def fb_destroy
	session[:user_id] = nil
	redirect_to '/'
  end
  
  def user #유저 정보보기
   	@check = Hash.new
		@check = {"success":false, "comment":"로그인해주세요~"}
		token = Token.where(utoken: params[:u_token]).take

		unless token.nil?	
    	@user = User.find(token.user_id)
    		unless @user.nil?
		 			@check = {"success":true,"token":@user.user_token,"user_name":@user.name,"user_id":@user.email}
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
			@user = User.find(token.user_id)
    		unless @user.nil?
						if User.where(name: params[:name] ).take.present? and params[:name] != @user.name
							@check = {"success":false,"comment":"이미 존재하는 이름입니다."}
						else
      				@user.name= params[:name]
      				@user.save
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
    u = User.where(email: emailaddr).take
    unless u.nil?
      @check = {"success":true, "comment":"변경된 비밀번호를 메일로 보냈습니다. 확인해주세요"}
      temp_password  = SecureRandom.hex(3)
      u.password = Digest::MD5.hexdigest(temp_password)
      u.save
      Pwmailer.findpw_mail(emailaddr,temp_password).deliver_now
    else
      @check={"success":false,"comment":"등록된 이메일이 없습니다. 다시 확인해주세요!"}
    end
    
      respond_to do |format|
        format.json {render json: @check}
      end
    
  end
  
  def terms #이용약관 보기
    @term = Term.last(1)
    
    respond_to do |format|
        format.json {render json: @term}
      end
      
  end
  
  def terms_write #이용약관 만들기
    @newTerm = Term.new
    @newTerm.term_code = params[:term_code]
    @newTerm.term_content = params[:term_content]
    @newTerm.save
    
    redirect_to '/'
  end
  
  def post_list #현상수배 리스트
		post = WantedBoard.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.json {render json: post}
    end
  end
  
  def post_detail #현상수배글 상세보기
    post = WantedBoard.find(params[:wanted_board_id]) ######################################이렇게 해두됨?.?
    
    unless post.nil?
      respond_to do |format|
        format.json {render json: post}
      end
    end
  end
  
  def post_sort # 학교별,성별,금액별 소팅해서보기
		 
		if params[:univ].present? and params[:sex].present? and params[:reward].present? 
				if params[:reward] == 0 #현상수배  내림차순
					@post = WantedBoard.where(:univ_id => params[:univ], :target_gen => params[:sex]).order('reward DESC').paginate(:page => params[:page], :per_page => 5)
				else
					@post = WantedBoard.where(:univ_id => params[:univ], :target_gen => params[:sex]).order('reward ASC').paginate(:page => params[:page], :per_page => 5)
				end
		
		elsif params[:univ].present? and params[:sex].present?
				@post = WantedBoard.where(:univ_id => params[:univ], :target_gen => params[:sex]).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)

		elsif params[:univ].present? and params[:reward].present?
				if params[:reward]==0 #수배금 내림차순
					@post = WantedBoard.where(:univ_id => params[:univ]).order('reward DESC').paginate(:page => params[:page], :per_page =>5)
				else
					@post = WantedBoard.where(:univ_id => params[:univ]).order('reward ASC').paginate(:page => params[:page], :per_page =>5)
				end

		elsif params[:sex].present? and params[:reward].present?
				if params[:reward] == 0 #수배금 내림차순 
					@post = WantedBoard.where(:target_gen => params[:sex]).order('reward DESC').paginate(:page => params[:page], :per_page =>5)
				else	
					@post = WantedBoard.where(:target_gen => params[:sex]).order('reward ASC').paginate(:page => params[:page], :per_page =>5)
				end
		elsif params[:univ].present?
					@post = WantedBoard.where(:univ_id => params[:univ]).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)
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
    user = User.find(token.user_id)
		univ = UnivCategory.where(univ_name: params[:univ_name]).take
    @check = Hash.new
   	@check = {"success":false} 
   	unless token.nil? 
			user = User.find(token.user_id)
				unless user.nil?
	   	 		newpost = WantedBoard.new
    			newpost.univ_id = univ.id
    			newpost.witness_date = params[:witness_date]
   				newpost.is_place_maps = params[:is_place_maps]
    			newpost.target_body = params[:target_body]
    			newpost.target_hair = params[:target_hair]
    			newpost.target_tall = params[:target_tall]
    			newpost.target_initial = params[:target_initial]
    			newpost.target_gen = params[:target_gen]
    			newpost.talk_to = params[:talk_to]
    			newpost.reward = params[:reward]
    			newpost.user_id = user.id #######################################################이렇게 가능한가? a.id user_id 타입이 인티져던데.. 
    			newpost.save
   					if newpost.new_record?
      				@check = {"success":false, "comment":"Error. 다시 시도해주세요."}
						else 
      				@check = {"success":true, "comment":"good! 글이 성공적으로 게시되었습니다."}
   				  end
				else
				end
		else
		end
    respond_to do |format|
        format.json {render json: @check }
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
			
     	if edit.user_id == user.id ######################################################가능 ?.?
         	 edit.witness_date = params[:witness_date]
     	  	 edit.is_place_maps = params[:is_place_maps]
      		 edit.witness_place = params[:witness_place]
        	 edit.target_body = params[:target_body]
      	   edit.target_hair = params[:target_hair]
       	   edit.target_tall = params[:target_tall]
           edit.target_initial = params[:target_initial]
           edit.target_gen = params[:target_gen]
           edit.talk_to = params[:talk_to]
           edit.reward = params[:reward]
           edit.save
           @check = { "success":true, "comment":"글 수정이 완료되었습니다."}
    	else
    	end
		end
     respond_to do |format|
              format.json {render json: @check }
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
    
   			if delete.user_id == user.id #########################################################가능?.?
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
		@check = {"success":true, "comment":"답변채택 권한이 없습니다."}
		if token.nil?
		else
			user = User.find(token.user_id)
			post = WantedBoard.find(params[:wanted_board_id])
			if post.user_id == user.id	
					post.choosed_id = params[:wanted_reply]
					post.save
					@check = {"success":true, "comment":"답변을 채택하였습니다."}
			else
			end
		end
			respond_to do |format|
				format.json { render json: @check }
			end

  end
  
  def pay  #결재하기
  end
  
  def pay_term #결재 약관보기
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
    end
			respond_to do |format|
				format.json {render json: @check}
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
		if token.nil?
		else
			user = User.find(token.user_id)
			mypost = WantedBoard.where(:user_id => user.id).order('created_at DESC').paginate(:page => params[:page], :per_page =>5)	
		
    respond_to do |format|
        format.json {render json: mypost }
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
    	mycomment = WantedComment.where(user_id: user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    	respond_to do |format|
        format.json {render json: mycomment }
      end
		end
    
  end
  
  def notice #공지사항
		notice = Notice.all.reverse

		respond_to do |format|
			format.json {render json: notice}
		end

		
  end

  def versions # 방긋 버전보기 
		@version = AppVersion.last(1)

		respond_to do |format|
			format.json {render json: @version }
		end
  end
  
  def image_upload #이미지 업로드
		token = Token.where(utoken: u_token).take
  	user = User.find(token.user_id) 
    myimages = ImagePool.new
    myimages.path = params[:image_file]  #이미지 업로드 ~! 
    myimages.save
		
    #myimage.path.url => 이렇게하면 출력! 
    @imagepool = ImagePool.all 
  end
  
  def alarm_list #알람리스트
  end
  
  def alarm_push #알람 켜고끄기
  end
  
  def fb_share 
		url = "http://www.facebook.com/sharer.php?u=example.smellthecoffee.co.kr"


		redirect_to url
  end
  
  def tw_share
  end
  
  
end
