kubectl create secret tls le-ctf-2023-keypair --cert=../secrets/production/ssl-certificate.pem --key=../secrets/production/ssl-certificate.key
kubectl create secret tls -n monitoring le-admin-ctf-2023-keypair --cert=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.crt --key=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.key
