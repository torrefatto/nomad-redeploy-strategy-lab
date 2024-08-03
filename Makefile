NOMAD ?= nomad

init:
	$(NOMAD) job run csi_hostpath_plugin.hcl
	for i in {0..2}; do \
		$(NOMAD) volume create <(cat volume.hcl | sed -e "s/%VOLID%/$${i}/g"); \
	done

clean: clean-version
	for i in {0..2}; do \
		nomad volume delete "hostvol[$${i}]"; \
	done

bump-stateless-%:
	export VERSION=$$(( $$(cat version 2>/dev/null || echo 0) + 1 )); \
	nomad job run -var version=$$VERSION stateless.$*.hcl; \
	echo $$VERSION > version

bump-stateful-%:
	export VERSION=$$(( $$(cat version 2>/dev/null || echo 0) + 1 )); \
	nomad job run -var version=$$VERSION stateful.$*.hcl; \
	echo $$VERSION > version

clean-version:
	rm -f version

stop-stateless-%: clean-version
	nomad job stop stateless-$*

stop-stateful-%:
	nomad job stop stateful-$*
