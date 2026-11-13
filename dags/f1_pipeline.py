from datetime import datetime, timedelta, timezone

from airflow.providers.standard.operators.bash import BashOperator
from airflow.sdk import DAG

PROJECT_DIR = "/opt/airflow/f1"
VENV_BIN = "/opt/airflow/f1-venv/bin"

with DAG(
    dag_id="f1_pipeline",
    description="Load Formula 1 data and build the dbt models",
    start_date=datetime(2026, 1, 1, tzinfo=timezone.utc),
    schedule=None,
    catchup=False,
    max_active_runs=1,
    tags=["depi", "session30", "f1"],
) as dag:
    extract_load = BashOperator(
        task_id="extract_load",
        bash_command=f"exec {VENV_BIN}/python EL/main.py",
        cwd=PROJECT_DIR,
        execution_timeout=timedelta(minutes=10),
        skip_on_exit_code=None,
        do_xcom_push=False,
    )

    dbt_transform = BashOperator(
        task_id="dbt_transform",
        bash_command=(
            f"exec {VENV_BIN}/dbt build "
            "--project-dir T/f1_analytics --profiles-dir T/f1_analytics "
            "--select +season_summary"
        ),
        cwd=PROJECT_DIR,
        execution_timeout=timedelta(minutes=10),
        skip_on_exit_code=None,
        do_xcom_push=False,
    )

    extract_load >> dbt_transform
