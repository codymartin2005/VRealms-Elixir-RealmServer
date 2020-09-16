defmodule DataPackage.HumanoidPose do
  require Logger
  defstruct [
    command_type: "HUMANOID_POSE",
    dynamic_elements: [],
    network_id: nil,
    packet_id: nil,
    user_id: nil
  ]

  def create_from_payload(payload) do
    %DataPackage.HumanoidPose{
      user_id: payload["UserId"],
      packet_id: payload["PacketId"],
      network_id: payload["NetworkId"],
      dynamic_elements: payload["DynamicElements"]
    }
  end
end
