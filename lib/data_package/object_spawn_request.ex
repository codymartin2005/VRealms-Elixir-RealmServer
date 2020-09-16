defmodule DataPackage.ObjectSpawnRequest do
  require Logger
  defstruct [
    command_type: "OBJECT_SPAWN_REQUEST",
    user_id: nil,
    initial_unique_id: nil,
    preferred_id: nil,
    position: %DataPackage.Common.Vector3{},
    authoritarian_id: nil,
    prefab_set_name: nil,
    prefab_name: nil
  ]

  def create_from_payload(payload) do
    %DataPackage.ObjectSpawnRequest{
      user_id: payload["UserId"],
      initial_unique_id: payload["InitialUniqueId"],
      preferred_id: payload["PreferredId"],
      position: %DataPackage.Common.Vector3{
        x: payload["Position"]["x"],
        y: payload["Position"]["y"],
        z: payload["Position"]["z"],
      },
      prefab_set_name: payload["PrefabSetName"],
      prefab_name: payload["PrefabName"]
    }
    end

end
