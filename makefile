.PHONY: build

generate:
	@echo "Generating the project files..."
	@dart run build_runner build --delete-conflicting-outputs