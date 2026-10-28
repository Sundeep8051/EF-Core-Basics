.PHONY: help restore build run clean \
        ef-add ef-remove ef-update ef-list \
        docker-up docker-down docker-logs

DATA_PROJECT := data
STARTUP_PROJECT := api
CONTEXT := AppDbContext

help:
	@echo "Available commands:"
	@echo "  make restore                 Restore NuGet packages"
	@echo "  make build                   Build the project"
	@echo "  make run                     Run the application"
	@echo "  make ef-add NAME=AddUsers    Add a migration"
	@echo "  make ef-remove               Remove the last migration"
	@echo "  make ef-update               Apply migrations to database"
	@echo "  make ef-list                 List migrations"
	@echo "  make docker-up               Start Docker services"
	@echo "  make docker-down             Stop Docker services"
	@echo "  make docker-logs             Show Docker logs"

restore:
	dotnet restore

build:
	dotnet build

run:
	dotnet run --project $(STARTUP_PROJECT)

clean:
	dotnet clean

# Add a new migration
ef-add:
	dotnet ef migrations add $(NAME) \
		--project $(DATA_PROJECT) \
		--startup-project $(STARTUP_PROJECT) \
		--context $(CONTEXT)

# Remove the latest migration (if not applied to the database)
ef-remove:
	dotnet ef migrations remove \
		--project $(DATA_PROJECT) \
		--startup-project $(STARTUP_PROJECT) \
		--context $(CONTEXT)

# Apply pending migrations
ef-update:
	dotnet ef database update \
		--project $(DATA_PROJECT) \
		--startup-project $(STARTUP_PROJECT) \
		--context $(CONTEXT)

# Used to revert migrations till migration name
ef-update:
	dotnet ef database update $(NAME) \
		--project $(DATA_PROJECT) \
		--startup-project $(STARTUP_PROJECT) \
		--context $(CONTEXT)

# List migrations and their applied status
ef-list:
	dotnet ef migrations list \
		--project $(DATA_PROJECT) \
		--startup-project $(STARTUP_PROJECT) \
		--context $(CONTEXT)

# Docker Compose commands
docker-up:
	docker compose up -d

docker-down:
	docker compose down

docker-logs:
	docker compose logs -f