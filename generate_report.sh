module=""
commit_history="false"
kualico_diff="false"
while [ "$1" != "" ]; do
  case $1 in
  --module )
    shift
    module="$1"
    ;;
  --show-commit-history)
    shift
    commit_history="$1"
    ;;
  --show-commit-history)
    shift
    commit_history="$1"
    ;;
  --show-kualico-diff)
    shift
    kualico_diff="$1"
    ;;
  * )
    echo "Examples of running this script are"
    echo "   bash generate_report.sh --module sys --show-commit-history false --show-kualico-diff true"
    echo "   bash generate_report.sh --module sys"
    echo "valid modules are ar, cam, cg, coa, concur, fp, gl, integration, kim, kns, krad, ld, pdp, pmw, purap, rass, receiptProcessing, sec, sys, tax, vnd, web"
    exit 1
  esac
  shift
done

case $module in
  ar | cam | cg | coa | concur | fp | gl | integration | kim | kns | krad | ld | pdp | pmw | purap | rass | receiptProcessing | sec | sys | tax | vnd | web)
    echo "valid module entered $module"
    ;;
  * )
    echo "invalid module entered $module"
    exit
esac

echo "Processing module $module with commit history $commit_history and KualiCo diff $kualico_diff"

currentDate=`date`

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

echo "If you would like to checkout a specific branch of cu-kfs or kualico financials, do so now.  When you are done press any key"
while [ true ] ; do
  read -t 3 -n 1
  if [ $? = 0 ] ; then
    break
  fi
done

cd cu-kfs

echo "Technical Report generated on $currentDate " > $reportFile
echo "" >> $reportFile
echo "******************************** Summary Section *****************************************" >> $reportFile
echo "SUMMARY_REPLACE" >> $reportFile
echo "******************************************************************************************" >> $reportFile
echo "" >> $reportFile
echo "" >> $reportFile

summaryDetails=""

kualicoBase="../financials/"
kualiCoOverlayJavaBase="src/main/java/org/kuali/kfs"
kualiCoOverlayResourcesBase="src/main/resources/org/kuali/kfs"
cornellJavaBase="src/main/java/edu/cornell/kfs"
cornellResourceBase="src/main/resources/edu/cornell/kfs"

case $module in
  ar | cam | cg | ld | purap | receiptProcessing)
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
  summaryDetails="$summaryDetails \n $modDescription : $moduleFileCount"
  echo "" >> $reportFile
  echo "" >> $reportFile

  moduleFiles=($(find $modPath -type f -follow -print))
  for cuFile in "${moduleFiles[@]}"
  do
    echo "Cornell File $cuFile" >> $reportFile
    echo "processing file $cuFile"
    
    if [ "$showCommitHistory" = "true" ]; then
      readarray -t gitLogEntries < <(git log --oneline -- $cuFile ":(exclude)phabricator")
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

sed "s/SUMMARY_REPLACE/$summaryDetails/" "$reportFile" > ${reportFile}.new
cat ${reportFile}.new > $reportFile
rm ${reportFile}.new

cd ..

rm -rf cu-kfs
rm -rf financials
