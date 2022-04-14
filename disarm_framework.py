import psycopg2
import csv

class DisarmFramwork:

    def __init__(self, conn, populate_database=False, load_example_data=False):
        self.conn = conn

        self.FRAMEWORK_TABLE_NAMES = [
            "frameworks",
            "phases",
            "tactics",
            "phase_tactics",
            "techniques",
            "tactic_techniques",
            "belongs_to_framework",
            "detections",
            "detects_technique",
            "counters",
            "metatechniques",
            "metatechnique_associations",
            "actortypes",
            "can_perform",
            "framework_association",
            "actor_capable_detections",
        ]

        self.EXAMPLE_DATA_TABLE_NAMES = [
            "actors",
            "campaigns",
            "campaign_actors",
            "detection_events",
            "incidents",
            "campaign_incidents",
            "incident_detections",
            "actors_to_types",
            "narratives",
            "narrative_campaign_support",
            "narrative_assocaited_incident",
            "related_narratives"
        ]

        if populate_database:
            self.load_framework_data()

            if load_example_data:
                self.load_example_data()

    def load_table_from_file(self, table_name, filename):
        print(f"Loading data for table:{table_name} from file:{filename}")
        cur = conn.cursor()

        with open(filename) as infile:
            r = csv.DictReader(infile)
            column_names = r.fieldnames

            query_string = f"UPSERT INTO {table_name}({','.join(column_names)}) VALUES (%({')s, %('.join(column_names)})s)"
            print(f"Query string: {query_string}")
            resp = cur.executemany(
                query_string, r
            )

        conn.commit()

    def load_framework_data(self):
        for table in self.FRAMEWORK_TABLE_NAMES:
            self.load_table_from_file(table, f"framework_objects/{table}.csv")

    def load_example_data():
        # TODO
        return

    def create_database_if_not_exist():

        cur = conn.cursor()
        print('PostgreSQL database version:')
        cur.execute('CREATE DATABASE disarm_framework')


if __name__ == '__main__':

    import configparser

    config = configparser.ConfigParser()
    config.read("database.cfg")
    username = config.get("creds", "username")
    password = config.get("creds", "password")
    host = config.get("conn", "host")
    port = config.get("conn", "port")
    database = config.get("conn", "database")

    # connect to database
    conn = psycopg2.connect(
        user=username,
        password=password,
        host=host,
        port=port,
        database=database
    )

    # create new framework object
    df = DisarmFramwork(conn, True, False)