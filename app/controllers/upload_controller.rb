require 'itunes/library'
require 'digest/sha1'

class UploadController < ApplicationController
  def uploadItunesXml
    file = params[:itunesXml]
    crypt = Digest::SHA1.hexdigest(params[:email].crypt((rand 10).to_s + (rand 10).to_s + file.original_filename))
    filepath = "tmp/xml/" + crypt + ".xml"
    File.open(filepath, "wb"){|f| f.write(file.read)}
    @library = ITunes::Library.load(filepath)
    # tmp保存
    # チェック
    # OKならDBにメールアドレスとか保存
    # キーは時刻とメールアドレスでハッシュ。
    # アップロードありがとう。な画面にリダイレクト。
    user = User.new
    user.email = params[:email]
    user.library_path = filepath
    user.key = crypt
    user.complete = false

    if user.save
      redirect_to :action=>"complete"
    else
      
    end
  end

  def complete

  end


end

