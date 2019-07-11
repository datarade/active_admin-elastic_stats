name = active_admin-elastic_stats
run:
	docker-compose run dev sh

build:
	version=`awk '/s\.version/{ print $$3 }' $(name).gemspec | tr -d "'"`; \
	echo "Identified Version $$version from gemspec"; \
	gem build $(name).gemspec; \
	gem install ./$(name)-$$version.gem; \
	gem push $(name)-$$version.gem; \
