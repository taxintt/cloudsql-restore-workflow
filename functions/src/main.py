import sqlalchemy

db_name = "sample-db-v1"
db_user = "root"
db_password = "thisisroot"
table_name = "sample"
# table_field = ""
# table_field_value = ""

def insert(request):
    request_json = request.get_json()
    project = request_json['project']
    region = request_json['region']
    instance_name = request_json['instance']
    connection_name = f'{project}:{region}:{instance_name}' # # i.e "<PROJECT-NAME>:<INSTANCE-REGION>:<INSTANCE-NAME>"

    setup_stmt = sqlalchemy.text(f'CREATE {table_name} entries (guestName VARCHAR(255), content VARCHAR(255)')
    select_stmt = sqlalchemy.text(f'SELECT * FROM {table_name}')

    driver_name = 'mysql+pymysql'
    query_string = dict({"unix_socket": "/cloudsql/{}".format(connection_name)})

    db = sqlalchemy.create_engine(
      sqlalchemy.engine.url.URL(
        drivername=driver_name,
        username=db_user,
        password=db_password,
        database=db_name,
        query=query_string,
      ),
      pool_size=5,
      max_overflow=2,
      pool_timeout=30,
      pool_recycle=1800
    )
    try:
        with db.connect() as conn:
            conn.execute(setup_stmt)
            conn.execute(select_stmt)
    except Exception as e:
        return 'Error: {}'.format(str(e))
    return 'ok'