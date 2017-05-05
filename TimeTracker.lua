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
	self.taBlocks[self.keyPrev] = self.taBlocks[self.keyPrev] + sys.toc() - self.dPrev

	-- to Print sorted:
	local tkeys = {}
	for k in pairs(self.taBlocks) do 
		table.insert(tkeys, k) 
	end

-- sort the keys
	 table.sort(tkeys)
	-- use the keys to retrieve the values in the sorted order
   for _, k in ipairs(tkeys) do 
		 print(k, self.taBlocks[k]) 
	 end

end
