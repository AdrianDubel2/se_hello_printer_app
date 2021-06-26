.PHONY: test

deps:
	pip install -r requirements.txt \
	pip install -r test_requirements.txt

test:
	PYTHONPATH=. py.test
	PYTHONPATH=. py.test -s --cov=. --cov-report xml \
--cov-report term \
--junit-xml=test_results.xml
  
run:
	python main.py

lint:
	flake8 hello_world test

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	    docker_run \
			-- name hello-world-printer-dev \
			-p 5000:5000 \
			- d hello-world-printer

USERNAME=880554
TAG=$(USERNAME)/hello-world-printer

docker_push: docker_build
	     @docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
			 docker tag hello-world-printer $(TAG); \
			 docker push $(TAG); \
			 docker logout;
