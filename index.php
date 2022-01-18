<?php

class Connection
{
	private static Connection $instance;
	private PDO $pdo;

	private function __construct()
	{
		require_once 'configuration.php';
		$dsn = 'mysql:dbname=' . $conf['database'] . ';host=' . $conf['host'];
		$user = $conf['user'];
		$password = $conf['password'];
		$opt = [
			PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
			PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
			PDO::ATTR_EMULATE_PREPARES   => false,
		];
		$this->pdo = new PDO($dsn, $user, $password, $opt);
	}

	public static function getInstance(): Connection
	{
		if (!isset(self::$instance))
			self::$instance = new self();
		return self::$instance;
	}

	public function __get(string $name): PDO
	{
		if ($name === 'pdo')
			return $this->pdo;
	}

	private function __clone(): void
	{
	}

	public function __wakeup(): void
	{
		throw new \Exception("Cannot unserialize a singleton.");
	}
}

$db = Connection::getInstance();

$result = $db->pdo
	->query("SELECT `order`.`id` as `id заказа`, 
	`order`.`date` as `Дата заказа`, 
	user.firstName as `Имя`, 
	user.lastName as `Фамилия`, 
	product.id as `id продукта`, 
	product.name as `Наименование продукта`, 
	product.price as `Цена`
	FROM `order` 
	JOIN shoppingcart ON shoppingcart.id = `order`.shopcartID 
	JOIN user ON shoppingcart.userID = user.id 
	JOIN product ON shoppingcart.productID = product.id;")
	->fetchAll();

echo "<table border='1' cellspacing='0' width='50%'>";
echo "<tr>";
foreach ($result[0] as $key => $value)
{
	echo "<th>$key</th>";
}
echo "</tr>";
for ($i = 0; $i < count($result); $i++)
{
	echo "<tr>";
	foreach ($result[$i] as $key => $value)
	{
		echo "<td>$value</td>";
	}
	echo "</tr>";
}
echo "</table>";
