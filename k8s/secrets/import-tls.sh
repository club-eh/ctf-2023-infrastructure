# ctf-2023.clubeh.ca
kubectl create secret tls le-ctf-2023-keypair --cert=../secrets/.lego/certificates/ctf-2023.clubeh.ca.crt --key=../secrets/.lego/certificates/ctf-2023.clubeh.ca.key
# admin.ctf-2023.clubeh.ca
kubectl create secret tls -n monitoring le-admin-ctf-2023-keypair --cert=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.crt --key=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.key
kubectl create secret tls -n ctfd le-admin-ctf-2023-keypair --cert=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.crt --key=../secrets/.lego/certificates/admin.ctf-2023.clubeh.ca.key
