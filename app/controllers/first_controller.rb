# coding: utf-8
require 'itunes/library'


class FirstController < ApplicationController

  def hello
    @msg = 'こんにちは！こんにちは！'
  end

  def bye
    render :text => "Bye!!"
  end

  def lib
    @lib = ITunes::Library.load('/Users/lc_nomoto/Music/iTunes/iTunes Music Library.xml')
  end

end
