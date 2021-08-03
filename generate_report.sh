if [ "$#" != "3" ]; then
  echo "This script requires three input parameters.  The module (sys, fp, gl, etc), show_commit_history (if true, then show the commit history), kualico_diff (if true, compare the cu-kfs file with kualico file)"
  exit
fi

currentDate=`date`
module="$1"
commit_history="$2"
kualico_diff="$3"

echo "Processing module $module with commit history $commit_history and KualiCo diff $kualico_diff"

reportFile="../reports/technical/report_file_${module}"
if [ "$commit_history" = "true" ]; then
  reportFile="${reportFile}_commit_history"
fi
if [ "$kualico_diff" = "true" ]; then
  reportFile="${reportFile}_kualico_diff"
fi
reportFile="${reportFile}_$(date '+%Y-%m-%d').txt"
echo "Creating report file $reportFile"

git clone https://github.com/CU-CommunityApps/cu-kfs
git clone https://github.com/kualico/financials
cd cu-kfs

echo "Technical Report generated on $currentDate " > $reportFile


kualicoBase="../financials/"
kualiCoOverlayJavaBase="src/main/java/org/kuali/kfs"
kualiCoOverlayResourcesBase="src/main/resources/org/kuali/kfs"
cornellJavaBase="src/main/java/edu/cornell/kfs"
cornellResourceBase="src/main/resources/edu/cornell/kfs"

case $module in
  ar | cam | cg | ld | purap)
    kualicoBase="${kualicoBase}/kfs-${module}/"
    kualiCoOverlayJavaBase="${kualiCoOverlayJavaBase}/module/${module}"
    kualiCoOverlayResourcesBase="${kualiCoOverlayResourcesBase}/module/${module}"
    cornellJavaBase="${cornellJavaBase}/module/${module}"
    cornellResourceBase="${cornellResourceBase}/module/${module}"
    ;;
  *)
    kualicoBase="${kualicoBase}/kfs-core/"
    kualiCoOverlayJavaBase="${kualiCoOverlayJavaBase}/${module}"
    kualiCoOverlayResourcesBase="${kualiCoOverlayResourcesBase}/${module}"
    cornellJavaBase="${cornellJavaBase}/${module}"
    cornellResourceBase="${cornellResourceBase}/${module}"
    ;;
esac

KUALICO_JAVA=("KualiCo base Java overlay $module" "$kualiCoOverlayJavaBase" "$kualicoBase" "$commit_history" "$kualico_diff")
KUALICO_RESOURCES=("KualiCo base resources overlay $module" "$kualiCoOverlayResourcesBase" "$kualicoBase" "$commit_history" "$kualico_diff")
CORNELL_JAVA=("Cornell Java $module" "$cornellJavaBase" "" "$commit_history" "false")
CORNELL_RESOURCES=("Cornell Resources $module" "$cornellResourceBase" "" "$commit_history" "false")

modules=(
  KUALICO_JAVA[@]
  KUALICO_RESOURCES[@]
  CORNELL_JAVA[@]
  CORNELL_RESOURCES[@]
)


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
  echo "" >> $reportFile
  echo "" >> $reportFile

  moduleFiles=($(find $modPath -type f -follow -print))
  for cuFile in "${moduleFiles[@]}"
  do
    echo "Cornell File $cuFile" >> $reportFile
    
    if [ "$showCommitHistory" = "true" ]; then
      readarray -t gitLogEntries < <(git log --since=6.months --oneline -- $cuFile ":(exclude)phabricator")
      for logEntry in "${gitLogEntries[@]}"
      do
        echo "     $logEntry" >> $reportFile
      done
    fi
    
    if [ "$showKualiCoDiff" = "true" ]; then
      kualiCOFile="$modKualiCoPath$cuFile"
      echo "KualiCO File: $kualiCOFile" >> $reportFile
      if test -f "$kualiCOFile"; then
          diff "$cuFile" "$kualiCOFile" >> $reportFile
      else
        echo "  KualiCO File does not exist" >> $reportFile
      fi
      
      
      echo "" >> $reportFile
      echo "" >> $reportFile
      
    fi
    
    echo "" >> $reportFile
  done

  echo "******************************************************************************************************" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
  echo "" >> $reportFile
done


cd ..

#rm -rf cu-kfs
#rm -rf financials
