require 'nn'
local myUtil = require('./util.lua')
local trainerPool = require('./trainerPool.lua')
local archFactory = require('./archFactory.lua')

do

  local nnUtil = {}

  function nnUtil.getBestTrained(taTaTrain, taTrain, nInits, fuModelFactory, taParam)
    local taMinErr = { trainErr = 9999999, id = nil, seed = nil }

    for i=1,nInits do
      local seed = i
      torch.manualSeed(seed)
      print("*** i=" .. i .. " ***")
      local mlp = fuModelFactory(taParam)

      trainerPool.full_CG(taTaTrain, mlp)
      local trainErr = trainerPool.test(taTrain, mlp)

      if trainErr < taMinErr.trainErr then
        taMinErr.trainErr = trainErr
        taMinErr.id = i
        taMinErr.seed = seed
        taMinErr.mlp = mlp:clone()
      end

    end

    return taMinErr.mlp

  end

  function nnUtil.getBestFnn(taTaTrain, taTrain , nInits, taParam)
    local taMinErr = { trainErr = 9999999, id = nil, seed = nil }

    for i=1,nInits do
      local seed = i
      torch.manualSeed(seed)
      print("*** i=" .. i .. " ***")
      local mlp = archFactory.mlp(taParam)

      trainerPool.full_CG(taTaTrain, mlp)
      local trainErr = trainerPool.test(taTrain, mlp)

      if trainErr < taMinErr.trainErr then
        taMinErr.trainErr = trainErr
        taMinErr.id = i
        taMinErr.seed = seed
        taMinErr.mlp = mlp:clone()
      end

    end

    return taMinErr.mlp

  end

  return nnUtil

end
