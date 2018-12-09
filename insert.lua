#!/usr/bin/env lua

if #arg < 2 then
  print('USAGE: insert [data.csv] [dbname]')
  os.exit()
end

local driver = require "luasql.postgres"
env = assert (driver.postgres())
con = assert (env:connect(arg[2]))

file = io.open(arg[1], "r")
if not file then return nil end

io.input(file)
io.read()

function string:split (sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

function isempty(s)
  return s == nil or s == ''
end

for line in file:lines() do
  t = line:split(",")
  cur = assert (con:execute(string.format([[
    select customerid, name from customers where name='%s']], t[1])
  ))
  row = cur:fetch ({}, "a")
  if isempty(row) then
    res_cust = assert (con:execute(string.format([[
      insert into customers values (default, '%s', '%d', '%d', '%s')]],  t[1], t[2], t[3], t[4])
    ))
    print('inserted:', t[1], t[5])
    if not isempty(t[5]) then
      items = t[5]:split("|")
      for k,v in next,items,nil do
        res_order = assert (con:execute(string.format([[
          insert into orders values 
          (default, '%s', (select customerid from customers where name = '%s' order by customerid desc limit 1))]], v, t[1])
        ))
        print('inserted order:', v)
      end
    end
  else
    print('ALREADY:', row.customerid, row.name)
  end
  cur:close()
end

io.close(file)

con:close()
env:close()
