trap printout SIGINT
printout() {
  echo ""
  echo "SIGINT received"
  exit 1
}
ret_code=1
try_num=1
while [ $ret_code -ne 0 ]; do
  echo "*******************************"
  echo "**** Execution #${try_num} ****"
  echo "*******************************"
  "$@"
  ret_code=$?
  try_num=$((try_num + 1))
  sleep 1
done
