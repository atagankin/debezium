Тестирование debezium для PostgreSQL
Полезные команды
docker exec -it kafka-connect-kafka-connect-1 bash
-- Проверка доступных коннекторов
curl -s http://localhost:8083/connector-plugins | jq
-- Проверка зарегистрированных коннекторов
curl -s http://localhost:8083/connectors | jq
-- Удалить коннектор
curl -X DELETE http://localhost:8083/connectors/debezium-source-connector
-- Зарегистрировать коннектор
curl -X POST -H "Content-Type: application/json" --data @connectors/debezium-source.json http://localhost:8083/connectors
-- Статус коннектора и worker'ов
curl -s http://localhost:8083/connectors/debezium-source-connector/status | jq