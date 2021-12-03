class Api::V0::CoursesController < ApplicationController

	def create
		course = Course.new(course_params)
		if course.save
			if tutor_params.present?
				begin
					tutor_params[:tutors].each do |tutor_details|
						course.tutors << Tutor.where(name: tutor_details["name"], qualification: tutor_details["qualification"]).first_or_create!
					end
				rescue
					render :json => { :errors => "Check tutor details missing" }, status: :unprocessable_entity and return
				end
			end
			render :json => course.to_json, status: :created
		else
			render :json => { :errors => course.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def index
		render :json => Course.all.to_json(include: :tutors), status: :ok
	end

	private
	def course_params  
    params.require(:course).permit(
      :name,
      :duration
    )
  end
  def tutor_params
  	params.require(:course).permit(
  	  tutors: [:name, :qualification]
  	)
  end
end
