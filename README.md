# cu-kfs-customizations-reports
This project contains a bash script that analyzes CU-KFS code, shows recent commit history per file, and when it is an overylay of a basecode file, it shows the differences between the CU-KFS code on the KualiCo code.

# How to run this script
 bash generate_report.sh --module sys --show-commit-history false --show-kualico-diff true   
 bash generate_report.sh --module sys
* Available modes are  ar, cam, cg coa, concur, fp, gl, integration, kim, kns, krad, ld, pdp, pmw, purap, rass, receiptProcessing, sec, sys, tax, vnd, web
* If show-commit-history or show-kualico-diff is not supplied, it defaults to false
* The bash script will pause after it clones cu-kfs and kualico/financials and give you a chance to checkout a specific branch or tago for either repository.
