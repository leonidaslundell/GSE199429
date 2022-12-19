# Code and data for Time of Day Determines Post-Exercise Metabolism in Mouse Adipose Tissue

This is repository contains the scripts to reproduce all figures and analysis from the publication: Time of Day Determines Post-Exercise Metabolism in Mouse Adipose Tissue published in PNAS.

Main markdown repport is found at GSE199429, with supplementary scripts for public data analysis found under their descriptive titles. All data is found in the data folder.

Session info:

R version 4.1.0 (2021-05-18)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 10.16

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] parallel  stats4    stats     graphics  grDevices utils     datasets 
[8] methods   base     

other attached packages:
 [1] beepr_1.3             clipr_0.8.0           ReactomePA_1.36.0    
 [4] clusterProfiler_4.0.5 UpSetR_1.4.0          reshape2_1.4.4       
 [7] ggsci_2.9             patchwork_1.1.1       ggplot2_3.3.5        
[10] openxlsx_4.2.5        org.Mm.eg.db_3.13.0   org.Hs.eg.db_3.13.0  
[13] AnnotationDbi_1.54.1  IRanges_2.26.0        S4Vectors_0.30.2     
[16] Biobase_2.52.0        BiocGenerics_0.38.0   dplyr_1.0.8          
[19] data.table_1.14.2     edgeR_3.34.1          limma_3.48.3         

loaded via a namespace (and not attached):
  [1] backports_1.4.1        shadowtext_0.1.1       fastmatch_1.1-3       
  [4] systemfonts_1.0.4      plyr_1.8.6             igraph_1.2.11         
  [7] lazyeval_0.2.2         splines_4.1.0          crosstalk_1.2.0       
 [10] BiocParallel_1.26.2    usethis_2.1.5          GenomeInfoDb_1.28.4   
 [13] digest_0.6.29          yulab.utils_0.0.4      htmltools_0.5.2.9000  
 [16] GOSemSim_2.18.1        viridis_0.6.2          GO.db_3.13.0          
 [19] fansi_1.0.2            checkmate_2.0.0        magrittr_2.0.2        
 [22] memoise_2.0.1          remotes_2.4.2          Biostrings_2.60.2     
 [25] graphlayouts_0.8.0     enrichplot_1.12.3      prettyunits_1.1.1     
 [28] colorspace_2.0-3       rappdirs_0.3.3         blob_1.2.2            
 [31] ggrepel_0.9.1          textshaping_0.3.6      xfun_0.30             
 [34] callr_3.7.0            crayon_1.5.0           RCurl_1.98-1.6        
 [37] jsonlite_1.8.0         graph_1.70.0           scatterpie_0.1.7      
 [40] ape_5.6-2              glue_1.6.2             polyclip_1.10-0       
 [43] gtable_0.3.0           zlibbioc_1.38.0        XVector_0.32.0        
 [46] graphite_1.38.0        pkgbuild_1.3.1         scales_1.1.1          
 [49] DOSE_3.18.3            DBI_1.1.2              Rcpp_1.0.8.3          
 [52] viridisLite_0.4.0      gridGraphics_0.5-1     tidytree_0.3.9        
 [55] reactome.db_1.76.0     bit_4.0.4              DT_0.21               
 [58] htmlwidgets_1.5.4      httr_1.4.2             fgsea_1.18.0          
 [61] RColorBrewer_1.1-2     ellipsis_0.3.2         pkgconfig_2.0.3       
 [64] farver_2.1.0           sass_0.4.0             locfit_1.5-9.5        
 [67] utf8_1.2.2             labeling_0.4.2         ggplotify_0.1.0       
 [70] tidyselect_1.1.2       rlang_1.0.2            munsell_0.5.0         
 [73] tools_4.1.0            cachem_1.0.6           downloader_0.4        
 [76] cli_3.2.0              audio_0.1-10           generics_0.1.2        
 [79] RSQLite_2.2.10         devtools_2.4.3         evaluate_0.15         
 [82] stringr_1.4.0          fastmap_1.1.0          ragg_1.2.2            
 [85] yaml_2.3.5             ggtree_3.0.4           processx_3.5.2        
 [88] knitr_1.37             bit64_4.0.5            fs_1.5.2              
 [91] tidygraph_1.2.0        zip_2.2.0              purrr_0.3.4           
 [94] easypackages_0.1.0     KEGGREST_1.32.0        ggraph_2.0.5          
 [97] nlme_3.1-155           aplot_0.1.2            DO.db_2.9             
[100] brio_1.1.3             compiler_4.1.0         rstudioapi_0.13       
[103] beeswarm_0.4.0         png_0.1-7              testthat_3.1.2        
[106] treeio_1.16.2          statmod_1.4.36         tibble_3.1.6          
[109] tweenr_1.0.2           bslib_0.3.1            stringi_1.7.6         
[112] highr_0.9              ps_1.6.0               desc_1.4.1            
[115] lattice_0.20-45        Matrix_1.4-0           vctrs_0.3.8           
[118] pillar_1.7.0           lifecycle_1.0.1        jquerylib_0.1.4       
[121] cowplot_1.1.1          bitops_1.0-7           qvalue_2.24.0         
[124] R6_2.5.1               gridExtra_2.3          vipor_0.4.5           
[127] sessioninfo_1.2.2      MASS_7.3-55            assertthat_0.2.1      
[130] pkgload_1.2.4          rprojroot_2.0.2        withr_2.5.0           
[133] GenomeInfoDbData_1.2.6 grid_4.1.0             ggfun_0.0.5           
[136] tidyr_1.2.0            rmarkdown_2.13         ggforce_0.3.3         
[139] ggbeeswarm_0.6.0
