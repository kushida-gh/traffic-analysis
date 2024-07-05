$filePath = Read-Host "Enter the complete path to the PCAP file:"

# Look for DNS A record requests
& 'C:\Program Files\Wireshark\tshark.exe' -nnr $filePath -Y "(dns.flags.response == 0) && (dns.qry.type == 1)" -e dns.qry.name -Tfields | Sort-Object -Unique | Out-File $filePath-dns-requests-a-records-sorted.txt

# Look for non-DNS A record requests
& 'C:\Program Files\Wireshark\tshark.exe' -nnr $filePath -Y "(dns.flags.response == 0) && !(dns.qry.type == 1)" -e dns.qry.name -Tfields | Sort-Object -Unique | Out-File $filePath-dns-requests-non-a-records-sorted.txt

# Look for TLS Client Hello SNIs
& 'C:\Program Files\Wireshark\tshark.exe' -nnr $filePath -Y "tls.handshake.type == 1" -e tls.handshake.extensions_server_name -Tfields | Sort-Object -Unique | Out-File $filePath-tls-sni-sorted.txt

# Look for HTTP Host header names
& 'C:\Program Files\Wireshark\tshark.exe' -nnr $filePath -Y 'http.request.method == "GET" || http.request.method == "POST"' -e http.host -Tfields | Sort-Object -Unique | Out-File $filePath-http-hosts-sorted.txt
