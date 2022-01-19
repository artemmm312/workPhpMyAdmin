-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 18 2022 г., 15:07
-- Версия сервера: 10.4.20-MariaDB
-- Версия PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `shopcartID` int(11) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `order`
--

INSERT INTO `order` (`id`, `shopcartID`, `date`) VALUES
(5, 1, '2022-01-17 11:10:00'),
(6, 5, '2022-01-16 14:11:00'),
(7, 9, '2022-01-11 14:40:00'),
(8, 10, '2022-01-12 14:19:00'),
(9, 11, '2022-01-14 12:20:00'),
(10, 12, '2022-01-14 12:41:00'),
(11, 13, '2022-01-15 11:33:00'),
(12, 14, '2022-01-15 14:43:00'),
(13, 15, '2022-01-14 14:00:00'),
(14, 16, '2022-01-17 18:12:00'),
(15, 19, '2022-01-13 11:45:00');

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `name`, `price`) VALUES
(1, 'Мандарин', 2),
(2, 'Банан', 3),
(5, 'Арбуз', 6),
(6, 'Яблоко', 1),
(9, 'Ананас', 5),
(10, 'Телевизор', 100),
(11, 'Компьютер', 200),
(12, 'Ноутбук', 220),
(13, 'Стол', 50),
(14, 'Стул', 25),
(15, 'Ковёр', 35),
(16, 'Смартфон', 110),
(17, 'Часы', 60);

-- --------------------------------------------------------

--
-- Структура таблицы `shoppingcart`
--

CREATE TABLE `shoppingcart` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `productID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `shoppingcart`
--

INSERT INTO `shoppingcart` (`id`, `userID`, `productID`) VALUES
(1, 7, 5),
(3, 8, 1),
(5, 3, 2),
(7, 4, 6),
(9, 14, 12),
(10, 12, 5),
(11, 18, 13),
(12, 18, 14),
(13, 18, 15),
(14, 18, 10),
(15, 16, 11),
(16, 16, 13),
(17, 4, 17),
(18, 4, 9),
(19, 17, 12),
(20, 15, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstName` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `firstName`, `lastName`) VALUES
(3, 'Иван', 'Иванов'),
(4, 'Сергей', 'Серебряков'),
(7, 'Максим', 'Коваль'),
(8, 'Егор', 'Беляев'),
(11, 'Михаил', 'Иванов'),
(12, 'Дмитрий', 'Кукушкин'),
(13, 'Алексей', 'Богданов'),
(14, 'Валерий', 'Мельников'),
(15, 'Екатерина', 'Матулевич'),
(16, 'Денис', 'Гусаков'),
(17, 'Константин', 'Супруненко'),
(18, 'Мария', 'Якуненко');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shopcartID` (`shopcartID`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shoppingcart`
--
ALTER TABLE `shoppingcart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userID` (`id`,`userID`),
  ADD KEY `productID` (`id`,`productID`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `shoppingcart`
--
ALTER TABLE `shoppingcart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`shopcartID`) REFERENCES `shoppingcart` (`id`);

--
-- Ограничения внешнего ключа таблицы `shoppingcart`
--
ALTER TABLE `shoppingcart`
  ADD CONSTRAINT `shoppingcart_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `shoppingcart_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
