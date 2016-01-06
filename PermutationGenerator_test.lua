require('./PermutationGenerator.lua')

local PermutationGenerator_test = {}

function PermutationGenerator_test.Next_test()
  local permutGen = PermutationGenerator({0, 0}, {2, 2})
  local tePerm = permutGen:getNext()

  while tePerm ~= nil do
   print(tePerm)
   tePerm = permutGen:getNext()
  end

end

function PermutationGenerator_test.all()
  PermutationGenerator_test.Next_test()
end

PermutationGenerator_test.all()
