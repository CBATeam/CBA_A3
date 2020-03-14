set -e

echo "=> WIP"
exit 1

echo "=> Downloading HEMTT (Linux) ..."
#wget -q --show-progress https://github.com/synixebrett/HEMTT/suites/502768606/artifacts/2584778
curl -v -L -o hemtt-linux.zip https://github.com/synixebrett/HEMTT/suites/502768606/artifacts/2584778/linux

echo "=> Extracting HEMTT (Linux) ..."
tar -xzf linux.zip -C ../.
rm linux.zip
