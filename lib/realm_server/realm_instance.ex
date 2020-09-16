defmodule RealmServer.RealmInstance do
  alias RealmServer.{RealmInstance}
  use GenServer, restart: :transient
  require Logger

  defstruct [
    id: nil,
    name: nil,
    topic: nil,
    world_uri: nil,
    asset_id: nil,
    asset_version: nil,
    network_id_incrementer: 100000,
    spawned_objects: [],
    users: []
  ]

  @timeout 600_000

  def start_link(options) do
    GenServer.start_link(__MODULE__, %RealmInstance{}, options)
  end

  @impl true
  def init(game) do
    {:ok, game, @timeout}
  end

  @spec start_instance(any) :: {:ok, pid}
  def start_instance(realm_id) do
    case Registry.whereis_name({RealmServer.RealmInstanceRegistry, realm_id}) do
      :undefined ->
        {:ok, pid} =
          DynamicSupervisor.start_child(RealmServer.RealmInstanceSupervisor, {RealmServer.RealmInstance, name: via_tuple(realm_id)})

        Logger.info("Starting GenServer")
      pid ->
       Logger.info("Already exists...")
    end
  end

  def join(realm_id, payload) do
    GenServer.call(via_tuple(realm_id), {:join, payload})
  end

  @spec spawn_object(any, any) :: any
  def spawn_object(payload, realm_id) do
    GenServer.call(via_tuple(realm_id), {:spawn_object, payload})
  end

  # callbacks

  def handle_call({:join, payload}, pid, state) do
    join_user = %DataPackage.Common.User{name: "test"}
    state = Map.update(state, :users, nil, &([&1 | join_user]))
    Logger.info(Map.get(state, :users))
  end

  def handle_call({:spawn_object, request}, pid, state) do
    state = Map.update(state, :network_id_incrementer, 1, &(&1 + 1))
    converted = DataPackage.ObjectSpawnRelay.create_from_request(request)


    converted= if converted.preferred_id == 0 do
      state = Map.update(state, :network_id_incrementer, 1, &(&1 + 1))
      Logger.info(state.network_id_incrementer)
      converted=Map.put(converted,:network_id, state.network_id_incrementer)
      converted=Map.put(converted, :authoritarian_id, converted.user_id)
      converted
    else
      converted=Map.put(converted,:network_id, converted.preferred_id)
      converted
     end
Logger.info(converted.network_id)
    state = Map.update(state, :spawned_objects, nil, &([&1 | converted]))
    response = RealmServerWeb.DataPackages.V1.ObjectSpawn.render("response.json", %{data_package: converted})

    {:reply, response, state}
  end


  defp via_tuple(name) do
    {:via, Registry, {RealmServer.RealmInstanceRegistry, name}}
  end
end
