class GameController < ApplicationController
	
	def index
	end
	def getTeamNumber
		@globalObj = GlobalInfo.find_by(id: 1)
		hash_details = {:team_number => @globalObj.team_number}
		new_team_number = @globalObj.team_number+1
		@globalObj.update(team_number: new_team_number)
		render json: hash_details
	end
	def register
		@foundTeam = Team.where(team_number: params[:team_number])		
		flag = false
		if @foundTeam.size >0
			
			@foundTeam.each do |x|
				if x.ipAddress == request.remote_ip
					flag = true
					break
				end
			end
			
			if (flag==true)
			
				hash_details = {:stat => false}
			else
				t1 = Team.new(team_number: params[:team_number])
				t1.ipAddress = request.remote_ip
				@foundTeamLast = Team.where(team_number: params[:team_number]).last
				t1.member_id = @foundTeamLast.member_id+1
				t1.save
				hash_details = {:stat => true, :member_id => t1.member_id, :team_number => t1.team_number}
			end
		else
			t1 = Team.new(team_number: params[:team_number])
			t1.ipAddress = request.remote_ip
			t1.member_id = 1
			t1.save
			hash_details = {:stat => true, :member_id => t1.member_id, :team_number => t1.team_number}
		end
		render json: hash_details, status: :ok
	end
	
	
	def	getClue
		@foundMember = Team.find_by(ipAddress: request.remote_ip)
		if(@foundMember.member_id ==1)
			hash_details = { :clue_number => 1, :team_number=> @foundMember.team_number}
		else
			hash_details = { :clue_number => 2, :team_number=> @foundMember.team_number}
		end
			render json: hash_details, status: :ok
	end
	
	def getLocation
		puts params[:team_number]
		@incomingMem = Team.find_by(team_number: params[:team_number], member_id: params[:member_id])
		if @incomingMem
			@incomingMem.update(building: params[:building], floor: params[:floor], wing: params[:wing])

			if (params[:member_id] = "1")
				@otherMem = Team.find_by(team_number: params[:team_number], member_id: 2)
				
				if( params[:building].casecmp("Academic")==0 && params[:floor].casecmp("3")==0 && params[:wing].casecmp("Middle")==0 && @otherMem.building.casecmp("Academic")==0 && @otherMem.floor.casecmp("2")==0)
					hash_details = {:reached => true}
				else
					hash_details = {:reached => false}
				end
			else
				@firstMem = Team.find_by(team_number: params[:team_number], member_id: 1)
				if( @firstMem.building.casecmp("Academic")==0 && @firstMem.floor.casecmp("3")==0 && @firstMem.wing.casecmp("Middle")==0 && params[:building].casecmp("Academic")==0 && params[:floor].casecmp("2")==0)
					hash_details = {:reached => true}
				else
					hash_details = {:reached => false}
				end
			end
			puts hash_details[:reached]
			render json: hash_details, status: :ok
		else
			puts hash_details[:reached]
			hash_details = {:reached => false}
			render json: hash_details, status: :ok
		end
	end
	
end

