.PHONY: all clean test lint deploy

all:	ota.js

ota.js: src/*.ts
	npx tsc

clean:
	rm *.js *.js.map
	# rm -rf node_modules

test:	ota.js
	npm start

lint:
	npx eslint src/*.ts

container:	ota.js package.json Dockerfile
	gcloud builds submit --tag gcr.io/<app>/<container>

deploy:	ota.js
	gcloud run deploy <instance> --image gcr.io/<app>/<container> --platform managed --region us-central1 --allow-unauthenticated --service-account <serviceaccount>
