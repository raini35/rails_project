class ArticlesController < ApplicationController
	include ArticlesHelper 
	
	def index 
		@articles = Article.all
	end
	
	def show 
		@article = Article.find(params[:id])
		
		@comment = Comment.new 
		@comment.article_id = @article.id
	end 
	
	before_filter :require_login, except: [:index, :show] 
	
	def require_login
		unless current_user 
			redirect_to root_path 
			return false 
		end 
	end 
	
	def new 
		@article = Article.new
	end 
	
	def create
		@article = Article.new(article_params)
		@article.author = current_user
		@article.save
		
		flash.notice = "Article '#{@article.title}' Created!"

		
		redirect_to article_path(@article)
	end
	
	def destroy 
		@article = Article.find(params[:id])
		@article.destroy 
		
		flash.notice = "Article '#{@article.title}' Deleted!"

		
		redirect_to articles_path
	end
before_filter :require_permission, only: [:edit, :update ]

def require_permission
  if current_user != Article.find(params[:id]).author
    redirect_to root_path
    #Or do something else here
  end
end
	def edit 
		@article = Article.find(params[:id])
	end 
	
	def update
		@article = Article.find(params[:id]) 
		@article.update(article_params)
		
  		flash.notice = "Article '#{@article.title}' Updated!"
		
		redirect_to article_path(@article) 
	end 
	
		
end
