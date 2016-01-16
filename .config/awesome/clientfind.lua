function clientfind (properties)
   local clients = client.get()
   local rv = nil
   for i, c in pairs(clients) do
      if match(properties, c) then
	rv = c
      end
   end
   return rv
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v then
         return false
      end
   end
   return true
end
