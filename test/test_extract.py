import pytest
from unittest.mock import patch
from src.extract import lambda_handler

mock_data = {
    "date": "2024-08-20",
    "eur": {"usd": 1.12}
}

@patch('requests.get')
def test_lambda_handler_success(mock_get):
    mock_get.return_value.json.return_value = mock_data
    
    result = lambda_handler({}, {})

    expected_result = {"date": "2024-08-20", "eur": {"usd": 1.12}}
    assert result == expected_result

@patch('requests.get')
def test_lambda_handler_different_value(mock_get):
    mock_data_different = {
        "date": "2024-08-20",
        "eur": {"usd": 1.15}
    }
    mock_get.return_value.json.return_value = mock_data_different

    result = lambda_handler({}, {})

    expected_result = {"date": "2024-08-20", "eur": {"usd": 1.15}}
    assert result == expected_result

