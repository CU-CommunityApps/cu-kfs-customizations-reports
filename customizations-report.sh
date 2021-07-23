git clone https://github.com/CU-CommunityApps/cu-kfs
git clone https://github.com/kualico/financials
cd cu-kfs

K_J_SYS=("KualiCo base overlay SYS" "src/main/java/org/kuali/kfs/sys" "../financials/kfs-core/" "false" "true")
CU_J_SYS=("Cornell Java SYS" "src/main/java/edu/cornell/kfs/sys" "" "false" "false")
CU_X_SYS=("Cornell XML SYS" "src/main/resources/edu/cornell/kfs/sys" "" "false" "false")
K_J_COA=("KualiCo base overlay COA" "src/main/java/org/kuali/kfs/coa" "../financials/kfs-core/" "false" "true")
K_J_FP=("KualiCo base overlay FP" "src/main/java/org/kuali/kfs/fp" "../financials/kfs-core/" "false" "true")
K_J_GL=("KualiCo base overlay GL" "src/main/java/org/kuali/kfs/gl" "../financials/kfs-core/" "false" "true")
K_J_KIM=("KualiCo base overlay KIM" "src/main/java/org/kuali/kfs/kim" "../financials/kfs-core/" "false" "true")
K_J_KNS=("KualiCo base overlay KNS" "src/main/java/org/kuali/kfs/kns" "../financials/kfs-core/" "false" "true")
K_J_PDP=("KualiCo base overlay PDP" "src/main/java/org/kuali/kfs/pdp" "../financials/kfs-core/" "false" "true")
K_J_SEC=("KualiCo base overlay SEC" "src/main/java/org/kuali/kfs/sec" "../financials/kfs-core/" "false" "true")
K_J_VND=("KualiCo base overlay VND" "src/main/java/org/kuali/kfs/vnd" "../financials/kfs-core/" "false" "true")
K_J_AR=("KualiCo base overlay AR" "src/main/java/org/kuali/kfs/module/ar" "../financials/kfs-ar/" "false" "true")
K_J_CAM=("KualiCo base overlay CAM" "src/main/java/org/kuali/kfs/module/cam" "../financials/kfs-cam/" "false" "true")
K_J_CG=("KualiCo base overlay CG" "src/main/java/org/kuali/kfs/module/cg" "../financials/kfs-cg/" "false" "true")
K_J_LD=("KualiCo base overlay LD" "src/main/java/org/kuali/kfs/module/ld" "../financials/kfs-ld/" "false" "true")
K_J_PURAP=("KualiCo base overlay PURAP" "src/main/java/org/kuali/kfs/module/purap" "../financials/kfs-purap/" "false" "true")

modules=(
  K_J_SYS[@]
  CU_J_SYS[@]
  CU_X_SYS[@]
  K_J_COA[@]
  K_J_FP[@]
  K_J_GL[@]
  K_J_KIM[@]
  K_J_KNS[@]
  K_J_PDP[@]
  K_J_SEC[@]
  K_J_VND[@]
  K_J_AR[@]
  K_J_CAM[@]
  K_J_CG[@]
  K_J_LD[@]
  K_J_PURAP[@]
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

# rm -rf cu-kfs
