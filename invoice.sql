-- phpMyAdmin SQL Dump
-- version 4.0.10
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 11 2014 г., 16:50
-- Версия сервера: 5.5.38-log
-- Версия PHP: 5.5.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `invoice`
--

-- --------------------------------------------------------

--
-- Структура таблицы `auth_assignment`
--

CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('admin', '3', 1418052545),
('manager', '2', 1418052545),
('superadmin', '4', 1418052545),
('user', '1', 1418052545),
('user', '5', 1418203047),
('user', '6', 1418286907);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item`
--

CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('admin', 1, 'Admin', 'group', NULL, 1418052545, 1418052545),
('manager', 1, 'Manager', 'group', NULL, 1418052545, 1418052545),
('superadmin', 1, 'Superadmin', 'group', NULL, 1418052545, 1418052545),
('user', 1, 'User', 'group', NULL, 1418052545, 1418052545);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item_child`
--

CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('superadmin', 'admin'),
('admin', 'manager'),
('manager', 'user');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_rule`
--

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_rule`
--

INSERT INTO `auth_rule` (`name`, `data`, `created_at`, `updated_at`) VALUES
('group', 'O:29:"app\\components\\rbac\\GroupRule":3:{s:4:"name";s:5:"group";s:9:"createdAt";i:1418052545;s:9:"updatedAt";i:1418052545;}', 1418052545, 1418052545);

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email_confirm_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `def_lang_id` int(11) NOT NULL DEFAULT '1',
  `country_id` int(11) NOT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_index` int(11) DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_user_id` (`user_id`),
  KEY `idx_client_email` (`email`),
  KEY `idx_client_def_lang_id` (`def_lang_id`),
  KEY `idx_company_email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id`, `name`, `user_id`, `email`, `email_confirm_token`, `password_hash`, `password_reset_token`, `auth_key`, `created_at`, `updated_at`, `def_lang_id`, `country_id`, `city`, `street`, `post_index`, `phone`, `password`) VALUES
(1, 'Fedorov', 3, '1@mu.ru', '', '$2y$13$iLuCWhxjnNoQ7E9bm4zlRe5g6okYUaSCfm8hJj11Iyv3gIL2qDTVS', '', 'LeKPQcSJPBrU9EsnTRg9rI8922OS7q6q', 1418052545, 1418052545, 1, 1, 'Moscwa', '', 2222, '', 'Ys7C'),
(2, 'Alex', 3, '2@mu.ru', '', '$2y$13$8TnqmIT1jhnfjZiRdj8TFubVn8pC2KQNNgJoD80fhjPHCWWKYZ5Z2', '', '1RDxdreA4EvNZBvfPb2Ad1Rc0h8WhMru', 1418052545, 1418052545, 2, 3, 'Minsk', '', NULL, '', 'N6t'),
(3, 'Belikov', 3, '3@mu.ru', '', '$2y$13$X.G4KFKIgbkWqFcDDXQGq.sn6xnanKNaDsuZ5kjEP3GW15HI1vAKO', '', 'BJCNW1HZeCltZ7LrDHoAooDxbj0UBywf', 1418052545, 1418052545, 2, 4, 'Astana', '', NULL, '', 'iud'),
(4, 'Alexey', 3, 'ca@mail.ru', '', '$2y$13$I9M4pepcx7iIxmkHXQKsE.arn8.z8hn2tMI8HqIEjv5sEv.71..h2', '', 'ui3zNx7l2nVm67SAqTV_I7FR3UK-vU1i', 1418183760, 1418183760, 1, 2, 'Kyiv', '', NULL, '', 'oUos');

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `inn` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_index` int(11) DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_site` int(11) DEFAULT NULL,
  `mail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vat_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resp_person` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `company`
--

