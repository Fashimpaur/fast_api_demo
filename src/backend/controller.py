from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name/")
async def hello(name: str):
    return {"message": f"Hello, {name}!"}


@app.get("/healthcheck/")
async def healthcheck():
    return {"message": "OK"}


if __name__ == "__main__":
    app.include_router(healthcheck.router)
