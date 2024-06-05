shell:
	pipenv shell

run:
	python -m uvicorn main:app --reload

gen-req:
	pipenv requirements > requirements.txt
