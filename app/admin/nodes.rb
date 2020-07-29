ActiveAdmin.register Node do
  permit_params :post_id, :content, :parent_id
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :post_id, :content, :parent_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:post_id, :content, :parent_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
