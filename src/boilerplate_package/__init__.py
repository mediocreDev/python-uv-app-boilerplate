import os
from dotenv import load_dotenv

# Load .env if present
load_dotenv()

def main() -> None:
    app_name = os.getenv("APP_NAME", "boilerplate-name")
    env = os.getenv("APP_ENV", "boilerplate-dev")
    debug = os.getenv("APP_DEBUG", "false").lower() == "true"

    print(f"🚀 Starting {app_name}")
    print(f"🌍 Environment: {env}")
    print(f"🐞 Debug mode: {debug}")

if __name__ == "__main__":
    main()