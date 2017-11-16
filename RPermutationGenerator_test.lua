require('./RPermutationGenerator.lua')

local RPermutationGenerator_test = {}

function RPermutationGenerator_test.Next_test()
  local nPerms = 10
  local permutGen = RPermutationGenerator({10, 0}, {20, 2}, nPerms)
  local tePerm = permutGen:getNext()

  while tePerm ~= nil do
   print(tePerm)
   tePerm = permutGen:getNext()
  end

end

function RPermutationGenerator_test.all()
  RPermutationGenerator_test.Next_test()
end

RPermutationGenerator_test.all()
