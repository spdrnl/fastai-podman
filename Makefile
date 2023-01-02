VERSION := $(shell poetry run python -c 'import tomli; print(tomli.load(open("pyproject.toml", "rb"))["tool"]["poetry"]["version"])')


start: remove-container 
	podman container run -d --name fastapi-podman -p 8000:80 --network bridge fastapi-podman

stop:
	podman stop fastapi-podman

run-dev:
	poetry run uvicorn app.main:app --reload

dev-install:
	poetry install

create-container:
	podman image build -t fastapi-podman .

remove-container: stop
	podman container rm fastapi-podman

test:
	http localhost:8000
