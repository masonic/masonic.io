IN=src
OUT=dist
CONFIGDIR=devops

all: build

cfgcreate:
	cd $(CONFIGDIR) && bundle && bundle exec s3_website cfg create

cfgapply:
	cd $(CONFIGDIR) && bundle && bundle exec s3_website cfg apply

push: build potentially_destructive_push_danger

# if you push without building, you may have a Very Bad Time™
potentially_destructive_push_danger:
	cd $(CONFIGDIR) && bundle && bundle exec s3_website push --site ../$(OUT)

build: dev_dependencies third_party_javascripts
	grunt

third_party_javascripts: dev_dependencies
	bower install

dev_dependencies:
	npm install

view: build
	grunt serve

clean:
	grunt clean
	rm -rf node_modules/
	rm -rf $(IN)/components/
	rm -rf tmp/

ghdeploy:
	./ghdeploy.sh
