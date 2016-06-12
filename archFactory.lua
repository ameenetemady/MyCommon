

do
  local archFactory = {}

  function archFactory.mlp(taParam)
    local mlp = nn.Sequential()

    if taParam.nHiddenLayers == 0 then
      mlp:add(nn.Linear(taParam.nInputs, taParam.nOutputs))
      mlp:add(nn.Sigmoid())
      return mlp
    else
      mlp:add(nn.Linear(taParam.nInputs, taParam.nNodesPerLayer))
      mlp:add(nn.Sigmoid())

      for i=1, taParam.nHiddenLayers do
        mlp:add(nn.Linear(taParam.nNodesPerLayer, taParam.nNodesPerLayer))
        mlp:add(nn.Sigmoid())
      end

      mlp:add(nn.Linear(taParam.nNodesPerLayer, taParam.nOutputs))

      return mlp
    end

  end


  return archFactory
end
