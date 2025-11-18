# shell_01_basic_scripts

After cloning the repository, open the project folder and run:

```sh
chmod +x *.sh
```

This guarantees every helper script is executable before you call it.

Each filename now carries a numeric prefix (`01_`, `02_`, …). The numbers group related tasks in a logical inspection flow, so you can either run everything sequentially or jump directly to the information you need.

## Script catalog

- `01_cloudflared_mem_usage.sh` – Lists every running Cloudflare/Cloudflared container, executes `docker stats --no-stream`, and prints a table with memory usage, limits, and percentage so you can spot containers close to their cap.
- `02_cloudflared_startup_commands.sh` – Uses `docker inspect` to extract and display the `Cmd` array configured for each tunnel container, making it easy to verify launch arguments or troubleshoot custom parameters.
- `03_cloudflared_mem_limits_inspect.sh` – Reads the memory-related fields from `docker inspect` for each container and echoes the raw values, helping you confirm whether Docker-level limits are applied as expected.
- `04_cloudflared_initial_logs.sh` – Shows the first 40 log lines of every Cloudflare container, which is useful to confirm bootstrap status, configuration loading, or early error messages.
- `05_cloudflared_full_report.sh` – Orchestrates a short health report by calling the memory-usage script and, in-line, dumping startup commands, memory limits, and the first 20 log lines for each container.
- `06_cloudflared_connection_count.sh` – Parses the logs for `Registered tunnel connection` entries and prints how many QUIC/HTTP2 connections each container registered, indicating current tunnel redundancy.
- `07_cloudflared_ingress_rule_count.sh` – Counts occurrences of `"hostname"` in the logs to estimate how many ingress rules (hostnames) are currently configured for each tunnel.
- `08_cloudflared_ingress_weight_compare.sh` – Gathers the ingress sections from the logs, splits them, and counts entries to compare how “heavy” (complex) each configuration file is.
- `09_cloudflared_retries_by_hostname.sh` – Extracts hostname retry events from the logs, groups them, and shows a descending list so you can identify which hostnames are reconnecting most often.
- `10_cloudflared_conn_index_summary.sh` – Searches for `connIndex=<n>` in the logs, aggregates the counts, and prints the top occurrences to highlight repeated QUIC reconnection attempts per container.
- `11_cloudflared_service_count.sh` – Counts the `"service"` entries inside each container log to reveal how many services each tunnel is publishing through Cloudflare Access.
