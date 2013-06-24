require 'itunes/library'
require 'digest/sha1'

class UploadController < ApplicationController
  def uploadItunesXml
    file = params[:itunesXml]
    arr = ("a".."z").to_a + ("0".."9").to_a + ("A".."Z").to_a + ['.', '/']
    salt = ""
    2.times { salt += arr[rand(arr.length)] }
    crypt = Digest::SHA1.hexdigest(params[:email].crypt(salt))
    filepath = "tmp/xml/" + crypt + ".xml"
    File.open(filepath, "wb"){|f| f.write(file.read)}
    begin
      @library = ITunes::Library.load(filepath)
    rescue
      # plistじゃなかった。
      render :template => "common/upload_error.html"
      return
    end
    # トラックが0件の場合
    if @library.tracks.size == 0
      render :template => "common/upload_error.html"
      return
    end

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
      # なんだかわからないけどエラー
    end
  end

  def complete
    # nothing to do
  end


end

