require 'os'
require('../TimeTracker.lua')

local tr = TimeTracker.new()
tr:start()
os.execute("sleep 1" )
tr:r("A")
os.execute("sleep 1" )
tr:r("B")
os.execute("sleep 1" )
tr:r("C")
os.execute("sleep 1" )
tr:r("B")
os.execute("sleep 1" )


tr:printSummary()
