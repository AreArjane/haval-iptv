# Check paths and permissions of key files
ls -l /etc/openvpn/server/keys/dh2048.pem
ls -l /etc/openvpn/server/keys/ca.crt
ls -l /etc/openvpn/server/keys/server.crt
ls -l /etc/openvpn/server/keys/server.key

# Set correct permissions
sudo chmod 644 /etc/openvpn/server/keys/dh2048.pem
sudo chmod 644 /etc/openvpn/server/keys/ca.crt
sudo chmod 644 /etc/openvpn/server/keys/server.crt
sudo chmod 600 /etc/openvpn/server/keys/server.key
sudo chown root:root /etc/openvpn/server/keys/*

port 1194
proto udp
dev tun
ca /etc/openvpn/server/keys/ca.crt
cert /etc/openvpn/server/keys/server.crt
key /etc/openvpn/server/keys/server.key
dh /etc/openvpn/server/keys/dh2048.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
comp-lzo
persist-key
persist-tun
status /run/openvpn-server/status-server.log
verb 3


sudo systemctl daemon-reload
sudo systemctl restart openvpn@server.service


cd /etc/openvpn/easy-rsa/
./easyrsa gen-req client1 nopass
./easyrsa sign-req client client1
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
verb 3

<ca>
<cert>
<key>
<tls-auth>

