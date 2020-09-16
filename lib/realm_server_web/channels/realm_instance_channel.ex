defmodule RealmServerWeb.RealmInstanceChannel do
  use Phoenix.Channel
require Logger


  @spec join(<<_::64, _::_*8>>, any, any) :: {:ok, any}
  def join("realm_server:" <> realm_id, payload, socket) do
    RealmServer.RealmInstance.start_instance(realm_id)
    socket = assign(socket, :user_id, payload["UserId"])
    socket = assign(socket, :realm_id, realm_id)
    {:ok, socket}
  end

  @spec handle_in(<<_::56>>, any, any) :: {:ok, any}
  def handle_in("new_msg", payload ,socket) do
       {:noreply, socket}
  end

  def handle_in("REALM_JOIN", payload, socket) do

    Logger.info("realm join")
    {:noreply, socket}
  end

  def handle_in("OBJECT_SPAWN_REQUEST", payload, socket) do
    typed_request = DataPackage.ObjectSpawnRequest.create_from_payload(payload)
    response = RealmServer.RealmInstance.spawn_object(typed_request, socket.assigns[:realm_id])
    broadcast socket, "OBJECT_SPAWN_RELAY", response
    {:noreply, socket}
  end

  def handle_in("HUMANOID_POSE", payload, socket) do
    typed_request = DataPackage.HumanoidPose.create_from_payload(payload)

    #we just send this to everyone else but should keep track of the last position.

    broadcast socket, "HUMANOID_POSE", payload
    {:noreply, socket}
  end


  def handle_in(unhandled_request, payload, socket) do
    #Catch all unhandled request types here and drop.
    {:noreply, socket}
  end




  # def join("room:" <> _private_room_id, _params, _socket) do
  #   {:error, %{reason: "unauthorized"}}
  # end
end
