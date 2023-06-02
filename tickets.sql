CREATE TABLE `tickets_status` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(10) NOT NULL,

	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tickets_status` (label) VALUES
	('En attente'),
	('En cours'),
	('Traité')
;

CREATE TABLE `tickets_type` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(10) NOT NULL,

	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tickets_type` (label) VALUES
	('Joueur'),
	('Serveur'),
	('Use-bug')
;

CREATE TABLE `tickets_ticket` (
	`id` int NOT NULL AUTO_INCREMENT,
	`identifier` varchar(46) NOT NULL,
	`type_id` int NOT NULL,
	`status_id` int NOT NULL DEFAULT 1,
	`reported_identifier` varchar(46),
	`description` text NOT NULL,

	PRIMARY KEY (`id`),
	FOREIGN KEY (type_id)
    	REFERENCES tickets_type(id),
	FOREIGN KEY (status_id)
    	REFERENCES tickets_status(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;