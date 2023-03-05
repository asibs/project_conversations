class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  # POST /projects/:project_id/comments or /projects/:project_id/comments.json
  def create
    @comment = Comment.new(project: @project, user: current_user, comment: params[:comment][:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_url(@project), notice: "Comment was successfully added." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to project_url(@project), alert: "Comment could not be added." }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end
end
