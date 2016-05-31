ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
		
		columns do 

			column  max_width: "800px", min_width: "700px" do
				panel "Recent Posts" do
					table_for WantedBoard.order('id desc').limit(15) do
						column("Id") { |post| link_to(post.id) }	
						column("Text") {|post| link_to(post.talk_to)	}
						column("Drawing") {|post| image_tag post.draw_img, class: 'my_image_size'	}
						column("Reward") {|post| link_to(post.reward)	}
						column("Author_id") {|post| link_to(post.user_id) } 
						column("Winner_id") {|post| link_to(post.choosed_id) }
					  column("Delete") 	 
					end
				end
			end

			column  max_width: "400px", min_width: "100px" do
				panel "Recent Users" do
					table_for User.order('id desc').limit(10).each do |user|
						column(:id)			{|user| user.id}
						column(:email)		{|user| link_to(user.email) }
						column(:name)			{|user| user.name}
						column(:created_at) {|user| user.created_at}
					end
				end
			end

		end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
