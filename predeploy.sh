if id "mssql" >/dev/null 2>&1; then
    echo "User mssql exists."
else
    echo "Create user mssql."
    useradd -M -s /bin/bash -u 10001 -g 0 mssql
fi
