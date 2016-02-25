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

  return dataLoad
end
