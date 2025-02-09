help:
	@echo "run - run the Pandora's Flask example"
	@echo "test - run tests under tox"
	@echo "clean - remove all build & Python artifacts"
	@echo "distclean - clean up all artifacts for distribution"

run: setup
	( . .venv/bin/activate && PYTHONPATH=pandoras_flask bin/run_demo )

test:
	tox

clean: clean-build clean-pyc

distclean: clean clean-test clean-run

venv:
	virtualenv --python py39 .venv

start-nginx:
	brew services reload nginx

stop-nginx:
	brew services stop nginx

setup: venv
	( . .venv/bin/activate && pip install -r requirements.txt )

clean-build:
	rm -fr deb_dist
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -f .coverage
	rm -fr htmlcov/ cover/

clean-run:
	rm -f *.log
	rm -fr .venv
	rm -fr .tox

.PHONY: help run test clean distclean setup clean-build clean-pyc clean-test clean-run
