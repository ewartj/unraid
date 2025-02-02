from fastapi import FastAPI
import uvicorn
from datetime import date
import yaml
import os

app = FastAPI()

with open("config.yaml") as config:
    try:
        config = yaml.safe_load(config)
    except yaml.YAMLError as exc:
        print(exc)

@app.get("/bin")
async def input():
    today = date.today()
    # Get the ISO calendar representation
    week_number = date.today().isocalendar()[1]
    # Extract the week number
    # week_number = iso_calendar[1]
    if week_number % 2 == 0:
        bin = config["bins"]["even"]
    else:
        bin = config["bins"]["odd"]
    return str(bin)

if __name__ == "__main__":
    uvicorn.run("main:app", port=8000, host='0.0.0.0')