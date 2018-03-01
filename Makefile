# --------------------------
#	       Docker
# --------------------------
docker-build-runner:
	docker build -t benchhub/oltpbench:latest .
.PHONY: docker-clean-all
docker-clean-all:
	docker system prune