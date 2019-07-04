## Apply Seurat3

suppressPackageStartupMessages({
  library(Seurat, lib.loc="/Users/tasneemyusufali/Capstone/src/lib/Seurat/v3")
})

apply_Seurat3 <- function(sce, params, resolution) {
  (seed <- round(1e6*runif(1)))
  tryCatch({
    dat <- counts(sce)
    st <- system.time({
      data <- CreateSeuratObject(counts = dat, min.cells = params$min.cells,
                                 min.features = params$min.genes, project = "scRNAseq") 
      data <- NormalizeData(object = data, normalization.method = "LogNormalize", 
                            scale.factor = 1e4, display.progress = FALSE)
      data <- ScaleData(object = data, display.progress = FALSE)
      data <- RunPCA(object = data, features = rownames(data@data), verbose = FALSE, 
                     npcs = max(params$dims.use), seed.use = seed)
      data <- FindClusters(object = data, reduction.type = "pca", save.SNN = TRUE, 
                           dims.use = params$dims.use, k.param = 30,
                           resolution = resolution, verbose = TRUE, 
                           random.seed = seed)
      cluster <- data@ident
    })
    
    st <- c(user.self = st[["user.self"]], sys.self = st[["sys.self"]], 
            user.child = st[["user.child"]], sys.child = st[["sys.child"]],
            elapsed = st[["elapsed"]])
    list(st = st, cluster = cluster, est_k = NA)
  }, error = function(e) {
    list(st = c(user.self = NA, sys.self = NA, user.child = NA, sys.child = NA,
                elapsed = NA), 
         cluster = structure(rep(NA, ncol(sce)), names = colnames(sce)),
         est_k = NA)
  })
}