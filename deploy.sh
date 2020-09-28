echo "Stop octopus-local."
systemctl is-active --quiet octopus-local && systemctl stop octopus-local

docker-compose down

if [ ! -d "mssql" ]; then
    echo "Create mssql folder."
    mkdir mssql
    echo "Set owner of mssql/."
    chown -R mssql:0 mssql/
    echo "mssql/ configured."
fi

if [ ! -d "sqlserver" ]; then
    echo "Create sqlserver folder."
    mkdir sqlserver
    echo "Set owner of sqlserver/."
    chown -R mssql:0 sqlserver/
    echo "sqlserver/ configured."
fi

docker-compose up -d
mv octopus-local.service /etc/systemd/system
mv octopus.local /etc/nginx/sites-available

echo "Start octopus-local."
systemctl is-enabled --quiet octopus-local || systemctl enable octopus-local
systemctl start octopus-local
echo "Reload systemctl daemon."
systemctl daemon-reload
echo "Restart nginx."
systemctl restart nginx

write_highlight "[octopus.local](https://octopus.local)"

exit 0
