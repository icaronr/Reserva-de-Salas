class RoomsController < ApplicationController
	before_action :signed_in?
	before_action :is_admin?, only: [:new, :create, :destroy]
	def new
		@room = Room.new
	end

	def index
		@rooms = Room.all
	end

	def show
		@room = Room.find(params[:id])
	end

	def edit
		@room = Room.find(params[:id])
	end

	def update
		@room = Room.find(params[:id])
		if @room.update(room_params)
			redirect_to @room
			flash[:notice] = "A sala foi editada com sucesso!"
		else
			flash[:danger] = "A sala não pôde ser editada! Tente novamente!"
			render 'edit'
		end
	end

	def create
		@room = Room.new(room_params)
		if @room.save
			flash[:notice] = "A sala foi criada com sucesso!"
			redirect_to backoffice_path
		else
			flash[:danger] = "A sala não pôde ser criada!"
			redirect_to backoffice_path
		end
	end

	def destroy
		@room = Room.find(params[:id])
		@room.destroy
		flash[:danger] = "A sala foi excluída"
		redirect_to backoffice_path
	end

	def free_rooms
		#@free_rooms = Room.all
		@free_rooms = Room.joins(:appointments).where('appointment_date = ? AND start_time = ?', params[:date_search], params[:time_search])

		#if 
		#	redirect_to free_rooms(params[:date_search], params[:time_search]) and return
		#else
			
		#end


		puts @free_rooms.inspect
		puts params.inspect
	end

	private

	def signed_in?
		if current_user
			true
		else
			flash[:danger] = "Você não pode acessar essa página"
			return redirect_to '/'
		end
  	end

	def is_admin?
		if current_user.is_admin
			true
		else
			flash[:danger] = "Você não pode acessar essa página"
			return redirect_to '/'
		end
	end

	def room_params
		params.require(:room).permit(:name, :location)
	end
end
