if [ "$#" != "3" ]; then
  echo "This script requires three input parameters.  The module (sys, fp, gl, etc), show_commit_history (if true, then show the commit history), kualico_diff (if true, compare the cu-kfs file with kualico file)"
  exit
fi

currentDate=`date`
module="$1"
commit_history="$2"
kualico_diff="$3"

echo "Processing module $module with commit history $commit_history and KualiCo diff $kualico_diff"

reportFile="../reports/report_file_${module}"
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


kualicoJavaBase="../financials"
kualiCoOverlayJavaBase="src/main/java/org/kuali/kfs"
cornellJavaBase="src/main/java/edu/cornell/kfs"
cornellXMLBase="src/main/resources/edu/cornell/kfs"

case $module in
  ar)
    kualicoJavaBase="${kualicoJavaBase}/kfs-ar"
    kualiCoOverlayJavaBase="${kualiCoOverlayJavaBase}/module/ar"
    cornellJavaBase="${cornellJavaBase}/module/ar"
    cornellXMLBase="${cornellXMLBase}/module/ar"
    ;;
esac

KUALICO_JAVA=("KualiCo base overlay $module" "$kualiCoOverlayJavaBase" "$kualicoJavaBase" "$commit_history" "$kualico_diff")
CORNELL_JAVA=("Cornell Java $module" "$cornellJavaBase" "" "$commit_history" "false")
CORNELL_XML=("Cornell XML $module" "$cornellXMLBase" "" "$commit_history" "false")

modules=(
  KUALICO_JAVA[@]
  CORNELL_JAVA[@]
  CORNELL_XML[@]
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
  echo "showCommitHistory: $showCommitHistory" >> $reportFile

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

#rm -rf cu-kfs
#rm -rf financials
