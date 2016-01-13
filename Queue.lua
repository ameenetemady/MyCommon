local Queue = torch.class("Queue")

function Queue:__init()
  self._queue = {}
end

function Queue:enQueue(value)
  table.insert(self._queue, value)
end

function Queue:deQueue()
  local first = self._queue[1]
  table.remove(self._queue, 1)
  return first
end

function Queue:clear()
  self._queue= {}
end

function Queue:isEmpty()
  return #self._queue == 0
end

function Queue:__tostring__()
  return tostring(self._queue)
end
