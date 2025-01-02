from datetime import datetime

import pytz  # For timezone support
from airflow.api.common.experimental.trigger_dag import trigger_dag
from airflow.models import DagBag
from airflow.plugins_manager import AirflowPlugin
from flask import Blueprint, request, render_template, flash, redirect, url_for

# Blueprint for custom UI
trigger_dag_blueprint = Blueprint(
    "trigger_dag_blueprint", __name__,
    template_folder="templates",
    static_folder="static"
)


@trigger_dag_blueprint.route('/trigger_dag_form', methods=['GET', 'POST'])
def trigger_dag_form():
    dag_bag = DagBag()
    dag_ids = sorted(dag_bag.dags.keys())  # Fetch all DAG IDs

    if request.method == 'POST':
        dag_ids = request.form.getlist('dag_ids')  # Get multiple DAG IDs
        execution_time = request.form.get('execution_time')

        try:
            # Handle both formats (with and without seconds)
            try:
                execution_date = datetime.strptime(execution_time, "%Y-%m-%dT%H:%M:%S")
            except ValueError:
                execution_date = datetime.strptime(execution_time, "%Y-%m-%dT%H:%M")

            # Localize the execution_date to the Airflow timezone (default: UTC)
            airflow_timezone = pytz.timezone("UTC")  # Replace "UTC" with your desired timezone
            execution_date = airflow_timezone.localize(execution_date)

            # Trigger each DAG
            for dag_id in dag_ids:
                trigger_dag(
                    dag_id=dag_id,
                    run_id=f"manual__{execution_date.isoformat()}",
                    conf={},
                    execution_date=execution_date
                )
            flash(f"Spider's {', '.join(dag_ids)} successfully scheduled for {execution_date}.", "success")
        except Exception as e:
            flash(f"Error triggering Spider's: {str(e)}", "error")

        return redirect(url_for('trigger_dag_blueprint.trigger_dag_form'))

    return render_template('trigger_dag.html', dag_ids=dag_ids)


# Airflow Plugin Definition
class TriggerDagPlugin(AirflowPlugin):
    name = "trigger_dag_plugin"
    flask_blueprints = [trigger_dag_blueprint]
    appbuilder_menu_items = [
        {
            "name": "Schedule Script",  # Menu item name
            "category": "Utilities",  # Parent category in the menu
            "href": "/trigger_dag_form",  # URL of your route
        },
    ]
