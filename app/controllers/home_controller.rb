class HomeController < ApplicationController

require 'digest/md5'

  def index
  end
  
  def abcd
    a = DateTime.new(2009,01,01,0,0,0)
    
    @u = User.new
    @u.email = params[:email]
    @u.name = params[:name]
    @u.password = params[:password]
    @u.created_date = Time.now.in_time_zone('Seoul')
    @u.save
    
  end

  def signup
    @check = Hash.new
    
    @user = User.new
    @user.email = params[:email]
    @user.password = Digest::MD5.hexdigest(params[:password])
    @user.name = params[:name]
    @user.created_date = Time.now.in_time_zone('Seoul')
    #@u.profile_img = profile_pool의 id
    if params[:name].blank || ( @user.password != Digest::MD5.hexdigest(params[:password_re]) ) 
      @check["success"] = false
    else
      @user.save
      @check["success"] = true
    end
    
    respond_to do |format|
          format.json {render json: @check}
        end
  end

  def signin
    @check = Hash.new
    @user = User.where(email: params[:email], password: Digest::MD5.hexdigest(params[:password]) ).take
    
    unless @user.nil?
      @check["success"] = true
      @user.token = SecureRandom.hex(3)
      @user.save
      @a = Token.new
      @a.utoken = @user.token
      @a.save
    else
      @check["success"] = false
    end
    
    respond_to do |format|
        format.json { render json: @check }   
      end
  end

  def signout
    
    @token = Token.all
    @token.destroy
    
    redirect_to '/'
    
  end
  
  def loginfacebook
  end
  
  def user #유저 정보보기
    @user = User.where(token: Token.select(:utoken).distinct).take
    @check = Hash.new
    @check["success"] = false
    
    unless @user.nil?
      respond_to do |format|
        format.json {render json: @user}
      end
    else
      respond_to do |format|
        format.json {render json: @user}
      end
    end
  end
  
  def edit_user #유저 정보수정
    @user = User.where(token: Token.select(:utoken).distinct).take
    @check = Hash.new
    
    unless @user.nil?
      @user.name= params[:name]
      #@u.profile_img =
      @user.save
      @check["success"] = true
    else
      @check["success"] = false
    end 
    
    respond_to do |format|
        format.json {render json: @check }
      end
    
  end
  
  def edit_pw_user
    @check = Hash.new
    @check["success"] = false
    
    @user = User.where(token: Token.select(:utoken).distinct).take
    unless @user.nil?
      if @user.password == Digest::MD5.hexdigest(params[:cur_password])
        if changepassword == changepassword_re
          @user.password = Digest::MD5.hexdigest(params[:changepassword])
          @user.save
          @check["success"] = true
        end
      end
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
      @check["success"] = true
      u.password = SecureRandom.hex(3)
      a = u.password
      u.save
      Pwmailer.findpw_mail(emailaddr,a).deliver_now
    else
      @check["success"] =false
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
    @a = WantedBoard.all.reverse ###############################################이렇게 해두됨?.?
                #########pagination 
    respond_to do |format|
      format.json {render json: @a}
    end
  end
  
  def post_detail #현상수배글 상세보기
    @a = WantedBoard.find(wanted_board_id) ######################################이렇게 해두됨?.?
    
    unless @a.nil?
      respond_to do |format|
        format.json {render json: @a}
      end
    end
  end
  
  def post_sort # 학교별,성별,금액별 소팅해서보기
    
  end

  def create_post #현상수배 글쓰기 
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    @check = Hash.new
    
    @p = WantedBoard.new
    @p.univ_id = params[:univ_id]
    @p.witness_date = params[:witness_date]
    @p.is_place_maps = params[:is_place_maps]
    @p.target_body = params[:target_body]
    @p.target_hair = params[:target_hair]
    @p.target_tall = params[:target_tall]
    @p.target_initial = params[:target_initial]
    @p.target_gen = params[:target_gen]
    @p.talk_to = params[:talk_to]
    @p.reward = params[:reward]
    @p.user_id = user.id #######################################################이렇게 가능한가? a.id user_id 타입이 인티져던데.. 
    @p.created_date = Time.now.in_time_zone('Seoul')
    @p.save
    
    if @p.save?
      @check["success"] = true

    else
      @check["success"] = false
    end
    respond_to do |format|
        format.json {render json: @check }
      end
  end
  
  def edit_post #현상수배 수정하기
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    @a = WantedBoard.find(wanted_board_id)
    @check = Hash.new
    @check["success"] = false
    
    if @a.user_id == user.id ######################################################가능 ?.?
        @a.witness_date = params[:witness_date]
        @a.is_place_maps = params[:is_place_maps]
        @a.witness_place = params[:witness_place]
        @p.target_body = params[:target_body]
        @p.target_hair = params[:target_hair]
        @p.target_tall = params[:target_tall]
        @p.target_initial = params[:target_initial]
        @p.target_gen = params[:target_gen]
        @p.talk_to = params[:talk_to]
        @p.reward = params[:reward]
        @p.save
        
        if @p.save?
            @check["success"] = true
        else
        end
    else
    end
     respond_to do |format|
              format.json {render json: @check }
            end
        
  end
  
  def delete_post #현상수배 글삭제
    toke = Token.last(1)
    @user = User.where(token: toke.utoken).take
    
    @a = WantedBoard.find(wanted_board_id)
    
    if @a.user_id == @user.id #########################################################가능?.?
      @a.destroy
    end
    
    redirect_to '/'
  end
  
  def answer_post
  end
  
  def pay  #결재하기
  end
  
  def pay_term #결재 약관보기
  end
  
  def create_reply #댓글쓰기
    toke = Token.last(1)
    @user = User.where(token: toke.utoken).take
    
    @reply = WantedComment.new
    @reply.post_id = params[:post_id]
    @reply.user_id = @user.id
    @reply.content = params[:content]
    @reply.created_date = Time.now.in_time_zone('Seoul')
    @reply.save
    
    
  end
  
  def edit_reply #댓글 수정하기
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    reply = WantedComment.find(reply_id)
    if @reply.user_id == user.id
      reply.content = params[:content]
      reply.save
    else
    end
    
    redirect_to '/'
    
  end 

  def delete_reply #댓글 삭제하기
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    reply = WantedComment.find(reply_id)
    if reply.user_id == user.id
      reply.destroy
    else
    end
    
    redirect_to '/'
  
  end
  
  def mypage_post #내가쓴 글리스트 
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    @mypost = WantedBoard.where(user_id: user.id).all.reverse
    
    respond_to do |format|
        format.json {render json: @mypost }
      end
    
  end
  
  def mypage_reply #내가쓴 댓글리스트
    toke = Token.last(1)
    user = User.where(token: toke.utoken).take
    
    @mycomment = WantedComment.where(user_id: user.id).all.reverse
    respond_to do |format|
        format.json {render json: @mypost }
      end
    
  end
  
  def notice #공지사항
  end

  def versions # 방긋 버전보기 
  end
  
  def image_upload #이미지 업로드
    myimage = ImagePool.new
    myimage.path = params[:myimg]  #이미지 업로드 ~! 
    myimage.save
    
    # myimage.path.url => 이렇게하면 출력! 
    
  end
  
  def alarm_list #알람리스트
  end
  
  def alarm_push #알람 켜고끄기
  end
  
  def share_facebook 
  end
  
  def share_twitter
  end
  
  
end
