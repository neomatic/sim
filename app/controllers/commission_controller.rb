class CommissionController < ApplicationController
	before_action :get_params, only: [:calculate]

	def new
		@commission = Commission.new
	end

	def calculate
		@commission = Commission.new(get_params)
		
		if @commission[:friends_a] > @commission[:friends_b]
		    @weak_team = @commission[:friends_b]
		else
		    @weak_team = @commission[:friends_a]
		end
		
		friends_weak = @commission[:num_of_fof]
		
		@friend_bonus = (@commission[:point] * 0.2) * (@commission[:friends_a] + @commission[:friends_b])
		@friend_weak_bonus = ((@commission[:friends_a] + @commission[:friends_b]) * friends_weak / 2.0) * @commission[:point] * 0.1
		@fof_bonus = (@commission[:fof] / 2.0 * (@commission[:friends_a] + @commission[:friends_b]) * @commission[:num_of_fof]) * @commission[:point] * 0.05
		@ct_bonus = @commission[:point] * 1.0 / (@commission[:point] * @commission[:ct_people]) * @commission[:ct_amount] * 0.1
		#@weak_team_bonus = @commission[:point] * @weak_team * 0.2
		@weak_team_bonus = (@weak_team + @fof_bonus + ((@commission[:friends_a] + @commission[:friends_b]) * friends_weak / 2.0)) * 0.2
		@total = @friend_bonus + @weak_team_bonus + @friend_weak_bonus + @fof_bonus + @ct_bonus
	end

	private

		def get_params
			params.require(:commission).permit(:point, :friends_a, :friends_b, :num_of_fof, :fof, :ct_people, :ct_amount)
		end

end