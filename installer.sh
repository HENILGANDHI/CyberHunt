echo "Installing language and command for cyber hunt tool."

sudo apt-get install golang-go
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/tomnomnom/qsreplace@latest
go install -v github.com/ferreiraklet/airixss@latest
cd /root/go/bin
cp subfinder/usr/bin
cp waybackurls/usr/bin
cp gf/usr/bin
cp airixss/usr/bin
cp qsreplace/usr/bin
