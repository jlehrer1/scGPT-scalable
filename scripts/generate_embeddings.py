import argparse
from pathlib import Path

import anndata as an
import scanpy as sc
import scgpt as scg

N_HVG = 3000

parser = argparse.ArgumentParser(
    description="Generate embeddings using scGPT for a given anndata file"
)
parser.add_argument("input", type=str, help="anndata file")
args = parser.parse_args()

adata: an.AnnData = sc.read_h5ad(args.input)
sc.pp.highly_variable_genes(adata, n_top_genes=N_HVG, flavor="seurat_v3")
adata = adata[:, adata.var["highly_variable"]]

embed_adata = scg.tasks.embed_data(
    adata,
    model_dir=Path(__file__).parent / "models",
    gene_col="index",
    batch_size=64,
)

sc.pp.neighbors(embed_adata, use_rep="X_scGPT")
sc.tl.umap(embed_adata)
sc.tl.leiden(embed_adata)

# save the embeddings
embed_adata.write_h5ad(args.input)
