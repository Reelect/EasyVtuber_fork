from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import subprocess
import os

app = FastAPI()

@app.post('/execute_script', response_model=dict)
async def execute_script(img_name: str):
    try:
        # Replace 'your_script.sh' with the actual path to your shell script
        subprocess.Popen([f'./run.sh {img_name}'], shell=True)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f'Error: {str(e)}')

    return {'message': 'Script execution started in the background'}


if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)