INSERT INTO `company` (`id`, `name`, `logo`, `country`, `city`, `street`, `post_index`, `phone`, `web_site`, `mail`, `vat_number`, `activity`, `resp_person`) VALUES
(1, 'google', 'Google.jpg', 'Russia', 'Moscow', 'Lenina 1', 60000, '22222222', 22, 'comp@comp.ru', '22', '22', '22'),
(2, 'microsoft', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'gregsys', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'bmw', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_country_lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=469 ;

--
-- Дамп данных таблицы `country`
--

INSERT INTO `country` (`id`, `cid`, `lang_id`, `name`) VALUES
(1, 30, 1, 'Afghanistan'),
(2, 21, 1, 'Albania'),
(3, 22, 1, 'Algeria'),
(4, 23, 1, 'American Samoa'),
(5, 26, 1, 'Andorra'),
(6, 25, 1, 'Angola'),
(7, 24, 1, 'Anguilla'),
(8, 27, 1, 'Antigua and Barbuda'),
(9, 28, 1, 'Argentina'),
(10, 6, 1, 'Armenia'),
(11, 29, 1, 'Aruba'),
(12, 19, 1, 'Australia'),
(13, 20, 1, 'Austria'),
(14, 5, 1, 'Azerbaijan'),
(15, 31, 1, 'Bahamas'),
(16, 34, 1, 'Bahrain'),
(17, 32, 1, 'Bangladesh'),
(18, 33, 1, 'Barbados'),
(19, 3, 1, 'Belarus'),
(20, 36, 1, 'Belgium'),
(21, 35, 1, 'Belize'),
(22, 37, 1, 'Benin'),
(23, 38, 1, 'Bermuda'),
(24, 47, 1, 'Bhutan'),
(25, 40, 1, 'Bolivia'),
(26, 235, 1, 'Bonaire, Sint Eustatius and Saba'),
(27, 41, 1, 'Bosnia and Herzegovina'),
(28, 42, 1, 'Botswana'),
(29, 43, 1, 'Brazil'),
(30, 52, 1, 'British Virgin Islands'),
(31, 44, 1, 'Brunei Darussalam'),
(32, 39, 1, 'Bulgaria'),
(33, 45, 1, 'Burkina Faso'),
(34, 46, 1, 'Burundi'),
(35, 103, 1, 'Côte d`Ivoire'),
(36, 91, 1, 'Cambodia'),
(37, 92, 1, 'Cameroon'),
(38, 10, 1, 'Canada'),
(39, 90, 1, 'Cape Verde'),
(40, 149, 1, 'Cayman Islands'),
(41, 213, 1, 'Central African Republic'),
(42, 214, 1, 'Chad'),
(43, 216, 1, 'Chile'),
(44, 97, 1, 'China'),
(45, 98, 1, 'Colombia'),
(46, 99, 1, 'Comoros'),
(47, 100, 1, 'Congo'),
(48, 101, 1, 'Congo, Democratic Republic'),
(49, 150, 1, 'Cook Islands'),
(50, 102, 1, 'Costa Rica'),
(51, 212, 1, 'Croatia'),
(52, 104, 1, 'Cuba'),
(53, 138, 1, 'Curaçao'),
(54, 95, 1, 'Cyprus'),
(55, 215, 1, 'Czech Republic'),
(56, 73, 1, 'Denmark'),
(57, 231, 1, 'Djibouti'),
(58, 74, 1, 'Dominica'),
(59, 75, 1, 'Dominican Republic'),
(60, 54, 1, 'East Timor'),
(61, 221, 1, 'Ecuador'),
(62, 76, 1, 'Egypt'),
(63, 166, 1, 'El Salvador'),
(64, 222, 1, 'Equatorial Guinea'),
(65, 223, 1, 'Eritrea'),
(66, 14, 1, 'Estonia'),
(67, 224, 1, 'Ethiopia'),
(68, 208, 1, 'Falkland Islands'),
(69, 204, 1, 'Faroe Islands'),
(70, 205, 1, 'Fiji'),
(71, 207, 1, 'Finland'),
(72, 209, 1, 'France'),
(73, 210, 1, 'French Guiana'),
(74, 211, 1, 'French Polynesia'),
(75, 56, 1, 'Gabon'),
(76, 59, 1, 'Gambia'),
(77, 7, 1, 'Georgia'),
(78, 65, 1, 'Germany'),
(79, 60, 1, 'Ghana'),
(80, 66, 1, 'Gibraltar'),
(81, 71, 1, 'Greece'),
(82, 70, 1, 'Greenland'),
(83, 69, 1, 'Grenada'),
(84, 61, 1, 'Guadeloupe'),
(85, 72, 1, 'Guam'),
(86, 62, 1, 'Guatemala'),
(87, 63, 1, 'Guinea'),
(88, 64, 1, 'Guinea-Bissau'),
(89, 58, 1, 'Guyana'),
(90, 57, 1, 'Haiti'),
(91, 67, 1, 'Honduras'),
(92, 68, 1, 'Hong Kong'),
(93, 50, 1, 'Hungary'),
(94, 86, 1, 'Iceland'),
(95, 80, 1, 'India'),
(96, 81, 1, 'Indonesia'),
(97, 84, 1, 'Iran'),
(98, 83, 1, 'Iraq'),
(99, 85, 1, 'Ireland'),
(100, 147, 1, 'Isle of Man'),
(101, 8, 1, 'Israel'),
(102, 88, 1, 'Italy'),
(103, 228, 1, 'Jamaica'),
(104, 229, 1, 'Japan'),
(105, 82, 1, 'Jordan'),
(106, 4, 1, 'Kazakhstan'),
(107, 94, 1, 'Kenya'),
(108, 96, 1, 'Kiribati'),
(109, 105, 1, 'Kuwait'),
(110, 11, 1, 'Kyrgyzstan'),
(111, 106, 1, 'Laos'),
(112, 12, 1, 'Latvia'),
(113, 109, 1, 'Lebanon'),
(114, 107, 1, 'Lesotho'),
(115, 108, 1, 'Liberia'),
(116, 110, 1, 'Libya'),
(117, 111, 1, 'Liechtenstein'),
(118, 13, 1, 'Lithuania'),
(119, 112, 1, 'Luxembourg'),
(120, 116, 1, 'Macau'),
(121, 117, 1, 'Macedonia'),
(122, 115, 1, 'Madagascar'),
(123, 118, 1, 'Malawi'),
(124, 119, 1, 'Malaysia'),
(125, 121, 1, 'Maldives'),
(126, 120, 1, 'Mali'),
(127, 122, 1, 'Malta'),
(128, 125, 1, 'Marshall Islands'),
(129, 124, 1, 'Martinique'),
(130, 114, 1, 'Mauritania'),
(131, 113, 1, 'Mauritius'),
(132, 126, 1, 'Mexico'),
(133, 127, 1, 'Micronesia'),
(134, 15, 1, 'Moldova'),
(135, 129, 1, 'Monaco'),
(136, 130, 1, 'Mongolia'),
(137, 230, 1, 'Montenegro'),
(138, 131, 1, 'Montserrat'),
(139, 123, 1, 'Morocco'),
(140, 128, 1, 'Mozambique'),
(141, 132, 1, 'Myanmar'),
(142, 133, 1, 'Namibia'),
(143, 134, 1, 'Nauru'),
(144, 135, 1, 'Nepal'),
(145, 139, 1, 'Netherlands'),
(146, 143, 1, 'New Caledonia'),
(147, 142, 1, 'New Zealand'),
(148, 140, 1, 'Nicaragua'),
(149, 136, 1, 'Niger'),
(150, 137, 1, 'Nigeria'),
(151, 141, 1, 'Niue'),
(152, 148, 1, 'Norfolk Island'),
(153, 173, 1, 'North Korea'),
(154, 174, 1, 'Northern Mariana Islands'),
(155, 144, 1, 'Norway'),
(156, 146, 1, 'Oman'),
(157, 152, 1, 'Pakistan'),
(158, 153, 1, 'Palau'),
(159, 154, 1, 'Palestine'),
(160, 155, 1, 'Panama'),
(161, 156, 1, 'Papua New Guinea'),
(162, 157, 1, 'Paraguay'),
(163, 158, 1, 'Peru'),
(164, 206, 1, 'Philippines'),
(165, 159, 1, 'Pitcairn Islands'),
(166, 160, 1, 'Poland'),
(167, 161, 1, 'Portugal'),
(168, 162, 1, 'Puerto Rico'),
(169, 93, 1, 'Qatar'),
(170, 163, 1, 'Réunion'),
(171, 165, 1, 'Romania'),
(172, 1, 1, 'Russia'),
(173, 164, 1, 'Rwanda'),
(174, 169, 1, 'São Tomé and Príncipe'),
(175, 172, 1, 'Saint Helena'),
(176, 178, 1, 'Saint Kitts and Nevis'),
(177, 179, 1, 'Saint Lucia'),
(178, 180, 1, 'Saint Pierre and Miquelon'),
(179, 177, 1, 'Saint Vincent and the Grenadines'),
(180, 167, 1, 'Samoa'),
(181, 168, 1, 'San Marino'),
(182, 170, 1, 'Saudi Arabia'),
(183, 176, 1, 'Senegal'),
(184, 181, 1, 'Serbia'),
(185, 175, 1, 'Seychelles'),
(186, 190, 1, 'Sierra Leone'),
(187, 182, 1, 'Singapore'),
(188, 234, 1, 'Sint Maarten'),
(189, 184, 1, 'Slovakia'),
(190, 185, 1, 'Slovenia'),
(191, 186, 1, 'Solomon Islands'),
(192, 187, 1, 'Somalia'),
(193, 227, 1, 'South Africa'),
(194, 226, 1, 'South Korea'),
(195, 232, 1, 'South Sudan'),
(196, 87, 1, 'Spain'),
(197, 220, 1, 'Sri Lanka'),
(198, 188, 1, 'Sudan'),
(199, 189, 1, 'Suriname'),
(200, 219, 1, 'Svalbard and Jan Mayen'),
(201, 171, 1, 'Swaziland'),
(202, 218, 1, 'Sweden'),
(203, 217, 1, 'Switzerland'),
(204, 183, 1, 'Syria'),
(205, 192, 1, 'Taiwan'),
(206, 16, 1, 'Tajikistan'),
(207, 193, 1, 'Tanzania'),
(208, 191, 1, 'Thailand'),
(209, 194, 1, 'Togo'),
(210, 195, 1, 'Tokelau'),
(211, 196, 1, 'Tonga'),
(212, 197, 1, 'Trinidad and Tobago'),
(213, 199, 1, 'Tunisia'),
(214, 200, 1, 'Turkey'),
(215, 17, 1, 'Turkmenistan'),
(216, 151, 1, 'Turks and Caicos Islands'),
(217, 198, 1, 'Tuvalu'),
(218, 53, 1, 'US Virgin Islands'),
(219, 9, 1, 'USA'),
(220, 201, 1, 'Uganda'),
(221, 2, 1, 'Ukraine'),
(222, 145, 1, 'United Arab Emirates'),
(223, 49, 1, 'United Kingdom'),
(224, 203, 1, 'Uruguay'),
(225, 18, 1, 'Uzbekistan'),
(226, 48, 1, 'Vanuatu'),
(227, 233, 1, 'Vatican'),
(228, 51, 1, 'Venezuela'),
(229, 55, 1, 'Vietnam'),
(230, 202, 1, 'Wallis and Futuna'),
(231, 78, 1, 'Western Sahara'),
(232, 89, 1, 'Yemen'),
(233, 77, 1, 'Zambia'),
(234, 79, 1, 'Zimbabwe'),
(235, 19, 2, 'Австралия'),
(236, 20, 2, 'Австрия'),
(237, 5, 2, 'Азербайджан'),
(238, 21, 2, 'Албания'),
(239, 22, 2, 'Алжир'),
(240, 23, 2, 'Американское Самоа'),
(241, 24, 2, 'Ангилья'),
(242, 25, 2, 'Ангола'),
(243, 26, 2, 'Андорра'),
(244, 27, 2, 'Антигуа и Барбуда'),
(245, 28, 2, 'Аргентина'),
(246, 6, 2, 'Армения'),
(247, 29, 2, 'Аруба'),
(248, 30, 2, 'Афганистан'),
(249, 31, 2, 'Багамы'),
(250, 32, 2, 'Бангладеш'),
(251, 33, 2, 'Барбадос'),
(252, 34, 2, 'Бахрейн'),
(253, 3, 2, 'Беларусь'),
(254, 35, 2, 'Белиз'),
(255, 36, 2, 'Бельгия'),
(256, 37, 2, 'Бенин'),
(257, 38, 2, 'Бермуды'),
(258, 39, 2, 'Болгария'),
(259, 40, 2, 'Боливия'),
(260, 235, 2, 'Бонайре, Синт-Эстатиус и Саба'),
(261, 41, 2, 'Босния и Герцеговина'),
(262, 42, 2, 'Ботсвана'),
(263, 43, 2, 'Бразилия'),
(264, 44, 2, 'Бруней-Даруссалам'),
(265, 45, 2, 'Буркина-Фасо'),
(266, 46, 2, 'Бурунди'),
(267, 47, 2, 'Бутан'),
(268, 48, 2, 'Вануату'),
(269, 233, 2, 'Ватикан'),
(270, 49, 2, 'Великобритания'),
(271, 50, 2, 'Венгрия'),
(272, 51, 2, 'Венесуэла'),
(273, 52, 2, 'Виргинские острова, Британские'),
(274, 53, 2, 'Виргинские острова, США'),
(275, 54, 2, 'Восточный Тимор'),
(276, 55, 2, 'Вьетнам'),
(277, 56, 2, 'Габон'),
(278, 57, 2, 'Гаити'),
(279, 58, 2, 'Гайана'),
(280, 59, 2, 'Гамбия'),
(281, 60, 2, 'Гана'),
(282, 61, 2, 'Гваделупа'),
(283, 62, 2, 'Гватемала'),
(284, 63, 2, 'Гвинея'),
(285, 64, 2, 'Гвинея-Бисау'),
(286, 65, 2, 'Германия'),
(287, 66, 2, 'Гибралтар'),
(288, 67, 2, 'Гондурас'),
(289, 68, 2, 'Гонконг'),
(290, 69, 2, 'Гренада'),
(291, 70, 2, 'Гренландия'),
(292, 71, 2, 'Греция'),
(293, 7, 2, 'Грузия'),
(294, 72, 2, 'Гуам'),
(295, 73, 2, 'Дания'),
(296, 231, 2, 'Джибути'),
(297, 74, 2, 'Доминика'),
(298, 75, 2, 'Доминиканская Республика'),
(299, 76, 2, 'Египет'),
(300, 77, 2, 'Замбия'),
(301, 78, 2, 'Западная Сахара'),
(302, 79, 2, 'Зимбабве'),
(303, 8, 2, 'Израиль'),
(304, 80, 2, 'Индия'),
(305, 81, 2, 'Индонезия'),
(306, 82, 2, 'Иордания'),
(307, 83, 2, 'Ирак'),
(308, 84, 2, 'Иран'),
(309, 85, 2, 'Ирландия'),
(310, 86, 2, 'Исландия'),
(311, 87, 2, 'Испания'),
(312, 88, 2, 'Италия'),
(313, 89, 2, 'Йемен'),
(314, 90, 2, 'Кабо-Верде'),
(315, 4, 2, 'Казахстан'),
(316, 91, 2, 'Камбоджа'),
(317, 92, 2, 'Камерун'),
(318, 10, 2, 'Канада'),
(319, 93, 2, 'Катар'),
(320, 94, 2, 'Кения'),
(321, 95, 2, 'Кипр'),
(322, 96, 2, 'Кирибати'),
(323, 97, 2, 'Китай'),
(324, 98, 2, 'Колумбия'),
(325, 99, 2, 'Коморы'),
(326, 100, 2, 'Конго'),
(327, 101, 2, 'Конго, демократическая республика'),
(328, 102, 2, 'Коста-Рика'),
(329, 103, 2, 'Кот д`Ивуар'),
(330, 104, 2, 'Куба'),
(331, 105, 2, 'Кувейт'),
(332, 11, 2, 'Кыргызстан'),
(333, 138, 2, 'Кюрасао'),
(334, 106, 2, 'Лаос'),
(335, 12, 2, 'Латвия'),
(336, 107, 2, 'Лесото'),
(337, 108, 2, 'Либерия'),
(338, 109, 2, 'Ливан'),
(339, 110, 2, 'Ливия'),
(340, 13, 2, 'Литва'),
(341, 111, 2, 'Лихтенштейн'),
(342, 112, 2, 'Люксембург'),
(343, 113, 2, 'Маврикий'),
(344, 114, 2, 'Мавритания'),
(345, 115, 2, 'Мадагаскар'),
(346, 116, 2, 'Макао'),
(347, 117, 2, 'Македония'),
(348, 118, 2, 'Малави'),
(349, 119, 2, 'Малайзия'),
(350, 120, 2, 'Мали'),
(351, 121, 2, 'Мальдивы'),
(352, 122, 2, 'Мальта'),
(353, 123, 2, 'Марокко'),
(354, 124, 2, 'Мартиника'),
(355, 125, 2, 'Маршалловы Острова'),
(356, 126, 2, 'Мексика'),
(357, 127, 2, 'Микронезия, федеративные штаты'),
(358, 128, 2, 'Мозамбик'),
(359, 15, 2, 'Молдова'),
(360, 129, 2, 'Монако'),
(361, 130, 2, 'Монголия'),
(362, 131, 2, 'Монтсеррат'),
(363, 132, 2, 'Мьянма'),
(364, 133, 2, 'Намибия'),
(365, 134, 2, 'Науру'),
(366, 135, 2, 'Непал'),
(367, 136, 2, 'Нигер'),
(368, 137, 2, 'Нигерия'),
(369, 139, 2, 'Нидерланды'),
(370, 140, 2, 'Никарагуа'),
(371, 141, 2, 'Ниуэ'),
(372, 142, 2, 'Новая Зеландия'),
(373, 143, 2, 'Новая Каледония'),
(374, 144, 2, 'Норвегия'),
(375, 145, 2, 'Объединенные Арабские Эмираты'),
(376, 146, 2, 'Оман'),
(377, 147, 2, 'Остров Мэн'),
(378, 148, 2, 'Остров Норфолк'),
(379, 149, 2, 'Острова Кайман'),
(380, 150, 2, 'Острова Кука'),
(381, 151, 2, 'Острова Теркс и Кайкос'),
(382, 152, 2, 'Пакистан'),
(383, 153, 2, 'Палау'),
(384, 154, 2, 'Палестинская автономия'),
(385, 155, 2, 'Панама'),
(386, 156, 2, 'Папуа - Новая Гвинея'),
(387, 157, 2, 'Парагвай'),
(388, 158, 2, 'Перу'),
(389, 159, 2, 'Питкерн'),
(390, 160, 2, 'Польша'),
(391, 161, 2, 'Португалия'),
(392, 162, 2, 'Пуэрто-Рико'),
(393, 163, 2, 'Реюньон'),
(394, 1, 2, 'Россия'),
(395, 164, 2, 'Руанда'),
(396, 165, 2, 'Румыния'),
(397, 9, 2, 'США'),
(398, 166, 2, 'Сальвадор'),
(399, 167, 2, 'Самоа'),
(400, 168, 2, 'Сан-Марино'),
(401, 169, 2, 'Сан-Томе и Принсипи'),
(402, 170, 2, 'Саудовская Аравия'),
(403, 171, 2, 'Свазиленд'),
(404, 172, 2, 'Святая Елена'),
(405, 173, 2, 'Северная Корея'),
(406, 174, 2, 'Северные Марианские острова'),
(407, 175, 2, 'Сейшелы'),
(408, 176, 2, 'Сенегал'),
(409, 177, 2, 'Сент-Винсент'),
(410, 178, 2, 'Сент-Китс и Невис'),
(411, 179, 2, 'Сент-Люсия'),
(412, 180, 2, 'Сент-Пьер и Микелон'),
(413, 181, 2, 'Сербия'),
(414, 182, 2, 'Сингапур'),
(415, 234, 2, 'Синт-Мартен'),
(416, 183, 2, 'Сирийская Арабская Республика'),
(417, 184, 2, 'Словакия'),
(418, 185, 2, 'Словения'),
(419, 186, 2, 'Соломоновы Острова'),
(420, 187, 2, 'Сомали'),
(421, 188, 2, 'Судан'),
(422, 189, 2, 'Суринам'),
(423, 190, 2, 'Сьерра-Леоне'),
(424, 16, 2, 'Таджикистан'),
(425, 191, 2, 'Таиланд'),
(426, 192, 2, 'Тайвань'),
(427, 193, 2, 'Танзания'),
(428, 194, 2, 'Того'),
(429, 195, 2, 'Токелау'),
(430, 196, 2, 'Тонга'),
(431, 197, 2, 'Тринидад и Тобаго'),
(432, 198, 2, 'Тувалу'),
(433, 199, 2, 'Тунис'),
(434, 17, 2, 'Туркменистан'),
(435, 200, 2, 'Турция'),
(436, 201, 2, 'Уганда'),
(437, 18, 2, 'Узбекистан'),
(438, 2, 2, 'Украина'),
(439, 202, 2, 'Уоллис и Футуна'),
(440, 203, 2, 'Уругвай'),
(441, 204, 2, 'Фарерские острова'),
(442, 205, 2, 'Фиджи'),
(443, 206, 2, 'Филиппины'),
(444, 207, 2, 'Финляндия'),
(445, 208, 2, 'Фолклендские острова'),
(446, 209, 2, 'Франция'),
(447, 210, 2, 'Французская Гвиана'),
(448, 211, 2, 'Французская Полинезия'),
(449, 212, 2, 'Хорватия'),
(450, 213, 2, 'Центрально-Африканская Республика'),
(451, 214, 2, 'Чад'),
(452, 230, 2, 'Черногория'),
(453, 215, 2, 'Чехия'),
(454, 216, 2, 'Чили'),
(455, 217, 2, 'Швейцария'),
(456, 218, 2, 'Швеция'),
(457, 219, 2, 'Шпицберген и Ян Майен'),
(458, 220, 2, 'Шри-Ланка'),
(459, 221, 2, 'Эквадор'),
(460, 222, 2, 'Экваториальная Гвинея'),
(461, 223, 2, 'Эритрея'),
(462, 14, 2, 'Эстония'),
(463, 224, 2, 'Эфиопия'),
(464, 226, 2, 'Южная Корея'),
(465, 227, 2, 'Южно-Африканская Республика'),
(466, 232, 2, 'Южный Судан'),
(467, 228, 2, 'Ямайка'),
(468, 229, 2, 'Япония');

-- --------------------------------------------------------

--
-- Структура таблицы `currency`
--

CREATE TABLE IF NOT EXISTS `currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `goods`
--

CREATE TABLE IF NOT EXISTS `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `measure_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `excise` decimal(10,2) DEFAULT NULL,
  `tax` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `goods`
--

INSERT INTO `goods` (`id`, `invoice_id`, `name`, `measure_id`, `amount`, `price`, `excise`, `tax`) VALUES
(1, 1, 'Косоролики', 1, 1, '10.00', NULL, '18.00'),
(2, 1, 'Кособобики', 1, 1, '11.30', NULL, '18.00');

-- --------------------------------------------------------

--
-- Структура таблицы `income`
--

CREATE TABLE IF NOT EXISTS `income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `manager` float NOT NULL,
  `admin` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `income`
--

INSERT INTO `income` (`id`, `from`, `to`, `manager`, `admin`) VALUES
(1, 1000, 10000, 1.5, 1),
(2, 10000, 100000, 1.8, 1.1),
(3, 100000, 1000000, 2, 1.2),
(4, 1000000, 10000000, 2.5, 1.5);

-- --------------------------------------------------------

--
-- Структура таблицы `invoice`
--

CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT '0',
  `service_id` int(11) NOT NULL DEFAULT '0',
  `price_service` decimal(10,2) NOT NULL DEFAULT '0.00',
  `count` int(11) NOT NULL,
  `vat` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(5,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(5,2) NOT NULL,
  `price` int(11) NOT NULL,
  `is_pay` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_invoice_user` (`user_id`),
  KEY `idx_invoice_client` (`client_id`),
  KEY `idx_invoice_company` (`company_id`),
  KEY `idx_invoice_service` (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `invoice`
--

INSERT INTO `invoice` (`id`, `user_id`, `client_id`, `date`, `name`, `company_id`, `service_id`, `price_service`, `count`, `vat`, `tax`, `discount`, `price`, `is_pay`, `type`) VALUES
(1, 1, 1, '2014-12-05', '1', 1, 1, '200.00', 1, '1.00', '15.00', '4.00', 7, 0, '1'),
(2, 1, 1, '2014-12-05', '1', 1, 1, '500.00', 1, '1.00', '40.00', '10.00', 10, 1, '1'),
(3, 4, 1, '2014-12-08', 'фактура1', 1, 1, '0.00', 1, '1.00', '1.00', '1.00', 0, 0, NULL),
(4, 4, 2, '2014-12-08', 'фактура2', 1, 1, '0.00', 1, '1.00', '1.00', '1.00', 0, 1, NULL),
(5, 4, 1, '2014-12-09', 'фактура3', 1, 1, '1.00', 1, '1.00', '1.00', '1.00', 1, 1, NULL),
(6, 3, 4, '2014-12-09', 'in1', 1, 1, '70.00', 1, '1.00', '20.00', '1.00', 84, 1, 'basic'),
(7, 3, 4, '2014-12-09', 'q', 1, 2, '10.00', 1, '1.00', '2.00', '0.00', 10, 0, 'basic');

-- --------------------------------------------------------

--
-- Структура таблицы `lang`
--

CREATE TABLE IF NOT EXISTS `lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `local` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `default` smallint(6) NOT NULL DEFAULT '0',
  `date_update` int(11) NOT NULL,
  `date_create` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `lang`
--

INSERT INTO `lang` (`id`, `url`, `local`, `name`, `default`, `date_update`, `date_create`) VALUES
(1, 'en', 'en-US', 'English', 0, 1418212522, 1417977687),
(2, 'ru', 'ru-RU', 'Русский', 1, 1417977687, 1417977687);

-- --------------------------------------------------------

--
-- Структура таблицы `measures`
--

CREATE TABLE IF NOT EXISTS `measures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Код единицы измерения',
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Единица измерения',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `measures`
--

INSERT INTO `measures` (`id`, `code`, `name`) VALUES
(1, '796', 'шт'),
(2, '166', 'кг');

-- --------------------------------------------------------

--
-- Структура таблицы `migration`
--

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1418052534),
('m140506_102106_rbac_init', 1418052545),
('m141207_115424_init_bd', 1418052545),
('m141208_155833_translit', 1418107846),
('m141209_054746_user_payment', 1418126529),
('m141209_102718_user_income', 1418126529),
('m141209_124406_countri', 1418134590);

-- --------------------------------------------------------

--
-- Структура таблицы `payment`
--

CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `payment`
--

INSERT INTO `payment` (`id`, `name`) VALUES
(1, 'Bank card'),
(2, 'PayPal'),
(3, 'Банковский перевод');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_currency`
--

CREATE TABLE IF NOT EXISTS `payment_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator_id` int(11) DEFAULT NULL,
  `num_code` char(3) NOT NULL,
  `char_code` char(3) NOT NULL,
  `nominal` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` float NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `last_modify` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `char_code` (`char_code`),
  KEY `fk_uid_pc1` (`operator_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `payment_currency`
--

INSERT INTO `payment_currency` (`id`, `operator_id`, `num_code`, `char_code`, `nominal`, `name`, `value`, `active`, `last_modify`) VALUES
(1, 4, '840', 'USD', 1, 'asd', 0.6604, 1, '2014-10-02 14:00:00'),
(2, 4, '840', 'EUR', 1, 'asasd', 1, 1, '2014-10-02 14:00:00'),
(3, 4, '840', 'UAH', 20, 'asdasdas', 1, 1, '2014-10-02 14:00:01');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_history`
--

CREATE TABLE IF NOT EXISTS `payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `amount` float NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `curs` float DEFAULT NULL,
  `equivalent` float DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_system_id` int(11) NOT NULL,
  `complete` tinyint(1) DEFAULT '0',
  `type` int(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `pay_sys_id` (`payment_system_id`),
  KEY `balance` (`user_id`,`complete`),
  KEY `type` (`type`),
  KEY `fk_uid_ph2` (`operator_id`),
  KEY `fk_cid_ph3` (`currency_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `payment_history`
--

INSERT INTO `payment_history` (`id`, `user_id`, `operator_id`, `amount`, `currency_id`, `curs`, `equivalent`, `description`, `date`, `payment_system_id`, `complete`, `type`) VALUES
(1, NULL, NULL, 1, NULL, 1, 1, 'PayPal: пополнение на 1', '2014-12-11 07:54:36', 1, 0, 30),
(2, NULL, NULL, 20, NULL, 1, 20, 'PayPal: пополнение на 20', '2014-12-11 08:34:43', 1, 0, 30),
(3, NULL, NULL, 0.1, NULL, 1, 0.1, 'PayPal: пополнение на 0.1', '2014-12-11 08:35:30', 1, 0, 30);

-- --------------------------------------------------------

--
-- Структура таблицы `payment_system`
--

CREATE TABLE IF NOT EXISTS `payment_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(128) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `model` (`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `payment_system`
--

INSERT INTO `payment_system` (`id`, `model`, `active`) VALUES
(1, 'PayPal', 1),
(2, 'BankTransfer', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `sellers`
--

CREATE TABLE IF NOT EXISTS `sellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Наименование продавца',
  `address` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Адрес продавца',
  `inn` varchar(12) COLLATE utf8_unicode_ci NOT NULL COMMENT 'ИНН продавца',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `sellers`
--

INSERT INTO `sellers` (`id`, `name`, `address`, `inn`) VALUES
(1, 'ЗАО "Все продам"', 'г. Неизвестный ул. Без имени д.112', '786534652985'),
(2, 'ООО "Рога и копыта"', 'г. Приморск ул. Ленина д.2', '754642308479');

-- --------------------------------------------------------

--
-- Структура таблицы `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `service`
--

INSERT INTO `service` (`id`, `name`) VALUES
(1, 'service1'),
(2, 'service2'),
(3, 'Сервис3');

-- --------------------------------------------------------

--
-- Структура таблицы `setting`
--

CREATE TABLE IF NOT EXISTS `setting` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `credit` decimal(12,3) NOT NULL DEFAULT '0.000',
  `def_vat_id` int(11) NOT NULL DEFAULT '0',
  `def_company_id` int(11) NOT NULL DEFAULT '0',
  `def_lang_id` int(11) NOT NULL DEFAULT '0',
  `bank_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `account_number` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_on` tinyint(1) NOT NULL DEFAULT '1',
  `country` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_index` int(11) DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_site` tinyint(1) DEFAULT NULL,
  `surtax` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `idx_setting_def_vat_id` (`def_vat_id`),
  KEY `idx_setting_def_company_id` (`def_company_id`),
  KEY `idx_setting_def_lang_id` (`def_lang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `setting`
--

INSERT INTO `setting` (`user_id`, `name`, `credit`, `def_vat_id`, `def_company_id`, `def_lang_id`, `bank_code`, `account_number`, `last_login`, `is_on`, `country`, `city`, `street`, `post_index`, `phone`, `web_site`, `surtax`) VALUES
(1, 'no', '0.000', 3, 2, 2, '1111111111', '1111111111', '2014-12-01 00:00:00', 1, 'yyyy', 'yyy', 'yyy', 999999, '67895909', 0, '5.00'),
(2, 'no', '0.000', 1, 1, 1, 'no', 'no', '2014-12-04 12:39:39', 1, 'qq', 'qq', 'qq', 11, 'qq', 0, '5.00'),
(3, 'aaaaa', '75.300', 1, 1, 1, 'no', 'no', '2014-12-04 09:21:05', 1, 'qq', 'qq', 'qq', 11111, 'qq', 0, '5.00'),
(4, 'aaaaa', '125.980', 1, 1, 1, 'no', 'no', '2014-12-04 09:21:05', 1, 'qq', 'qq', 'qq', 11111, 'qq', 0, '5.00'),
(5, '', '0.000', 0, 0, 0, 'no', 'no', '0000-00-00 00:00:00', 1, '', '', '', NULL, '', NULL, NULL),
(6, '', '0.000', 0, 0, 0, 'no', 'no', '0000-00-00 00:00:00', 1, '', '', '', NULL, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `surtax`
--

CREATE TABLE IF NOT EXISTS `surtax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `percent` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `surtax`
--

INSERT INTO `surtax` (`id`, `percent`) VALUES
(1, '20.00');

-- --------------------------------------------------------

--
-- Структура таблицы `translit`
--

CREATE TABLE IF NOT EXISTS `translit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_lang_id` int(11) NOT NULL,
  `to_lang_id` int(11) NOT NULL,
  `from_symbol` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `to_symbol` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_from_lang` (`from_lang_id`),
  KEY `FK_to_lang` (`to_lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=67 ;

--
-- Дамп данных таблицы `translit`
--

INSERT INTO `translit` (`id`, `from_lang_id`, `to_lang_id`, `from_symbol`, `to_symbol`) VALUES
(1, 1, 2, 'а', 'a'),
(2, 1, 2, 'б', 'b'),
(3, 1, 2, 'в', 'v'),
(4, 1, 2, 'г', 'g'),
(5, 1, 2, 'д', 'd'),
(6, 1, 2, 'е', 'e'),
(7, 1, 2, 'ё', 'e'),
(8, 1, 2, 'ж', 'zh'),
(9, 1, 2, 'з', 'z'),
(10, 1, 2, 'и', 'i'),
(11, 1, 2, 'й', 'y'),
(12, 1, 2, 'к', 'k'),
(13, 1, 2, 'л', 'l'),
(14, 1, 2, 'м', 'm'),
(15, 1, 2, 'н', 'n'),
(16, 1, 2, 'о', 'o'),
(17, 1, 2, 'п', 'p'),
(18, 1, 2, 'р', 'r'),
(19, 1, 2, 'с', 's'),
(20, 1, 2, 'т', 't'),
(21, 1, 2, 'у', 'u'),
(22, 1, 2, 'ф', 'f'),
(23, 1, 2, 'х', 'h'),
(24, 1, 2, 'ц', 'c'),
(25, 1, 2, 'ч', 'ch'),
(26, 1, 2, 'ш', 'sh'),
(27, 1, 2, 'щ', 'sch'),
(28, 1, 2, 'ь', ''''),
(29, 1, 2, 'ы', 'y'),
(30, 1, 2, 'ъ', ''''),
(31, 1, 2, 'э', 'e'),
(32, 1, 2, 'ю', 'yu'),
(33, 1, 2, 'я', 'ya'),
(34, 1, 2, 'А', 'A'),
(35, 1, 2, 'Б', 'B'),
(36, 1, 2, 'В', 'V'),
(37, 1, 2, 'Г', 'G'),
(38, 1, 2, 'Д', 'D'),
(39, 1, 2, 'Е', 'E'),
(40, 1, 2, 'Ё', 'E'),
(41, 1, 2, 'Ж', 'Zh'),
(42, 1, 2, 'З', 'Z'),
(43, 1, 2, 'И', 'I'),
(44, 1, 2, 'Й', 'Y'),
(45, 1, 2, 'К', 'K'),
(46, 1, 2, 'Л', 'L'),
(47, 1, 2, 'М', 'M'),
(48, 1, 2, 'Н', 'N'),
(49, 1, 2, 'О', 'O'),
(50, 1, 2, 'П', 'P'),
(51, 1, 2, 'Р', 'R'),
(52, 1, 2, 'С', 'S'),
(53, 1, 2, 'Т', 'T'),
(54, 1, 2, 'У', 'U'),
(55, 1, 2, 'Ф', 'F'),
(56, 1, 2, 'Х', 'H'),
(57, 1, 2, 'Ц', 'C'),
(58, 1, 2, 'Ч', 'Ch'),
(59, 1, 2, 'Ш', 'Sh'),
(60, 1, 2, 'Щ', 'Sch'),
(61, 1, 2, 'Ь', ''''),
(62, 1, 2, 'Ы', 'Y'),
(63, 1, 2, 'Ъ', ''''),
(64, 1, 2, 'Э', 'E'),
(65, 1, 2, 'Ю', 'Yu'),
(66, 1, 2, 'Я', 'Ya');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_confirm_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user_username` (`username`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_role` (`role`),
  KEY `idx_user_status` (`status`),
  KEY `idx_user_parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `username`, `name`, `password_hash`, `password_reset_token`, `email`, `email_confirm_token`, `auth_key`, `role`, `status`, `created_at`, `updated_at`, `parent_id`) VALUES
(1, 'test', '', '$2y$13$B4DPxXs0/GKHt4Z81yiRM.DHwgr5tk4HNyorp1g8VmzWdDtEbMWJW', '', 'test@mail.ru', '', 'OSgDej5fe8zJdRy_N2AshqP3P2e5gTUL', 'user', 10, 1418052545, 1418052545, 0),
(2, 'manager', '', '$2y$13$Ir6j3GVK.Fdh0l7cM8fsGO2QHCKxTNoKKnCZGlqm25KFXwXdR5kTK', '', 'manager@mail.ru', '', '0pIFtMFMleZ_CmZdK240ti2bNyJBH98L', 'manager', 10, 1418052545, 1418052545, 4),
(3, 'admin', '', '$2y$13$9dqaQK3viYvdoAAI0Oy0XuUqfiSJ0saJXM2qYQ2A0TzA1QFV56Q6.', '', 'admin@mail.ru', '', 'pI8Z6XtcXeUKQKEJoPYBazoP5-qo3zmv', 'admin', 10, 1418052545, 1418052545, 4),
(4, 'superadmin', '', '$2y$13$Kqo/vATU4BSO9XT.Xm.jNOz.kIaUBBhCsHm.WHfauI5ZGkDkrXMvK', '', 'superadmin@mail.ru', '', 'MqtOr8ySQ7k2QFMEN3KhX3QBOEw9fDVD', 'superadmin', 10, 1418052545, 1418052545, 0),
(5, '5', '', '$2y$13$8vLJygl1uMoXU6Z.DXzXxe7BmJo/oEokJPQrAxoDGSOZwr5glkeLW', '', 'XeDmitry@yandex.ru', '', 'DL8RiqByjCbtYvwqau-KSrt8__CY4XxO', 'user', 10, 1418203047, 1418203047, 0),
(6, '6', '', '$2y$13$X2nXT43TAzXZ8hwAJgAKFO0t1werM9uxao3V/NKdG/qK8bDG4mZHy', '', 'gergarius@gmail.com', '', 'vGGuYXMv5x01h1UztIXmTdVKAT0js1Yg', 'user', 10, 1418286907, 1418286907, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `user_income`
--

CREATE TABLE IF NOT EXISTS `user_income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `credit` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `profit_manager` decimal(12,3) NOT NULL DEFAULT '0.000',
  `profit_admin` decimal(12,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`),
  KEY `idx_user_income_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `user_income`
--

INSERT INTO `user_income` (`id`, `user_id`, `credit`, `date`, `parent_id`, `profit_manager`, `profit_admin`) VALUES
(1, 4, -19, '2014-12-09 14:16:23', 0, '0.000', '0.000'),
(2, 7, -19, '2014-12-09 14:22:57', 3, '0.000', '0.000'),
(3, 10, 21, '2014-12-09 14:52:11', 3, '0.000', '0.000'),
(4, 4, 0, '2014-12-09 22:57:49', 0, '0.000', '0.000'),
(5, 0, 0, '2014-12-09 07:08:46', 0, '0.000', '0.000'),
(6, 3, 14, '2014-12-09 22:57:49', 4, '0.000', '0.000');

-- --------------------------------------------------------

--
-- Структура таблицы `user_payment`
--

CREATE TABLE IF NOT EXISTS `user_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `txn_id` varchar(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `credit` decimal(12,3) NOT NULL,
  `is_input` tinyint(1) NOT NULL,
  `date` datetime NOT NULL,
  `credit_sum` decimal(14,3) NOT NULL DEFAULT '0.000',
  `profit_parent` decimal(12,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=89 ;

--
-- Дамп данных таблицы `user_payment`
--

INSERT INTO `user_payment` (`id`, `txn_id`, `user_id`, `credit`, `is_input`, `date`, `credit_sum`, `profit_parent`) VALUES
(1, '1', 4, '5.000', 1, '2014-12-09 11:33:43', '0.000', '0.000'),
(2, '1', 4, '5.000', 1, '2014-12-09 11:36:14', '0.000', '0.000'),
(3, '1', 4, '-5.000', 0, '2014-12-09 11:38:32', '0.000', '0.000'),
(4, '1', 4, '6.000', 1, '2014-12-09 12:06:56', '6.000', '0.000'),
(5, '1', 4, '4.000', 1, '2014-12-09 12:18:00', '4.000', '0.000'),
(6, '1', 4, '4.000', 1, '2014-12-09 12:18:45', '4.000', '0.000'),
(7, '1', 4, '6.000', 1, '2014-12-09 12:39:25', '6.000', '0.000'),
(8, '1', 4, '6.000', 1, '2014-12-09 12:39:57', '6.000', '0.000'),
(9, '1', 4, '6.000', 1, '2014-12-09 12:42:17', '6.000', '0.000'),
(10, '5', 4, '6.000', 1, '2014-12-09 12:42:41', '5.400', '0.000'),
(11, '1', 4, '1.000', 1, '2014-12-09 12:42:47', '1.000', '0.000'),
(12, '1', 4, '1.000', 1, '2014-12-09 12:43:42', '1.000', '0.000'),
(13, '1', 4, '1.000', 1, '2014-12-09 13:06:48', '1.000', '0.000'),
(14, '1', 4, '1.000', 1, '2014-12-09 13:08:28', '1.000', '0.000'),
(15, '1', 4, '1.000', 1, '2014-12-09 13:11:09', '1.000', '0.000'),
(16, '1', 4, '1.000', 1, '2014-12-09 13:12:51', '1.000', '0.000'),
(17, '1', 4, '6.000', 1, '2014-12-09 13:15:19', '6.000', '0.000'),
(18, '1', 4, '1.000', 1, '2014-12-09 13:17:03', '1.000', '0.000'),
(19, '1', 4, '1.000', 1, '2014-12-09 13:17:57', '1.000', '0.000'),
(20, '1', 4, '1.000', 1, '2014-12-09 13:18:14', '1.000', '0.000'),
(21, '1', 4, '90.000', 1, '2014-12-09 13:37:46', '90.000', '0.000'),
(22, '1', 4, '20.000', 1, '2014-12-09 13:38:07', '20.000', '0.000'),
(23, '1', 4, '90.000', 1, '2014-12-09 13:42:13', '90.000', '0.000'),
(24, '1', 4, '90.000', 1, '2014-12-09 13:42:52', '90.000', '0.000'),
(25, '1', 8, '-14.000', 0, '2014-12-09 13:43:57', '-14.000', '0.000'),
(26, '1', 4, '7.000', 1, '2014-12-09 14:14:11', '7.000', '0.000'),
(27, '1', 4, '7.000', 1, '2014-12-09 14:16:23', '7.000', '0.000'),
(28, '1', 6, '90.000', 1, '2014-12-09 14:20:24', '90.000', '0.000'),
(29, '1', 7, '90.000', 1, '2014-12-09 14:22:57', '90.000', '0.000'),
(31, '1', 7, '90.000', 1, '2014-12-09 15:25:59', '90.000', '0.000'),
(33, '1', 7, '7.000', 1, '2014-12-09 16:21:43', '7.000', '0.000'),
(34, '1', 7, '7.000', 1, '2014-12-09 16:22:36', '7.000', '0.000'),
(35, '1', 7, '7.000', 1, '2014-12-09 16:24:56', '7.000', '0.000'),
(44, '1', 7, '99.000', 1, '2014-12-09 16:43:09', '99.000', '0.000'),
(46, '1', 7, '-3.200', 0, '2014-12-09 16:49:31', '-3.200', '1.600'),
(47, '1', 4, '-0.600', 0, '2014-12-09 16:54:43', '-0.600', '0.300'),
(48, '1', 4, '-0.600', 0, '2014-12-09 17:07:33', '-0.600', '0.300'),
(49, '1', 7, '-20.000', 0, '2014-12-09 20:10:37', '-20.000', '10.000'),
(50, '1', 7, '-20.000', 0, '2014-12-09 20:24:43', '-20.000', '10.000'),
(51, '1', 7, '100.000', 1, '2014-12-09 20:27:24', '100.000', '0.000'),
(52, '1', 7, '-20.000', 0, '2014-12-09 20:28:06', '-20.000', '10.000'),
(53, '1', 7, '-20.000', 0, '2014-12-09 20:33:43', '-20.000', '10.000'),
(54, '1', 7, '-20.000', 0, '2014-12-09 20:34:47', '-20.000', '10.000'),
(55, '1', 7, '1111111.000', 1, '2014-12-09 20:38:10', '1111111.000', '0.000'),
(56, '1', 10, '100.000', 1, '2014-12-09 21:06:21', '100.000', '0.000'),
(57, '1', 10, '90.000', 1, '2014-12-09 21:10:08', '90.000', '0.000'),
(61, '1', 10, '-1.100', 0, '2014-12-09 21:28:18', '88.900', '0.100'),
(62, '1', 10, '10.000', 1, '2014-12-09 21:30:19', '98.900', '0.000'),
(63, '1', 11, '100.000', 1, '2014-12-09 21:36:04', '96.800', '0.000'),
(64, '1', 11, '-8.800', 0, '2014-12-09 21:39:50', '88.000', '8.000'),
(70, '1', 11, '-8.800', 0, '2014-12-09 22:04:47', '79.200', '8.000'),
(71, '1', 11, '-8.800', 0, '2014-12-09 22:05:43', '70.400', '8.000'),
(72, '1', 11, '-8.800', 0, '2014-12-09 22:07:37', '61.600', '8.000'),
(73, '1', 3, '80.000', 1, '2014-12-10 09:21:52', '80.000', '0.000'),
(74, '1', 3, '-0.200', 0, '2014-12-10 09:33:41', '79.800', '0.100'),
(75, '1', 3, '-0.200', 0, '2014-12-10 09:42:20', '79.600', '0.100'),
(76, '1', 3, '-0.200', 0, '2014-12-10 09:43:34', '79.400', '0.100'),
(77, '1', 3, '9.000', 1, '2014-12-10 21:06:43', '88.400', '0.000'),
(81, NULL, 3, '1.000', 1, '2014-12-11 09:55:43', '0.000', '0.000'),
(83, '5', 3, '5.000', 1, '2014-12-11 10:24:42', '93.400', '0.000'),
(84, NULL, 0, '0.000', 0, '0000-00-00 00:00:00', '0.000', '0.000'),
(85, '5', 3, '7.000', 1, '2014-12-11 11:03:29', '100.400', '0.000'),
(86, '5', 3, '1.000', 1, '2014-12-11 11:15:28', '103.400', '0.000'),
(87, '5', 4, '100.000', 1, '2014-12-11 02:07:43', '99.400', '0.000'),
(88, NULL, 4, '500.000', 1, '2014-12-11 03:29:44', '0.000', '0.000');

-- --------------------------------------------------------

--
-- Структура таблицы `vat`
--

CREATE TABLE IF NOT EXISTS `vat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `percent` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `vat`
--

INSERT INTO `vat` (`id`, `percent`) VALUES
(1, 25),
(2, 26),
(3, 10),
(4, 15);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `FK_country_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payment_currency`
--
ALTER TABLE `payment_currency`
  ADD CONSTRAINT `fk_uid_pc1` FOREIGN KEY (`operator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payment_history`
--
ALTER TABLE `payment_history`
  ADD CONSTRAINT `fk_psid_ph0` FOREIGN KEY (`payment_system_id`) REFERENCES `payment_system` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_uid_ph1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_uid_ph2` FOREIGN KEY (`operator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cid_ph3` FOREIGN KEY (`currency_id`) REFERENCES `payment_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `translit`
--
ALTER TABLE `translit`
  ADD CONSTRAINT `FK_to_lang` FOREIGN KEY (`to_lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_from_lang` FOREIGN KEY (`from_lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
