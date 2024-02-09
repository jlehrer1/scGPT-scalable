CONTAINER = jmlehrer/scgpt

.PHONY: build exec push run go train release 

build:
	docker build -t $(CONTAINER) . 

push:
	docker push $(CONTAINER)

# run with `make run id=XXX`
run-analysis:
	docker run -v /Users/julian/Documents/Projects/sspsy_gene_analysis/data:/src/data jmlehrer/sspsy-processing python process_data.py --dandiset_id=$(id)
	docker run -v /Users/julian/Documents/Projects/sspsy_gene_analysis/data:/src/data jmlehrer/sspsy-visualizing python visualize_data.py