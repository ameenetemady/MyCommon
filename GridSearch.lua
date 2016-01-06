local GridSearch = torch.class("GridSearch")
local myUtil = require('./util.lua')

function GridSearch:__init(taParam)
  self.taParam = taParam
  self.permutGen = PermutationGenerator.new(taParam.taMetaParamMins, taParam.taMetaParamMaxs)
  self.taHistory = {n=0}
  myUtil.pri_addSize(self.taHistory)
end

function GridSearch:run()
  local teMetaParam = self.permutGen:getNext()

  while teMetaParam ~= nil do -- and self.taHistory:size() < 10 do
    self.taHistory.n = self.taHistory.n + 1

    local teInfo = self.taParam.fuGetCost(teMetaParam)
    table.insert(self.taHistory, teInfo)

    -- Next
    teMetaParam = self.permutGen:getNext()
  end

end
