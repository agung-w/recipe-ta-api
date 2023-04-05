class TagsController < ApplicationController

  def list
    tags = Tag.all()
    if tags
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "tags": tags.as_json(Tag.tag_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": "Cant process this now"
      },status: :unprocessable_entity 
    end
  end

  def find
    tag=Tag.where(name:params[:name].downcase.tr('^A-Za-z0-9 ', '').squish!).first_or_create
    if tag.save
      render json: {
        "status": 200,
        "message": "Sucess",
        "data": {
          "tag": tag.as_json(Tag.tag_attr)
        }
      }, status: :ok 
    else
      render json:{
        "status": 422,
        "message": tag.errors
      },status: :unprocessable_entity
    end
  end
end
