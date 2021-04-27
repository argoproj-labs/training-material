config/argo-workflows.yaml:
config/%.yaml: /dev/null
	kustomize build --load_restrictor=none config/$* -o $@
