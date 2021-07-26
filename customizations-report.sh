git clone https://github.com/CU-CommunityApps/cu-kfs
git clone https://github.com/kualico/financials
cd cu-kfs

kualicoBase="../financials"
kualicoBaseCore="$kualicoBase/kfs-core/"
cuKfsOrgBase="src/main/java/org/kuali/kfs"
cuKfsJavaEduBase="src/main/java/edu/cornell/kfs"
cuKfsXmlEduBase="src/main/resources/edu/cornell/kfs"

K_J_SYS=("KualiCo base overlay SYS" "$cuKfsOrgBase/sys" "$kualicoBaseCore" "false" "false")
CU_J_SYS=("Cornell Java SYS" "$cuKfsJavaEduBase/sys" "" "false" "false")
CU_X_SYS=("Cornell XML SYS" "$cuKfsXmlEduBase/sys" "" "false" "false")

K_J_COA=("KualiCo base overlay COA" "$cuKfsOrgBase/coa" "$kualicoBaseCore" "false" "false")
CU_J_COA=("Cornell Java COA" "$cuKfsJavaEduBase/coa" "" "false" "false")
CU_X_COA=("Cornell XML COA" "$cuKfsXmlEduBase/coa" "" "false" "false")

K_J_FP=("KualiCo base overlay FP" "$cuKfsOrgBase/fp" "$kualicoBaseCore" "false" "false")
CU_J_FP=("Cornell Java FP" "$cuKfsJavaEduBase/fp" "" "false" "false")
CU_X_FP=("Cornell XML FP" "$cuKfsXmlEduBase/fp" "" "false" "false")

K_J_GL=("KualiCo base overlay GL" "$cuKfsOrgBase/gl" "$kualicoBaseCore" "false" "false")
CU_J_GL=("Cornell Java GL" "$cuKfsJavaEduBase/gl" "" "false" "false")
CU_X_GL=("Cornell XML GL" "$cuKfsXmlEduBase/gl" "" "false" "false")

K_J_KIM=("KualiCo base overlay KIM" "$cuKfsOrgBase/kim" "$kualicoBaseCore" "false" "false")
CU_J_KIM=("Cornell Java KIM" "$cuKfsJavaEduBase/kim" "" "false" "false")
CU_X_KIM=("Cornell XML KIM" "$cuKfsXmlEduBase/kim" "" "false" "false")

K_J_KNS=("KualiCo base overlay KNS" "$cuKfsOrgBase/kns" "$kualicoBaseCore" "false" "false")
CU_J_KNS=("Cornell Java KNS" "$cuKfsJavaEduBase/kns" "" "false" "false")
CU_X_KNS=("Cornell XML KNS" "$cuKfsXmlEduBase/kns" "" "false" "false")

K_J_PDP=("KualiCo base overlay PDP" "$cuKfsOrgBase/pdp" "$kualicoBaseCore" "false" "false")
CU_J_PDP=("Cornell Java PDP" "$cuKfsJavaEduBase/pdp" "" "false" "false")
CU_X_PDP=("Cornell XML PDP" "$cuKfsXmlEduBase/pdp" "" "false" "false")

K_J_SEC=("KualiCo base overlay SEC" "$cuKfsOrgBase/sec" "$kualicoBaseCore" "false" "false")
CU_J_SEC=("Cornell Java SEC" "$cuKfsJavaEduBase/sec" "" "false" "false")
CU_X_SEC=("Cornell XML SEC" "$cuKfsXmlEduBase/sec" "" "false" "false")

K_J_VND=("KualiCo base overlay VND" "$cuKfsOrgBase/vnd" "$kualicoBaseCore" "false" "false")
CU_J_VND=("Cornell Java VND" "$cuKfsJavaEduBase/vnd" "" "false" "false")
CU_X_VND=("Cornell XML VND" "$cuKfsXmlEduBase/vnd" "" "false" "false")

K_J_AR=("KualiCo base overlay AR" "$cuKfsOrgBase/module/ar" "$kualicoBase/kfs-ar/" "false" "false")
CU_J_AR=("Cornell Java AR" "$cuKfsJavaEduBase/module/ar" "" "false" "false")
CU_X_AR=("Cornell XML AR" "$cuKfsXmlEduBase/module/ar" "" "false" "false")

