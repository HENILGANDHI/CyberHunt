
#!/bin/bash

echo "Installing prerequisite for cyberhunt tool."

sudo apt-get install shc
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/ffuf/ffuf/v2@latest
go install -v github.com/LukaSikic/subzy@latest
go install -v github.com/projectdiscovery/notify/cmd/notify@latest
wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip
unzip findomain-linux.zip  
mv findomain /root/go/bin
chmod 777 /root/go/bin/findomain
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

shc -f cyberhunt.sh   
mv cyberhunt.sh.x cyberhunt
cp cyberhunt /root/go/bin
chmod 777 /root/go/bin/cyberhunt
rm -rf cyberhunt.sh

cd /root/.config/
mkdir notify
wget "https://raw.githubusercontent.com/projectdiscovery/notify/main/cmd/integration-test/test-config.yaml" 
mv test-config.yaml provider_config.yaml
mv provider-config.yaml /root/.config/notify/
echo "Installation completed!"


echo -e "ADD YOUR OWN WEBHOOK URL IN /root/.config/notify/provider_config.yaml"


