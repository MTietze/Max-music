class StaticPagesController < ApplicationController

	def home
	  @disable_nav = true
	end
end
