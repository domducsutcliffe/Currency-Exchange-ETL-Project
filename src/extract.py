import requests


def lambda_handler(event, context):

    response = requests.get(
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json"
    )
    data = response.json()

    return_data = {"date": data["date"], "eur": {"usd": data["eur"]["usd"]}}

    return return_data
