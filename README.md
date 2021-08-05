# cu-kfs-customizations-reports
This project contains a bash script that analyzes CU-KFS code, shows recent commit history per file, and when it is an overylay of a basecode file, it shows the differences between the CU-KFS code on the KualiCo code.

# How to run this script
bash generate_report.sh fp true true
* The first variable is the module.  Available modes are  ar, cam, cg coa, concur, fp, gl, integration, kim, kns, krad, ld, pdp, pmw, purap, rass, receiptProcessing, sec, sys, tax, vnd, web
* The second variable is a boolean for if the report should include the commit history
* The third variable is for if you want a diff between a cu-kfs overlay java code, and kualico base code.
* The bash script will pause after it clones cu-kfs and kualico/financials and give you a chance to checkout a specific branch or tago for either repository.
