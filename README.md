# NightscoutNotifier

A Swift script to monitor Nightscout server glucose levels and send push notifications using APNs.

## Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/NightscoutNotifier.git
    cd NightscoutNotifier
    ```

2. Configure environment variables in your Northflank project:
    - `NIGHTSCOUT_URL`
    - `APNS_KEY_ID`
    - `APNS_TEAM_ID`
    - `APNS_BUNDLE_ID`
    - `APNS_P8_FILE`
    - `DEVICE_TOKENS`

3. Build and run the project locally:
    ```bash
    swift build
    ./.build/release/NightscoutNotifier
    ```

4. Deploy to Northflank:
    - Follow the steps to create a new service, configure environment variables, and set up a cron job to run the script every 5 minutes.
