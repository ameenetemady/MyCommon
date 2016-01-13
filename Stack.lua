local Stack = torch.class("Stack")

function Stack:__init()
  self._stack = {}
end

function Stack:push(value)
  table.insert(self._stack, 1, value)
end

function Stack:pop()
  local head = self._stack[1]
  table.remove(self._stack, 1)
  return head
end

function Stack:clear()
  self._stack = {}
end

function Stack:isEmpty()
  return #self._stack == 0
end

function Stack.__tostring(selfValue)
  local str = ""
  for key, value in pairs(selfValue._stack) do
    str = str .. value .. ","
  end

  return str
end
