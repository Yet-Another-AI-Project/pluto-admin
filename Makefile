docker-build:
	docker build -t kiwihub.azurecr.io/pluto-admin:$(VERSION) .

docker-stg-build:
	docker build -t kiwihub.azurecr.io/pluto-admin:staging .

docker-push:
	docker push kiwihub.azurecr.io/pluto-admin:$(VERSION)

docker-stg-push:
	docker push kiwihub.azurecr.io/pluto-admin:staging

docker-clean:
	docker rmi kiwihub.azurecr.io/pluto-admin:$(VERSION) || true
	docker rm -v $(shell docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null || true
	docker rmi $(shell docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null || true

docker-stg-clean:
	docker rmi kiwihub.azurecr.io/pluto-admin:staging || true
	docker rm -v $(shell docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null || true
	docker rmi $(shell docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null || true

ci-build-production: docker-build docker-push docker-clean

ci-build-staging: docker-stg-build docker-stg-push docker-stg-clean
