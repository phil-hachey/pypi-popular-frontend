all: clean build

build:
	@npm run build

clean:
	@echo "Removing dist"
	@rm -rf dist

.ONESHELL:
terraform.apply:
	@cd terraform
	@terraform apply

.ONESHELL:
terraform.plan:
	@cd terraform
	@terraform plan

deploy:
	@npm run deploy

.PHONY: all test clean build
