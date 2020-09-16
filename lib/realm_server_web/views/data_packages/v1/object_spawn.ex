defmodule RealmServerWeb.DataPackages.V1.ObjectSpawn do
  use RealmServerWeb, :view
  def render("response.json", %{data_package: data_package}) do
    %{
      CommandType: "OBJECT_SPAWN_RELAY",
      NetworkId: data_package.network_id,
      PreferredId: data_package.preferred_id,
    InitialUniqueId: data_package.initial_unique_id,
    Position: %{
      x: data_package.position.x,
      y: data_package.position.y,
      z: data_package.position.z
    },
    PrefabSetname: data_package.prefab_set_name,
    PrefabName: data_package.prefab_name,
    AuthoritarianId: data_package.authoritarian_id,
    UserId: data_package.user_id
  }
 end


end
