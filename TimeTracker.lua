-- Description: Can track time spent in each block (should work for loops as well)
require 'sys'
local TimeTracker = torch.class("TimeTracker")

function TimeTracker:__init()
	self.taBlocks = { start = 0} -- stores duration of each block
	self.keyPrev = "start"

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
	print(self.taBlocks)
end
