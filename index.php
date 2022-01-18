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

//Вывод заказов
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
	JOIN product ON shoppingcart.productID = product.id")
	->fetchAll();

echo "Все заказы:<br>";
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

echo "<br>";

//Вывод заказов и корзин
$result2 = $db->pdo
	->query("SELECT `order`.`id` as `id заказа`, 
	`order`.`date` as `Дата заказа`, 
	user.firstName as `Имя`, 
	user.lastName as `Фамилия`, 
	product.id as `id продукта`, 
	product.name as `Наименование продукта`, 
	product.price as `Цена`
	FROM `user` 
	LEFT JOIN shoppingcart ON shoppingcart.userID = user.id
	LEFT JOIN `order` ON shoppingcart.id = `order`.shopcartID
	LEFT JOIN product ON shoppingcart.productID = product.id")
	->fetchAll();

echo "Все заказы, пользователи и корзины:<br>";
echo "<table border='1' cellspacing='0' width='50%'>";
echo "<tr>";
foreach ($result2[0] as $key => $value)
{
	echo "<th>$key</th>";
}
echo "</tr>";
for ($i = 0; $i < count($result2); $i++)
{
	echo "<tr>";
	foreach ($result2[$i] as $key => $value)
	{
		echo "<td>$value</td>";
	}
	echo "</tr>";
}
echo "</table>";

echo "<br>";

//Вывод пользователей и их заказов
$result3 = $db->pdo
	->query("SELECT `order`.`id` as `id заказа`, 
	`order`.`date` as `Дата заказа`, 
	user.firstName as `Имя`, 
	user.lastName as `Фамилия`, 
	product.id as `id продукта`, 
	product.name as `Наименование продукта`, 
	product.price as `Цена`
	FROM `order` 
	LEFT JOIN shoppingcart ON shoppingcart.id = `order`.shopcartID 
	RIGHT JOIN user ON shoppingcart.userID = user.id 
	LEFT JOIN product ON shoppingcart.productID = product.id")
	->fetchAll();

echo "Все пользователи и сделанные ими заказы:<br>";
echo "<table border='1' cellspacing='0' width='50%'>";
echo "<tr>";
foreach ($result3[0] as $key => $value)
{
	echo "<th>$key</th>";
}
echo "</tr>";
for ($i = 0; $i < count($result3); $i++)
{
	echo "<tr>";
	foreach ($result3[$i] as $key => $value)
	{
		echo "<td>$value</td>";
	}
	echo "</tr>";
}
echo "</table>";
echo "<br>";

//Топ 5 самых дорогих товаров
$result4 = $db->pdo
	->query("SELECT * FROM product ORDER BY price DESC LIMIT 5")
	->fetchAll();

echo "<table border='1' cellspacing='0' width='50%'>";
echo "<tr>";
foreach ($result4[0] as $key => $value)
{
	echo "<th>$key</th>";
}
echo "</tr>";
for ($i = 0; $i < count($result4); $i++)
{
	echo "<tr>";
	foreach ($result4[$i] as $key => $value)
	{
		echo "<td>$value</td>";
	}
	echo "</tr>";
}
echo "</table>";
echo "<br>";
