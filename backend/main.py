from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import sensors, auth_example

from fastapi import FastAPI, Query, Path
from typing import Annotated
from fastapi.responses import JSONResponse
from services.models import TodoItem


app = FastAPI(title="air_quality_app demo backend")



todos =[]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(sensors.router, prefix="")
app.include_router(auth_example.router, prefix="")

@app.get("/")
def root():
    return {"status": "ok", "service": "backend"}


@app.get("/todos", description="Show all of the to do items we have", response_description="A list of to do items", response_model=list[TodoItem])
def get_todos(limit: Annotated[int, Query(description="The number of responses you want", ge=1)] = 20, offset: Annotated[int, Query(description="The index of the item you want to start with", ge=0)] = 0): #This is where we specify query paramaters.
    fun_offset = offset
    fun_limit = limit
    if fun_offset >= len(todos):
        return []
    if fun_offset + fun_limit >= len(todos):
        fun_limit = len(todos) - fun_offset
    return todos[fun_offset:fun_offset+fun_limit]

@app.get("/todos/complete", description="Show all of the completed to do items we have", response_description="A list of to do items", response_model=list[TodoItem])
def todos_complete(limit: Annotated[int, Query(description="The number of responses you want", ge=1)] = 20, offset: Annotated[int, Query(description="The index of the item you want to start with", ge=0)] = 0): #This is where we specify query paramaters.
    completed_todos = []
    for todo in todos:
        if todo.completed:
            completed_todos.append(todo)
    fun_offset = offset
    fun_limit = limit
    if fun_offset >= len(todos):
        return []
    if fun_offset + fun_limit >= len(todos):
        fun_limit = len(todos) - fun_offset
    return completed_todos[fun_offset:fun_offset+fun_limit]

@app.get("/todos/incomplete", description="Show all of the noncompleted to do items we have", response_description="A list of to do items", response_model=list[TodoItem])
def todos_incomplete(limit: Annotated[int, Query(description="The number of responses you want", ge=1)] = 20, offset: Annotated[int, Query(description="The index of the item you want to start with", ge=0)] = 0): #This is where we specify query paramaters.
    noncompleted_todos = []
    for todo in todos:
        if not todo.completed:
            noncompleted_todos.append(todo)
    fun_offset = offset
    fun_limit = limit
    if fun_offset >= len(todos):
        return []
    if fun_offset + fun_limit >= len(todos):
        fun_limit = len(todos) - fun_offset
    return noncompleted_todos[fun_offset:fun_offset+fun_limit]

# @app.post("/todos", description="Add a new to do item, returns the to do item you sent.", response_description="The item you just added", response_model=TodoItem) #Item is a path parameter
# def add_todo(text: Annotated[str, Path(description="The text you want on the item")]):
#     item = TodoItem(text=text)
#     todos.append(item)
#     return item

@app.post("/todos", description="Add a new todo item")
def add_todo(item: TodoItem):
    todos.append(item)
    return item

@app.delete("/todo/{index}", description="Remove a todo item at a certain index", response_model=TodoItem, response_description="The todo item you just deleted", responses={
    404 : {"description": "index not found"}
})
def remove_todo(index: Annotated[int, Path(description="The index of the todo item you want to remove", ge=0)]):
    if index >= len(todos):
        return JSONResponse(status_code=404, content="Index not found")
    removed = todos[index]
    del todos[index]
    return removed

@app.post("/complete/{index}", description="Complete the todo item at the selected index", response_model=TodoItem, response_description="The todo item you just checked", responses={
    404: {"description": "index not found"}
})
def complete_todo(index: Annotated[int, Path(description="The index of the todo item you want to complete", ge=0)]):
    if index >= len(todos):
        return JSONResponse(status_code=404, content="Index not found")
    todos[index].completed = True
    return todos[index]

@app.post("/uncomplete/{index}", description="Remove complettion of the todo item at the selected index", response_model=TodoItem, response_description="The todo item you just unchecked", responses={
    404: {"description": "index not found"}
})
def uncomplete_todo(index: Annotated[int, Path(description="The index of the todo item you want to uncomplete", ge=0)]):
    if index >= len(todos):
        return JSONResponse(status_code=404, content="Index not found")
    todos[index].completed = False
    return todos[index]

