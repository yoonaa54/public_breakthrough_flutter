# https://codewithandrea.com/articles/flutter-web-github-pages/

# Makefile for deploying the Flutter web projects to GitHub

BASE_HREF = /$(OUTPUT)/
# Replace this with your GitHub username
GITHUB_USER = yoonaa54
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

define ERROR_MESSAGE
OUTPUT cannot be "dummy_output_folder". Please specify a valid output folder, eg:

make deploy OUTPUT=output_folder_name

endef

OUTPUT ?= dummy_output_folder

# Deploy the Flutter web project to GitHub
deploy:
ifeq ($(OUTPUT), dummy_output_folder)
ifeq ($(MAKECMDGOALS), deploy)
$(error $(ERROR_MESSAGE))
endif
endif

	@echo "Clean existing repository"
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating the web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

# TODO: make it possible to retain deploy history in the git repo
	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

# provide a predictable output if make command is present.
test:
	@echo
	@echo "Congratulations! You have make installed, and can continue with the activity!"
	@echo

.PHONY: deploy

.PHONY: test
