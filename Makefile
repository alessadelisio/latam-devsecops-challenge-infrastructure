.PHONY: help
help:     ## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY: plan
plan:     ## Initialize, validate, and run Terraform plan.
	@echo "========================="
	@echo "Initializing Terraform..."
	@echo "========================="
	@echo ""
	terraform init

	@echo "====================================="
	@echo "Validating Terraform configuration..."
	@echo "====================================="
	@echo ""
	terraform validate

	@echo "==========================="
	@echo "Running 'terraform plan'..."
	@echo "==========================="
	terraform plan -no-color -out=tfplan

	@echo "==============================="
	@echo "Saving plan to artifact folder..."
	@echo "==============================="
	@echo ""
	mkdir -p ./plan
	mv tfplan ./plan/tfplan

.PHONY: apply
apply:    ## Applies the Terraform configuration.
	@echo "============================"
	@echo "Running 'terraform apply'..."
	@echo "============================"
	@echo ""
	terraform apply -input=false -no-color ./plan/tfplan
