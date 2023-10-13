--[[
  Project name: Task Storage Outline
  Last modified: 10/12/23
  Description: Creates, stores, and searches for tasks. Assigns
  an ID, schedule, and description of tasks. A simple outline to
  build upon.
]]

--Define for function use
local tasks = {}
amountOfTasks = 0

-- Create a task to add to a table
function createTask()

  if amountOfTasks == 100 then
    print("Task limit (100) has been reached. No more tasks can be managed.")
    return
  end
  
  -- Define task table
  local task = {}

  local taskID, taskSchedule

  while not taskID or taskID < 0 do
    -- User input ID
    io.write("Enter task ID: ")
    -- Changes the user input to a number
    taskID = tonumber(io.read())

    -- Check if user input invalid ID
    if not taskID or taskID < 0 then
      print("Error. Please input a positive number")
    end
  end

  print("------------------------------------------")
  
  while not taskSchedule or taskSchedule < 0 do
    --User input schedule/time
    io.write("Enter schedule in seconds: ")
    taskSchedule = tonumber(io.read())

    -- Check if user input invalid time 
    if not taskSchedule or taskSchedule < 0 then
      print("Error. Please input a positive number")
    end
  end

  print("------------------------------------------")
  
  -- User input description
  io.write("Enter task desc: ")
  local taskDesc = loadstring("return function() print('" .. io.read() .. "') end")()

  -- Create global variables to represent attributes
  task.id = taskID
  task.schedule = taskSchedule
  task.desc = taskDesc

  --Increase task size
  amountOfTasks = amountOfTasks + 1

  print("------------------------------------------")
  
  return task
end

-- Find a task by inputting its ID
function searchTaskByID(id)
  local found = false
  for _, task in ipairs(tasks) do
    if task.id == id then
      print("ID: " .. task.id)
      print("Schedule: " .. task.schedule .. " seconds")
      print("Description: ")
      task.desc()
      found = true
      break
    end
  end

  -- If the ID cannot be found, the existing IDs are printed
  if not found then
    print("Task ID " .. id .. " not found.")
    os.execute("sleep 1")
    print("The current IDs in the database are: ")
    for _, task in ipairs(tasks) do
      print("ID: " .. task.id)
    end
  end
  print("------------------------------------------")
end

-- Schedule the tasks
-- Basic outline for scheduling
function scheduleTasks()
  for _, task in ipairs(tasks) do
    while true do
      task.desc()
      os.execute("sleep " .. task.schedule)
    end
  end
end

--Delete a task
function deleteTask(tasks, i)
  table.remove(tasks, i)
  amountOfTasks = amountOfTasks - 1
  print("Task removed.")
  print("------------------------------------------")
end

-- Main

local continue = 'y'
print("Enter the values when prompted")
print("------------------------------------------")
while continue == 'y' do
  local newTask = createTask()
  if newTask then
    table.insert(tasks, newTask)
  end
  io.write("Create more tasks? y/n: ")
  continue = io.read()
  print("------------------------------------------")
end 

--scheduleTasks()

searchTaskByID(30)

deleteTask(tasks, 1)

searchTaskByID(30)
