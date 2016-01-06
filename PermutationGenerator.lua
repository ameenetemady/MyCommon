local PermutationGenerator = torch.class("PermutationGenerator")
local myUtil = require('./util.lua')

-- Input: two tables for defining the min and max of integer parameters
function PermutationGenerator:__init(taMin, taMax)
  self.teMin = torch.LongTensor(taMin)
  self.teMax = torch.LongTensor(taMax)
  self.nSize = self.teMin:size(1)
  self.teLast = self.teMin:clone()

  -- prepare for the first iteration:
  self.teLast[self.nSize] = self.teLast[self.nSize] - 1
end

function PermutationGenerator:Increment()
  for i = self.nSize, 1, -1 do

    if self.teLast[i] < self.teMax[i] then
      self.teLast[i] = self.teLast[i] + 1
      return

    elseif self.teLast[i] == self.teMax[i] and i ~= 1 then
      self.teLast[i] = self.teMin[i]

    elseif self.teLast[i] == self.teMax[i] and i == 1 then
      self.teLast = nil
      return
    end

  end
end

function PermutationGenerator:getNext()
  if self.teLast ~= nil then
    self:Increment()
  end
  return self.teLast
end

--[[
function PermutationGenerator:__tostring__()
  local strR = "Min:\r\n" .. tostring(self.teMin) .. ", Max:\r\n" .. tostring(self.teMax) 
  return strR
end
--]]
