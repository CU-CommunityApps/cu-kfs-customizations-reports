# cu-kfs-customizations-reports
Bash script to generate reports showing customizations we have made to our KFS overlay.
To run this job, use bash.
At the top of the script there are a list arrays that control the directories reviewed, and the reviews performed.
The array variable naming convention is source_type_module.  Source is K for KualiCo and C for Cornell. Type is J for Java, and X for XML.  Module is for the KFS module, SYS, PDP, AR, etc
The array content are description, Cornell overlay path, kualico path, boolean if the commit history is shown, and boolean if we diff the Cornell file versus the kualico file.
Currently the diff will only work for over lay files if the directory is a Cornell overlay file on the ORG path.
