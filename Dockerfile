FROM telegraf:1.22.1

RUN apt update \
  && apt install -y python curl build-essential python-dev libpq-dev \
  && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
  && python get-pip.py \
  && pip install psycopg2-binary psycopg2 pytz python-dateutil pytoml \
  && apt remove -y build-essential python-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/* get-pip.py

RUN mkdir -p /opt/pg_custom/
COPY line_protocol.py postgresql_custom_data.conf postgresql_query.py /opt/pg_custom/
COPY queries /opt/pg_custom/queries/

RUN ls /opt/pg_custom/
