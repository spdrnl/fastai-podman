from fastapi import FastAPI, File
from fastcore.all import * 
from fastai.vision.all import *
import io

app = FastAPI()


learn_inf = load_learner('model.pkl')


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/predict")
async def create_file(my_file: bytes = File()):
    #learn_inf = load_learner('model.pkl')
    cat, _, probs = learn_inf.predict(my_file)
    p = probs.numpy().tolist()
    return {"category": cat, "probs": p}
