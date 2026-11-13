ARG AIRFLOW_BASE_IMAGE=apache/airflow:3.1.5
FROM ${AIRFLOW_BASE_IMAGE}

COPY requirements.txt /tmp/f1-requirements.txt
RUN python -m venv /opt/airflow/f1-venv \
    && /opt/airflow/f1-venv/bin/pip install --no-cache-dir -r /tmp/f1-requirements.txt
