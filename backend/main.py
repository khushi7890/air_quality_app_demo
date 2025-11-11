from fastapi import FastAPI, HTTPException, Query, Path
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from typing import Annotated, List
from pydantic import BaseModel

# ---------- Models ----------
class TodoItem(BaseModel):
    id: int | None = None
    text: str
    completed: bool = False


# ---------- App Setup ----------
app = FastAPI(title="air_quality_app demo backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------- Data Store ----------
todos: List[TodoItem] = []
next_id = 0  # ID counter


# ---------- Routes ----------

@app.get("/")
def root():
    return {"status": "ok", "service": "backend"}


# Get all todos
@app.get("/todos", response_model=List[TodoItem], description="Show all todos")
def get_todos(
    limit: Annotated[int, Query(ge=1)] = 20,
    offset: Annotated[int, Query(ge=0)] = 0,
):
    return todos[offset: offset + limit]


# Get only completed todos
@app.get("/todos/complete", response_model=List[TodoItem])
def todos_complete():
    return [t for t in todos if t.completed]


# Get only incomplete todos
@app.get("/todos/incomplete", response_model=List[TodoItem])
def todos_incomplete():
    return [t for t in todos if not t.completed]


# Add a new todo
@app.post("/todos", response_model=TodoItem, description="Add a new todo item")
def add_todo(item: TodoItem):
    global next_id
    item.id = next_id
    next_id += 1
    todos.append(item)
    return item


# Update an existing todo by ID
@app.put("/todos/{todo_id}", response_model=TodoItem, description="Update a todo item by ID")
def update_todo(todo_id: int, updated: TodoItem):
    for i, t in enumerate(todos):
        if t.id == todo_id:
            todos[i] = updated
            return updated
    raise HTTPException(status_code=404, detail="Todo not found")


# Delete a todo
@app.delete("/todos/{todo_id}", response_model=TodoItem, description="Delete a todo item by ID")
def delete_todo(todo_id: int):
    for i, t in enumerate(todos):
        if t.id == todo_id:
            removed = todos.pop(i)
            return removed
    raise HTTPException(status_code=404, detail="Todo not found")


# Mark complete
@app.post("/todos/{todo_id}/complete", response_model=TodoItem)
def complete(todo_id: int):
    for t in todos:
        if t.id == todo_id:
            t.completed = True
            return t
    raise HTTPException(status_code=404, detail="Todo not found")


# Mark incomplete
@app.post("/todos/{todo_id}/uncomplete", response_model=TodoItem)
def uncomplete(todo_id: int):
    for t in todos:
        if t.id == todo_id:
            t.completed = False
            return t
    raise HTTPException(status_code=404, detail="Todo not found")


