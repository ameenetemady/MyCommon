-- Description: Can track time spent in each block (should work for loops as well)
require 'sys'
local TimeTracker = torch.class("TimeTracker")

function TimeTracker:__init()
	self.taBlocks = { start = 0} -- stores duration of each block
	self.keyPrev = "start"

end

function TimeTracker:start()
	sys.tic()
	self.dPrev = sys.toc()
end

function TimeTracker:r(strName)
	-- update prev
	self.taBlocks[self.keyPrev] = self.taBlocks[self.keyPrev] + sys.toc() - self.dPrev

	-- prepere current
	self.taBlocks[strName] = self.taBlocks[strName] or 0
	self.dPrev =  sys.toc()
	self.keyPrev = strName
end

function TimeTracker:printSummary()
	print("*** TimeTracker Summary (Start) ***")
	-- 0) update the last block
	self.taBlocks[self.keyPrev] = self.taBlocks[self.keyPrev] + sys.toc() - self.dPrev

	-- 1)  construct keys
	local taKeys = {}
	for k in pairs(self.taBlocks) do 
		table.insert(taKeys, k) 
	end

	-- 2) sort the keys
	 table.sort(taKeys)
	 --
	-- 3) print by sorted keys
	 local dSum = 0
   for _, k in ipairs(taKeys) do 
		 local dValue = self.taBlocks[k]
		 dSum = dSum + dValue
		 print(k, dValue) 
	 end

	 print("Total time: " .. dSum)
	print("*** TimeTracker Summary (End) ***")

end
