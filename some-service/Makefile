define help_message
  Supports the following format:
  make <command>
 
  make install                 Installs necessary dependencies to run the Service.
  make console                 Boots up an application REPL.
                                   All app/lib/config code will be loaded.
                                   Requires booting the Corrospondence test server.
 
  make run_specs               Runs the non-integrated specs.
  make run_integrated_specs    Runs the integrated specs.
                                   Requires booting the Corrospondence test server.

endef
export help_message

help:
	@echo "$$help_message"

install:
	bundle install --no-binstubs

console:
	PRE_REGISTERED_FORUM_ID=00000000-0000-0000-0000-000000000000 CORROSPONDENCE_BASE_URL=http://localhost:3000 bundle exec pry -r ./config/environment

run_specs:
	PRE_REGISTERED_FORUM_ID=00000000-0000-0000-0000-000000000000 bundle exec rspec

run_integrated_specs:
	CORROSPONDENCE_BASE_URL=http://localhost:3000/with_auth bundle exec rspec --tag integrated --fail-fast

	
