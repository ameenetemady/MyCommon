local csv = require("csv")
local myUtil = require('./util.lua')

local dataLoad = {}

do
  function dataLoad.loadTensorFromTsv(taParam)
    local strFilename = taParam.strFilename
    local nCols = taParam.nCols

    local taLoadParams = {header=false, separator="\t"}
    local f = csv.open(strFilename, taLoadParams)

    local taData= {}
    for fields in f:lines() do
      local teRow = torch.Tensor(nCols)
      for i=1, nCols do
        teRow[i] = tonumber(fields[i]) 
      end

      table.insert(taData, teRow)
    end

    local teData = myUtil.getTensorFromTableOfTensors(taData)

    return teData
  end

  function dataLoad.pri_getMasked(teData, teMask)
    local nSize = teData:size(1)
    local nDataWidth = teData:size(2)
    local teDataMask = torch.repeatTensor(teMask, nDataWidth, 1):t()
    local teResult = teData:maskedSelect(torch.ByteTensor(nSize, nDataWidth):copy(teDataMask))
    teResult:resize(teMask:sum(), nDataWidth)

    return teResult
  end

  function dataLoad.loadTrainTest(taParam, nFolds) -- ToDo: not individually tested!
    nFolds = nFolds or 2
    local teInput = dataLoad.loadTensorFromTsv(taParam.taInput)
    local teTarget = dataLoad.loadTensorFromTsv(taParam.taTarget)

    local nSize = teInput:size(1)
    local teIdx = torch.linspace(1, nSize, nSize)

    -- train:
    local trainMask = torch.mod(teIdx, nFolds):eq(torch.zeros(nSize))
    local teTrain_input = dataLoad.pri_getMasked(teInput, trainMask)
    local teTrain_target = dataLoad.pri_getMasked(teTarget, trainMask)
    local taTrain = {teTrain_input, teTrain_target}


    -- test
    local testMask = torch.mod(teIdx, nFolds):ne(torch.zeros(nSize))
    local teTest_input = dataLoad.pri_getMasked(teInput, testMask)
    local teTest_target = dataLoad.pri_getMasked(teTarget, testMask)
    local taTest = {teTest_input, teTest_target}

    return taTrain, taTest

  end

  return dataLoad
end
