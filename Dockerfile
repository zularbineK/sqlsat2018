
FROM mcr.microsoft.com/mssql-tools

# create directory within SQL container for database files
RUN mkdir -p /mssql-scripts

# copy the database files from host to container
COPY . /mssql-scripts

RUN chmod 0755 /mssql-scripts/*

# set environment variables
#ENV MSSQL_SA_PASSWORD=P@ssw0rd
#ENV ACCEPT_EULA=Y

# run initial scripts
#CMD [ "sqlcmd -S sqlserver -U sa -P Bangladesh@1 -i /opt/mssql-scripts/tsql-1.sql" ] 

#ENTRYPOINT [ "/opt/mssql-tools/bin/sqlcmd", "-S sqlserver -U sa -P Bangladesh@1 -i /opt/mssql-scripts/tsql-1.sql" ]#


#ENTRYPOINT ["/mssql-scripts/runscript.sh"]
#CMD ["/opt/mssql-tools/bin/sqlcmd", "/mssql-scripts/runscript.sh"]

WORKDIR /mssql-scripts

CMD ./runscript.sh