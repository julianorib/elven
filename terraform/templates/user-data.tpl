#!/bin/bash

yum install nginx -y
systemctl start nginx

cat <<EOF | tee /usr/share/nginx/html/index.html
<html>
  <body>
    <h1>Imagem do S3</h1>
    <img src="https://${BUCKET}.s3.${REGION}.amazonaws.com/bike.jpg" width="450" height="300" alt="Imagem">
    <br>
  </body>
</html>
EOF

echo $(hostname -s) >> /usr/share/nginx/html/index.html