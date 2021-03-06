class Api::TodoItemsController < Api::BaseController
  respond_to :json
  authorize_resource class: 'TodoItem'

  def index
    @todo_items = TodoItem.accessible_by(current_ability)
    respond_with @todo_items
  end

  def show
    @todo_item = TodoItem.accessible_by(current_ability).find(params[:id])
    respond_with @todo_item
  end

  def create
    @todo_item = current_user.todo_items.create(todo_item_params)
    respond_with @todo_item, location: api_todo_item_url(@todo_item)
  end

  def update
    @todo_item = TodoItem.accessible_by(current_ability).find(params[:id])
    @todo_item.update(todo_item_params)
    respond_with @todo_item, location: api_todo_item_url(@todo_item)
  end

  def destroy
    @todo_item = TodoItem.accessible_by(current_ability).find(params[:id])
    @todo_item.destroy
    respond_with @todo_item, location: api_todo_item_url(@todo_item)
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:description, :completed, :due_date)
  end
end
