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
end
