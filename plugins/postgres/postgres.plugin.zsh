export PGVERSION=`pg_config --version | awk '{print $2}'`
export POSTGRES_BIN=`pg_config --bindir`
COMMON_PGDATA_PATHS=("/usr/local/var/postgres" "/var/pgsql" "/Library/Server/PostgreSQL/Data")
for possible in "${COMMON_PGDATA_PATHS[@]}"
do
   :
   if [ -f "$possible/pg_hba.conf" ]
   then
     # echo "PGDATA: $possible"
     export PGDATA=$possible
   fi
done

# Starts PostgresSQL server
function postgres_start {
  echo 'Starting PostgresSQL Server....';
  $POSTGRES_BIN/pg_ctl -D $PGDATA -l $PGDATA/logfile  start
}

# Stops PostgresSQL server
function postgres_stop {
  echo 'Stopping PostgresSQL Server....';
  $POSTGRES_BIN/pg_ctl -D $PGDATA -l $PGDATA/logfile stop -s -m fast
}

# Returns status of PostgresSQL server
function postgres_status {
  # $POSTGRES_BIN/pg_ctl -D $PGDATA status
  if [[ $(is_postgres_running) == "no server running" ]]
  then
    echo "Postgres service [STOPPED]"
  else
    echo "Postgres service [RUNNING]"
  fi
}

function is_postgres_running {
  $POSTGRES_BIN/pg_ctl -D $PGDATA status | egrep -o "no server running"
}

# Restarts status of PostgresSQL server
function postgres_restart {
  echo 'Restarting Postgres....';
  $POSTGRES_BIN/pg_ctl -D $PGDATA restart
}

# View the last 500 lines from logfile
function postgres_logfile {
  tail -500 $PGDATA/logfile | less
}

# View the last 500 lines from server.log
function postgres_serverlog {
  tail -500 $PGDATA/server.log | less
}
