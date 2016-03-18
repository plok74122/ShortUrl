class ShortUrlController < ApplicationController
  def index
    @short_url = ShortUrlList.new
  end
  def create
    @redirect = params.require(:short_url_list).permit(:redirect)
    # 查詢是不是有建立過相同的短網址 若有直接顯示
    # @exist_redirect  = ShortUrlList.where('redirect = ?' , @redirect[:redirect]).take(1)
    @exist_redirect = ShortUrlList.find_by(redirect: @redirect[:redirect])
    if(@exist_redirect == nil)
      # Creat unique_string and Insert redirect to url
      @create_unique_string = 1
      while @create_unique_string != nil do
        unique_string = SecureRandom.hex(5)
        @create_unique_string = ShortUrlList.find_by(unique_string: unique_string)
      end

      @exist_redirect = ShortUrlList.create(:unique_string => unique_string , :redirect => @redirect[:redirect] , :count => 0)
    end


  end
  def redirect
    @hash = params.permit(:unique_string)
    @exist_redirect = ShortUrlList.find_by(unique_string: @hash[:unique_string])
    @exist_redirect.update(count: @exist_redirect.count+1)
  end
end
