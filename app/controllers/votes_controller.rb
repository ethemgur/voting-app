class VotesController < ApplicationController

  before_action :find_params, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:new, :show]
  after_filter :search
  def index
    @votes = Vote.search(params[:search])
    @users = User.search(params[:search])
  end

  def show
    @username = User.find(@vote.user_id).username
    if @vote.first_count==0
      @rate = 0
    elsif @vote.second_count==0
      @rate = 100
    else
      @rate = (100*@vote.first_count)/(@vote.second_count+@vote.first_count)
    end
    if user_signed_in?
      @if_not_selected = Selection.where("user_id = ? AND vote_id = ?", current_user.id, @vote.id).empty?
      if @if_not_selected
        unless params[:answer].nil?
          answer = params[:answer]
          if answer.eql? @vote.first_answer
            @vote.first_count += 1
            @vote.save
          elsif answer.eql? @vote.second_answer
            @vote.second_count += 1
            @vote.save
          end
          if (answer.eql? @vote.first_answer) || (answer.eql? @vote.second_answer)
            Selection.create(:user_id => current_user.id, :vote_id => @vote.id, :answer => answer)
            redirect_to vote_path(@vote)
          end
        end
      end
    end
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id

    if @vote.first_answer.empty? or @vote.second_answer.empty? or @vote.question.empty?
      @vote.destroy
      render 'new'
    elsif @vote.first_answer.eql? @vote.second_answer
      @vote.destroy
      render 'new'
    elsif @vote.save
      redirect_to votes_path
    else
      render 'new'
    end
    
  end

  def destroy
    @vote.destroy
    redirect_to votes_path
  end
  
  private
  
  def vote_params
    params.require(:vote).permit(:question, :first_answer, :second_answer)
  end
  
  def find_params
    @vote = Vote.find(params[:id])  
  end

  def search
    unless params[:search].nil? or params[:search].empty?
      search = params[:search]
      @votes = Vote.where(:question => search)
    end
  end
  
end
