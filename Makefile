default: terraform-format

update-changelog:
	VERSION=$(VERSION) PREVIOUS_VERSION=$(PREVIOUS_VERSION) ./scripts/update-changelog.sh

generate-docs:
	./scripts/docs.sh

terraform-format:
	./scripts/terraform-format.sh $(validate)
