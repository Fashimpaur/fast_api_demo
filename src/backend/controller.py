from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Backend-Controller Running"}


@app.get("/hello/{name}/")
async def hello(name: str):
    return {"message": f"Hello, {name}!"}


@app.get("/healthcheck/")
async def healthcheck():
    return {"message": "OK"}

