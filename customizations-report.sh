git clone https://github.com/CU-CommunityApps/cu-kfs
git clone https://github.com/kualico/financials
cd cu-kfs

K_J_SYS=("KualiCo base overlay SYS" "src/main/java/org/kuali/kfs/sys" "../financials/kfs-core/" "false" "true")
CU_J_SYS=("Cornell Java SYS" "src/main/java/edu/cornell/kfs/sys" "" "false" "false")
CU_X_SYS=("Cornell XML SYS" "src/main/resources/edu/cornell/kfs/sys" "" "false" "false")
modules=(
  K_J_SYS[@]
  CU_J_SYS[@]
  CU_X_SYS[@]
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
  for j in "${moduleFiles[@]}"
  do
    echo "FILE $j" >> $reportFile
    
    if [ "$showCommitHistory" = "true" ]; then
      readarray -t gitLogEntries < <(git log --since=6.months --oneline -- $1 ":(exclude)phabricator")
      for k in "${gitLogEntries[@]}"
      do
        echo "     $k" >> $reportFile
      done
    fi
    
    if [ "$showKualiCoDiff" = "true" ]; then
      kualiCOFile="$modKualiCoPath$j"
      echo "kualiCOFile: $kualiCOFile"
    fi
    
    
  done

  echo "******************************************************************************************************" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
done

cd ..

# rm -rf cu-kfs
