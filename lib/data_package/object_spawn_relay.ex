defmodule DataPackage.ObjectSpawnRelay do
  defstruct [
    user_id: nil,
    network_id: nil,
    initial_unique_id: nil,
    preferred_id: nil,
    position: %DataPackage.Common.Vector3{},
    authoritarian_id: nil,
    prefab_set_name: nil,
    prefab_name: nil
  ]

  def create_from_request(%DataPackage.ObjectSpawnRequest{} = request) do
      %DataPackage.ObjectSpawnRelay{
        user_id: request.user_id,
        initial_unique_id: request.initial_unique_id,
        preferred_id: request.preferred_id,
        position: %DataPackage.Common.Vector3{
          x: request.position.x,
          y: request.position.y,
          z: request.position.z
        },
        prefab_set_name: request.prefab_set_name,
        prefab_name: request.prefab_name
      }
  end
end
