defmodule PhxLearnWeb.ToDoLive.Index do
  use PhxLearnWeb, :live_view

  alias PhxLearn.ToDos
  alias PhxLearn.ToDos.ToDo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :todos, ToDos.list_todos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit To do")
    |> assign(:to_do, ToDos.get_to_do!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New To do")
    |> assign(:to_do, %ToDo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:to_do, nil)
  end

  @impl true
  def handle_info({PhxLearnWeb.ToDoLive.FormComponent, {:saved, to_do}}, socket) do
    {:noreply, stream_insert(socket, :todos, to_do)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    to_do = ToDos.get_to_do!(id)
    {:ok, _} = ToDos.delete_to_do(to_do)

    {:noreply, stream_delete(socket, :todos, to_do)}
  end
end
