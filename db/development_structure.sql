CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `state` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `payment_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `success` tinyint(1) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `params` text,
  `test` tinyint(1) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20090723223600');

INSERT INTO schema_migrations (version) VALUES ('20090724212133');

INSERT INTO schema_migrations (version) VALUES ('20090724223009');

INSERT INTO schema_migrations (version) VALUES ('20090724223200');