default: terraform-format

update-changelog:
	./scripts/update-changelog.sh

generate-docs:
	./scripts/docs.sh

terraform-format:
	./scripts/terraform-format.sh $(validate)
