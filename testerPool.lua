require 'nn'

do
  local testerPool = {}

  function testerPool.getMSE(mNet, teInput, teTarget)
    local criterion = nn.MSECriterion()

    local tePred = mNet:forward(teInput)
    local err = criterion:forward(tePred, teTarget)

    return err
  end

  return testerPool
end
