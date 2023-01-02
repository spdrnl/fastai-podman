VERSION := $(shell poetry run python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["version"])')


start:  
	podman container run -d --name fastai-podman -p 8000:80 --network bridge fastai-podman

stop:
	podman stop fastai-podman

run-dev:
	poetry run uvicorn app.main:app --reload

dev-install:
	poetry install

create-container: 
	podman image build -t fastai-podman .

remove-container: 
	podman container rm fastai-podman

test:
	http localhost:8000

predict:
	http -f POST localhost:8000/predict my_file@kitchentool.jpg
