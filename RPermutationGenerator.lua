local RPermutationGenerator = torch.class("RPermutationGenerator")

function RPermutationGenerator:__init(taMin, taMax, nPerms)
  self.teMin = torch.Tensor(taMin)
  self.teMax = torch.Tensor(taMax)
  self.nSize = self.teMin:size(1)
  self.nPerms = nPerms
  self.teDelta = self.teMax - self.teMin
  self.teLast = self.teMin:clone()
  self.nLast = 0
end

function RPermutationGenerator:Increment()
  if self.nLast < self.nPerms then
    self.teLast = torch.rand(self.nSize)
    self.teLast:cmul(self.teDelta)
    self.teLast:add(self.teMin)
    self.nLast = self.nLast + 1
  else
    self.teLast = nil
  end
end

function RPermutationGenerator:getNext()
  if self.teLast ~= nil then
    self:Increment()
  end

  return self.teLast
end

