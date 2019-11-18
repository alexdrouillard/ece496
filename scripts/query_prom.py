import requests
import json
import time


def make_query(query):
    url = "http://142.150.199.211:30001/api/v1/query"

    response = requests.get(f"{url}", params={"query": query})

    return response.json()


def make_range_query(query, start_time=None, duration=10):
    """
    Makes a range query from start_time to start_time - duration (hours).

    By default, start_time will be the time this is called.

    """
    url = "http://142.150.199.211:30001/api/v1/query_range"
    start_time = time.time() if start_time is None else start_time
    params = {
        "query": query,
        "start": start_time - duration * 60,
        "end": start_time,
        "step": 60.0,
    }

    response = requests.get(f"{url}", params=params)

    return response.json()


if __name__ == "__main__":
    data_rate = "[1m]"

    queries = [
        'rate(container_network_receive_packets_total{pod=~".*service.*"}'
        + data_rate
        + ")",
        'rate(container_network_transmit_packets_total{pod=~".*service.*"}'
        + data_rate
        + ")",
        'rate(container_cpu_usage_seconds_total{pod=~".*service.*"}'
        + data_rate
        + ")",
        'rate(container_memory_usage_bytes{pod=~".*service.*"}'
        + data_rate
        + ")",
    ]

    query_names = [
        "network_receive_packets",
        "network_transmit_packets",
        "cpu_usage",
        "memory_usage",
    ]

    jsons = []
    for query in queries:
        jsons.append(make_range_query(query))

    for json_data, query in zip(jsons, query_names):
        with open(query + ".json", "w+") as f:
            json.dump(json_data, f, indent=4)
