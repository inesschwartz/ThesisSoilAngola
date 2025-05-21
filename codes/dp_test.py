import os
import pandas as pd
from sqlalchemy import create_engine

# Define PostgreSQL connection parameters
db_user = "inesschwartz"
db_password = "your_password_here"  # Replace with the password you set
db_host = "localhost"
db_port = "5432"
db_name = "inesschwartz"

# Create SQLAlchemy engine
engine = create_engine(f"postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")

# Path to folder with CSVs
csv_folder = "/Users/inesschwartz/Desktop/Thesis/DB_test/reduced"

# Loop through all CSVs and import each to a separate table
for filename in os.listdir(csv_folder):
    if filename.endswith(".csv"):
        table_name = os.path.splitext(filename)[0]
        file_path = os.path.join(csv_folder, filename)

        df = pd.read_csv(file_path)
        print(f"Importing {filename} with {len(df)} rows...")

        # Import to PostgreSQL (replace if already exists)
        df.to_sql(table_name, engine, if_exists='replace', index=False)

print("✅ All tables imported successfully!")