K_J_CAM=("KualiCo base overlay CAM" "$cuKfsOrgBase/module/cam" "$kualicoBase/kfs-cam/" "false" "false")
CU_J_CAM=("Cornell Java CAM" "$cuKfsJavaEduBase/module/cam" "" "false" "false")
CU_X_CAM=("Cornell XML CAM" "$cuKfsXmlEduBase/module/cam" "" "false" "false")

K_J_CG=("KualiCo base overlay CG" "$cuKfsOrgBase/module/cg" "$kualicoBase/kfs-cg/" "false" "false")
CU_J_CG=("Cornell Java CG" "$cuKfsJavaEduBase/module/cg" "" "false" "false")
CU_X_CG=("Cornell XML CG" "$cuKfsXmlEduBase/module/cg" "" "false" "false")

K_J_LD=("KualiCo base overlay LD" "$cuKfsOrgBase/module/ld" "$kualicoBase/kfs-ld/" "false" "false")
CU_J_LD=("Cornell Java LD" "$cuKfsJavaEduBase/module/ld" "" "false" "false")
CU_X_LD=("Cornell XML LD" "$cuKfsXmlEduBase/module/ld" "" "false" "false")

K_J_PURAP=("KualiCo base overlay PURAP" "$cuKfsOrgBase/module/purap" "$kualicoBase/kfs-purap/" "false" "false")
CU_J_PURAP=("Cornell Java PURAP" "$cuKfsJavaEduBase/module/purap" "" "false" "false")
CU_X_PURAP=("Cornell XML PURAP" "$cuKfsXmlEduBase/module/purap" "" "false" "false")

modules=(
  K_J_SYS[@]
  CU_J_SYS[@]
  CU_X_SYS[@]
  K_J_COA[@]
  CU_J_COA[@]
  CU_X_COA[@]
  K_J_FP[@]
  CU_J_FP[@]
  CU_X_FP[@]
  K_J_GL[@]
  CU_J_GL[@]
  CU_X_GL[@]
  K_J_KIM[@]
  CU_J_KIM[@]
  CU_X_KIM[@]
  K_J_KNS[@]
  CU_J_KNS[@]
  CU_X_KNS[@]
  K_J_PDP[@]
  CU_J_PDP[@]
  CU_X_PDP[@]
  K_J_SEC[@]
  CU_J_SEC[@]
  CU_X_SEC[@]
  K_J_VND[@]
  CU_J_VND[@]
  CU_X_VND[@]
  K_J_AR[@]
  CU_J_AR[@]
  CU_X_AR[@]
  K_J_CAM[@]
  CU_J_CAM[@]
  CU_X_CAM[@]
  K_J_CG[@]
  CU_J_CG[@]
  CU_X_CG[@]
  K_J_LD[@]
  CU_J_LD[@]
  CU_X_LD[@]
  K_J_PURAP[@]
  CU_J_PURAP[@]
  CU_X_PURAP[@]
)

reportFile="../technicalReport.txt"
reportName=""
currentDate=`date`
echo "Technical Report generated on $currentDate " > $reportFile

COUNT=${#modules[@]}
for ((i=0; i<$COUNT; i++))
do
  modDescription=${!modules[i]:0:1}
  modPath=${!modules[i]:1:1}
  modKualiCoPath=${!modules[i]:2:1}
  showCommitHistory=${!modules[i]:3:1}
  showKualiCoDiff=${!modules[i]:4:1}
  
  echo "*********************************** $modDescription *********************************************" >> $reportFile
  
  moduleFileCount=$(find $modPath -type f -print | wc -l)
  echo "The number of files in $modDescription : $moduleFileCount" >> $reportFile

  moduleFiles=($(find $modPath -type f -follow -print))
  for cuFile in "${moduleFiles[@]}"
  do
    echo "Cornell File $cuFile" >> $reportFile
    
    if [ "$showCommitHistory" = "true" ]; then
      readarray -t gitLogEntries < <(git log --since=6.months --oneline -- $1 ":(exclude)phabricator")
      for logEntry in "${gitLogEntries[@]}"
      do
        echo "     $logEntry" >> $reportFile
      done
    fi
    
    if [ "$showKualiCoDiff" = "true" ]; then
      kualiCOFile="$modKualiCoPath$cuFile"
      echo "KualiCO File: $kualiCOFile" >> $reportFile
      diff "$cuFile" "$kualiCOFile" >> $reportFile
      
      echo "" >> $reportFile
      echo "" >> $reportFile
      
    fi
    
    
  done

  echo "******************************************************************************************************" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
done

cd ..

rm -rf cu-kfs
rm -rf financials
