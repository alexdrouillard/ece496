import requests
import json


def make_query(query):
    url = "http://142.150.199.211:30001/api/v1/query"

    response = requests.get(
        f"{url}", params={"query": query}
    )

    return response.json()


if __name__ == "__main__":
    queries = [
        'rate(container_network_receive_packets_total{pod=~".*service.*"}[1000m:1m])',
        'rate(container_network_transmit_packets_total{pod=~".*service.*"}[1000m:1m])',
        'rate(container_cpu_usage_seconds_total{pod=~".*service.*"}[1000m:1m])',
        'rate(container_memory_usage_bytes{pod=~".*service.*"}[1000m:1m])',
    ]

    query_names = [
            "network receive packets",
            "network transmit packets",
            "cpu usage",
            "memory usage"
    ]

    jsons = map(make_query, queries) 

    for json_data, query in zip(jsons, query_names):
        with open(query + ".json", "w+") as f:
            json.dump(json_data, f, indent=4)
