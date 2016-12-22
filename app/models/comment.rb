class Comment < ActiveRecord::Base
	acts_as_tree order: 'created_at DESC'
	belongs_to :article
	belongs_to :user

	def to_digraph_label
	    title
	end
end
