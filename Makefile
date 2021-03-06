.PHONY: all
all: clean lint test dist

.PHONY: clean
clean:
	@echo ">> Cleaning"
	@rm -rf build dist

.PHONY: lint
lint: clean
	@echo ">> Linting"
	@pylint qpid_bow
	-@bandit -r qpid_bow
	@mypy --ignore-missing-imports qpid_bow

.PHONY: test
test: clean
	@echo ">> Testing"
	@pytest test \
		--cov-report term-missing:skip-covered \
		--cov-report xml \
		--cov qpid_bow \
		--cov test

.PHONY: dist
dist: clean
	@echo ">> Building"
	@python setup.py sdist bdist_wheel
	@echo "!! Build ready"

.PHONY: docs
docs: clean
	@echo ">> Building docs"
	@sphinx-apidoc -f -o docs/source qpid_bow
	@sphinx-build -c docs/source docs/source docs/build
