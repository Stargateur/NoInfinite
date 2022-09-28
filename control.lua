function destroy_infinite_resource_if_minimum_reach(resource)
  if resource.prototype.infinite_resource then
    if resource.amount <= resource.prototype.minimum_resource_amount then
      resource.destroy()
    else
      -- Hacky
      -- This allow to somehow override the behavior the basic-fluid deplete an either minimum value
      -- or 20% of initial amount.
      resource.initial_amount = resource.amount
    end
  end
end

function on_configuration_changed()
  for _, surface in pairs(game.surfaces) do
    for _, resource in pairs(surface.find_entities_filtered{type = "resource"}) do
      destroy_infinite_resource_if_minimum_reach(resource)
    end
  end
end

local function onResourceDepleted(event)
  destroy_infinite_resource_if_minimum_reach(event.entity)
end

script.on_configuration_changed(on_configuration_changed)
script.on_event(defines.events.on_resource_depleted, onResourceDepleted)