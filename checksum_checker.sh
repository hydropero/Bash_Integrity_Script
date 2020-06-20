#file consistency and change checker


FILE_TO_CHECK="${1}"

CHECKSUMMED=$(sha256sum "${FILE_TO_CHECK}" | cut -f1 -d" ")

if [[ "${#}" -gt 1 ]]
then
  echo "Error: enter only 1 argument!"
  exit 1
elif [[ "${#}" -lt 1 ]]
then  
echo "Error: enter at least 1 argument!"
  exit 1
fi

if [[ -f "SHA${FILE_TO_CHECK}.txt" ]]
then
  echo "Existing checksum found"
  echo "Comparing checksums!"
  sleep 2
  EXISTING_CHECKSUMMED=$(cat "SHA${FILE_TO_CHECK}.txt")
  echo "${CHECKSUMMED}"
  echo "${EXISTING_CHECKSUMMED}"
  sleep 10
  if [[ "${CHECKSUMMED}" == "${EXISTING_CHECKSUMMED}" ]]
  then
    echo "This file has not been modified!"
  fi
else
  echo "Writing checksum to file"
  echo "${CHECKSUMMED}"
  echo "${FILE_TO_CHECK}"
  sleep 5
  echo "${CHECKSUMMED}" > "SHA${FILE_TO_CHECK}.txt"
fi
